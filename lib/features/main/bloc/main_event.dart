part of 'main_bloc.dart';

abstract class MainEvent {}

class MainSaveImageEvent extends MainEvent {
  final Map<String, dynamic> port;

  MainSaveImageEvent({required this.port});
}

class MainUpdateImageEvent extends MainEvent {
  final String id;
  final String image;

  MainUpdateImageEvent({required this.id, required this.image});
}

class MainGetImagesEvent extends MainEvent {
  MainGetImagesEvent();
}

class MainSetImagesEvent extends MainEvent {
  final List<ImageModel> images;

  MainSetImagesEvent(this.images);
}

class MainCloseStream extends MainEvent {
  final VoidCallback onSuccess;

  MainCloseStream({required this.onSuccess});
}
