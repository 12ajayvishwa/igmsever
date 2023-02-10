part of 'saver_bloc.dart';

abstract class SaverEvent extends Equatable {
  const SaverEvent();

  @override
  List<Object> get props => [];
}

class DownloadingEvent extends SaverEvent {
  final String url;
  DownloadingEvent(this.url);

  @override
  List<Object> get props => [url];
}

class DownloadedEvent extends SaverEvent {
  final String downloadedReel;
  const DownloadedEvent(this.downloadedReel);

  @override
  List<Object> get props => [downloadedReel];
}

class ErrorEvent extends SaverEvent {
  String errorMessage;
  ErrorEvent(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
