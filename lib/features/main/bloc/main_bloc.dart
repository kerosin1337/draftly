import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/main/data/models/image_model.dart';

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
      await imagesCollection.add({
        ...event.port,
        'userId': auth.currentUser?.uid,
        'userName': auth.currentUser?.displayName,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onUpdateImageEvent(
    MainUpdateImageEvent event,
    Emitter<MainState> emit,
  ) async {
    try {
      await imagesCollection.doc(event.id).update({'image': event.image});
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
          .listen((data) {
            final images = data.docs
                .map(
                  (d) => ImageModel.fromMap({
                    'id': d.id,
                    ...d.data() as Map<String, dynamic>,
                  }),
                )
                .toList();
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
}
