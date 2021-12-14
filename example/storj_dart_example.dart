import 'dart:io';

import 'package:storj_dart/storj_dart.dart';

final accessToken = 'your_access';
final bucketName = 'bucket-name';
final filepath = 'path/to/file.txt';

void main() {
  // This must be called initially, and you need to provide a path to a precompiled
  // version of the uplink-c library. This could for example be loaded from your documents folder.
  // See the readme for more information
  loadDynamicLibrary('libuplinkc.so');

  var access = DartUplinkAccess.parseAccess(accessToken);
  print(access.serialize());
  var project = DartUplinkProject.openProject(access);
  var download = project.downloadObject(bucketName, filepath);
  var size = download.info().system.content_length;
  print(size);
  var file = download.read(size);

  download.close();
  project.close();

  File('downloaded.txt').writeAsBytes(file);
  print(file.length);

  // Share file (create new access)
  var newAccess = access.share(DartUplinkPermission.readOnlyPermission(),
      [DartUplinkUplinkSharePrefix(bucketName, filepath)]);
  print(newAccess.serialize());

  // Get file info using new access
  var newProject = DartUplinkProject.openProject(newAccess);
  var newDownload = newProject.downloadObject(bucketName, filepath);
  print(newDownload.info().system.content_length);
  newDownload.close();
  newProject.close();
}
