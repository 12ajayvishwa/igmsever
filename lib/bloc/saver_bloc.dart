import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:path_provider/path_provider.dart';
part 'saver_event.dart';
part 'saver_state.dart';

class SaverBloc extends Bloc<SaverEvent, SaverState> {
  FlutterInsta flutterInsta = FlutterInsta();
  bool downloading = false;
  String? downloadedReel;
  int progress = 0;
  SaverBloc() : super(DownloadInitialState()) {
    on<DownloadingEvent>((event, emit) => emit(DownloadingState()));
    on<DownloadedEvent>((event, emit) => emit(DownloadedState()));
    on<ErrorEvent>(
      (event, emit) => emit(DownloadErrorState(error: "")),
    );
  }
  void _onDownloading(
      DownloadingEvent event,
      Emitter<SaverState> emit,
      TextEditingController reelController,
      dynamic status) async {
    var myvideourl = await flutterInsta.downloadReels(reelController.text);
    final externalDir = await getExternalStorageDirectory();
    if (status.isGranted) {
      await FlutterDownloader.enqueue(
        url: '$myvideourl',
        savedDir: externalDir!.path,
        showNotification: true,
        fileName: "Download",
        // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      ).whenComplete(() {
        
      });
    } 
  }
  
 
}
