import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/main/data/models/image_model.dart';
import '/shared/constants/numbers.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference imagesCollection = FirebaseFirestore.instance.collection(
    'images',
  );

  StreamSubscription<QuerySnapshot>? imagesSubscription;

  MainBloc() : super(MainInitial()) {
    on<MainSaveImageEvent>(_onSaveImageEvent);
    on<MainUpdateImageEvent>(_onUpdateImageEvent);
    on<MainGetImagesEvent>(_onGetImagesEvent);
    on<MainSetImagesEvent>(_onSetImagesEvent);
    on<MainCloseStream>(_onCloseStream);
  }

  Future<void> _onSaveImageEvent(
    MainSaveImageEvent event,
    Emitter<MainState> emit,
  ) async {
    try {
      imagesSubscription?.cancel();
      final image = event.port['image'] as String;

      final imageRef = await imagesCollection.add({
        'fileName': event.port['fileName'],
        'userId': auth.currentUser?.uid,
        'userName': auth.currentUser?.displayName,
      });

      await _setChunks(image, imageRef);

      add(MainGetImagesEvent());

      event.onSuccess();
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<void> _onUpdateImageEvent(
    MainUpdateImageEvent event,
    Emitter<MainState> emit,
  ) async {
    try {
      imagesSubscription?.cancel();

      final imageRef = imagesCollection.doc(event.id);

      final chunksSnapshot = await imageRef.collection('chunks').get();

      final batch = FirebaseFirestore.instance.batch();
      for (final doc in chunksSnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();

      await _setChunks(event.image, imageRef);

      add(MainGetImagesEvent());

      event.onSuccess();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onGetImagesEvent(
    MainGetImagesEvent event,
    Emitter<MainState> emit,
  ) async {
    try {
      imagesSubscription?.cancel();

      imagesSubscription = imagesCollection
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .snapshots()
          .listen((data) async {
            final images = await Future.wait(
              data.docs.map((d) async {
                final chunksSnapshot = await imagesCollection
                    .doc(d.id)
                    .collection('chunks')
                    .orderBy('index')
                    .get();

                final imageBase64 = chunksSnapshot.docs
                    .map((chunk) => chunk.data()['data'])
                    .join();

                return ImageModel.fromMap({
                  'id': d.id,
                  'image': imageBase64,
                  ...d.data() as Map<String, dynamic>,
                });
              }).toList(),
            );
            add(MainSetImagesEvent(images));
          });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onSetImagesEvent(
    MainSetImagesEvent event,
    Emitter<MainState> emit,
  ) async {
    emit(MainLoadedImagesState(event.images));
  }

  Future<void> _onCloseStream(
    MainCloseStream event,
    Emitter<MainState> emit,
  ) async {
    emit(MainInitial());
    imagesSubscription?.cancel().whenComplete(event.onSuccess);
  }

  @override
  Future<void> close() {
    imagesSubscription?.cancel();
    return super.close();
  }

  _setChunks(String image, DocumentReference imageRef) async {
    final List<String> chunks = [];
    for (int i = 0; i < image.length; i += chunkSize) {
      final end = (i + chunkSize < image.length) ? i + chunkSize : image.length;
      final chunkValue = image.substring(i, end);

      chunks.add(chunkValue);
    }

    final batch = FirebaseFirestore.instance.batch();

    chunks.forEachIndexed((index, value) {
      final chunkRef = imageRef.collection('chunks').doc('imageChunk$index');
      batch.set(chunkRef, {'data': value, 'index': index});
    });

    await batch.commit();
  }
}
