import 'package:cjbio/Download/controller/download_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cjbio/download/model/download_model.dart';

class DownloadViewPage extends StatelessWidget {
  DownloadViewPage({Key? key}) : super(key: key);

  FileDownloader controller = Get.put(FileDownloader());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child:  Center(
            child: GetBuilder<FileDownloader>(
              builder: (_) {
                return Column(
                  children: [
                    MaterialButton(
                        child: Text('[put files on task list]'),
                        onPressed: (){
                          print('~put files on task list~');
                          _.setSyncFiles([
                            TaskInfo(name: 'simple pdf',link: 'http://www.africau.edu/images/default/sample.pdf'),
                            TaskInfo(name: 'Learning Android Studio',link: 'http://barbra-coco.dyndns.org/student/learning_android_studio.pdf'),
                          ]);
                        }
                    ),
                    MaterialButton(
                        child: Text('[download start]'),
                        onPressed: (){
                          print('~download start~');
                          _.downloadAllFiles();
                        }
                    ),
                    MaterialButton(
                        child: Text('[download pause]'),
                        onPressed: (){
                          print('~download pause~');
                          _.pauseAllDownload();
                        }
                    ),
                    MaterialButton(
                        child: Text('[download resume]'),
                        onPressed: (){
                          print('~download resume~');
                          _.resumeAllDownload();
                        }
                    ),
                    MaterialButton(
                        child: Text('[show view task]'),
                        onPressed: (){
                          print('~show view task~');
                          _.printSavedTasks();
                        }
                    ),
                    MaterialButton(
                        child: Text('[show package task]'),
                        onPressed: (){
                          print('~show package task~');
                          _.printCurrentTasks();
                        }
                    ),
                    MaterialButton(
                        child: Text('[delete all downloaded files]'),
                        onPressed: (){
                          print('~delete all files~');
                          _.deleteAllFiles();
                        }
                    ),
                  ],
                );
              },
            ),
          ),
        )
      ),
    );
  }
}
