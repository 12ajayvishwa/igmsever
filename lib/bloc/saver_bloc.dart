import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'saver_event.dart';
part 'saver_state.dart';

class SaverBloc extends Bloc<SaverEvent, SaverState> {
  SaverBloc() : super(SaverInitial()) {
    on<SaverEvent>((event, emit) {
      
    });
    on<DownloadingEvent>((event, emit) {

    });

  }
  void _onDownloading(SaverEvent event,Emitter<SaverState> emit){
  }

}
