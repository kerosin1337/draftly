part of 'main_bloc.dart';

abstract class MainState {}

class MainInitial extends MainState {}

class MainLoadedImagesState extends MainState {
  final List<ImageModel> images;

  MainLoadedImagesState(this.images);
}
