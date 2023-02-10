part of 'saver_bloc.dart';

abstract class SaverState extends Equatable {
  const SaverState();

  @override
  List<Object> get props => [];
}

class DownloadInitialState extends SaverState {}

class DownloadingState extends SaverState {}

class DownloadedState extends SaverState {}

class DownloadErrorState extends SaverState {
  String error;
  DownloadErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
