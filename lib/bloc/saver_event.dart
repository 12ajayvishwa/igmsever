part of 'saver_bloc.dart';

abstract class SaverEvent extends Equatable {
  const SaverEvent();

  @override
  List<Object> get props => [];
}

class DownloadingEvent extends SaverEvent {
  final String url;
  DownloadingEvent({required this.url});


  @override 
  List<Object> get props => [url];
} 
