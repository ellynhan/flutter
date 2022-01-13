import 'dart:isolate';
import 'dart:ui';
import 'dart:async';
import 'dart:io';

import 'package:flutterdownloader/download/model/download_model.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';


class FileDownloader extends GetxController {

  List<TaskInfo>? _tasks;
  late bool _permissionReady;
  late String _localPath;
  ReceivePort _port = ReceivePort();

  FileDownloader(){
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
    _permissionReady = false;
    _prepare();
  }

  //다운로드 해야하는 파일들 가져오기
  void setSyncFiles(List<TaskInfo> tasks){
    _tasks!.addAll(tasks);
  }

  //다운로드 해야하는 파일들 다 다운로드 요청
  void downloadAllFiles() async {
    _tasks?.forEach((task) {
      _requestDownload(task);
    });
  }

  //완료된거 빼고 다 중단
  void pauseAllDownload() async {
    for (TaskInfo info in _tasks!) {
      if (info.status == DownloadTaskStatus.enqueued || info.status == DownloadTaskStatus.running) {
        _pauseDownload(info.taskId!);
        info.status = DownloadTaskStatus.paused;
      }
    }
  }

  //중단됐던거 다시 시작
  void resumeAllDownload() async {
    for (TaskInfo info in _tasks!) {
      if (info.status == DownloadTaskStatus.paused) {
        info.taskId = await _resumeDownload(info.taskId!);
        info.status = DownloadTaskStatus.enqueued;
      }
    }
  }

  void deleteAllFiles() async{
    final tasks = await FlutterDownloader.loadTasks();
    tasks?.forEach((task) {
      _deleteFile(task.taskId);
    });
    _tasks = [];
  }

  void printSavedTasks(){
    String tmp = '';
    for (TaskInfo info in _tasks!) {
      print('name: ${info.name}, link: ${info.link}, status: ${info.status}, progress: ${info.progress}, taskid: ${info.taskId}');
      tmp += 'name: ${info.name}, link: ${info.link}, status: ${info.status}, progress: ${info.progress}, taskid: ${info.taskId}\n';
    }
    update();
  }

  void printCurrentTasks() async {
    String tmp = '';
    final tasks = await FlutterDownloader.loadTasks();
    tasks?.forEach((task) {
      print('name: ${task.filename}, link: ${task.url}, status: ${task.status}, progress: ${task.progress}, taskid: ${task.taskId}');
      tmp += 'name: ${task.filename}, link: ${task.url}, status: ${task.status}, progress: ${task.progress}, taskid: ${task.taskId}\n';
    });
    update();
  }

  void _requestDownload(TaskInfo task) async {
    task.taskId = await FlutterDownloader.enqueue(
      url: task.link!,
      headers: {"auth": "test_for_sql_encoding"},
      savedDir: _localPath,
      showNotification: true,
      openFileFromNotification: true,
      saveInPublicStorage: true,
    );
  }

  void _pauseDownload(String taskId) async {
    await FlutterDownloader.pause(taskId: taskId);
  }

  Future<String?> _resumeDownload(String taskId) async {
    String? newTaskId = await FlutterDownloader.resume(taskId: taskId);
    return newTaskId;
  }

  void _cancelDownload(String taskId) async {
    await FlutterDownloader.cancel(taskId: taskId);
  }

  Future<String?> _retryDownload(String taskId) async {
    String? newTaskId = await FlutterDownloader.retry(taskId: taskId);
    return newTaskId;
  }

  void _deleteFile(String taskId) async {
    await FlutterDownloader.remove(taskId: taskId, shouldDeleteContent: true);
    await _prepare();
    update();
  }

  Future<bool> _checkPermission() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (Platform.isAndroid && androidInfo.version.sdkInt! <= 28) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _retryRequestPermission() async {
    final hasGranted = await _checkPermission();

    if (hasGranted) {
      await _prepareSaveDir();
    }
    //
    _permissionReady = hasGranted;
    update();
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    var externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  Future<Null> _prepare() async {
    final tasks = await FlutterDownloader.loadTasks();

    int count = 0;
    _tasks = [];

    tasks?.forEach((task) {
      _tasks?.add(
        TaskInfo(
          name: task.filename, link: task.url
        )
      );
      _tasks?[count].taskId = task.taskId;
      _tasks?[count].status = task.status;
      _tasks?[count].progress = task.progress;

      count ++;
    });

    _permissionReady = await _checkPermission();

    if (_permissionReady) {
      await _prepareSaveDir();
    }
    update();
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      String? id = data[0];
      DownloadTaskStatus? status = data[1];
      int? progress = data[2];

      if (_tasks != null && _tasks!.isNotEmpty) {
        final task = _tasks!.firstWhere((task) => task.taskId == id);
        task.status = status;
        task.progress = progress;
        update();
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

}
