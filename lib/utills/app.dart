import 'dart:io';

import 'package:path_provider/path_provider.dart';

class App {
  Future<void> init() async {
    _directory = await getApplicationDocumentsDirectory();
    print('App; ${_directory.path}');
  }

  static Directory _directory = directory;
  static Directory get directory => _directory;
}
