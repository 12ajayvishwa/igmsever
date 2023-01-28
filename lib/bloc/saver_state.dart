part of 'saver_bloc.dart';

abstract class SaverState extends Equatable {
  const SaverState();
  
  @override
  List<Object> get props => [];
}

class SaverInitial extends SaverState {}

class SaverLoading extends SaverState {}

class SaverLoaded extends SaverState {}

class SaverError extends SaverState {
  String error;
  SaverError({required this.error});

  @override
  List<Object> get props => [error];
}


