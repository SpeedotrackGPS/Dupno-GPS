// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'dart:io';

Future<void> downloadFile() async {
  // Download a single file
  FileDownloader.downloadFile(
    url:
        "https://unsplash.com/photos/a-person-scubas-through-the-water-near-a-rock-formation-llB7NfKnS8A",
    name: "your_file_name.jpg", // Optional: Specify the file name

    onDownloadCompleted: (String path) {
      print('File downloaded to path: $path');
    },
    onDownloadError: (String error) {
      print('Download error: $error');
    },
  );

  // Download multiple files
  final List<File?> result = await FileDownloader.downloadFiles(
    urls: [
      'https://unsplash.com/photos/a-person-scubas-through-the-water-near-a-rock-formation-llB7NfKnS8A',
      'https://unsplash.com/photos/a-person-scubas-through-the-water-near-a-rock-formation-llB7NfKnS8A',
    ],
    isParallel: true,
    onAllDownloaded: () {
      print('All files downloaded');
    },
  );

  // Enable logging
  FileDownloader.setLogEnabled(true);

  // Set maximum parallel downloads
  FileDownloader.setMaximumParallelDownloads(10);
}
