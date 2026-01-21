part of 'main_bloc.dart';

abstract class MainEvent {}

class MainSaveImageEvent extends MainEvent {
  final Map<String, dynamic> port;

  final VoidCallback onSuccess;

  MainSaveImageEvent({required this.port, required this.onSuccess});
}

class MainUpdateImageEvent extends MainEvent {
  final String id;
  final String image;

  final VoidCallback onSuccess;

  MainUpdateImageEvent({
    required this.id,
    required this.image,
    required this.onSuccess,
  });
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
