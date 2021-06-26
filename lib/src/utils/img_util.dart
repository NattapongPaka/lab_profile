import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
//import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageUtil {
  static ImageUtil instance = ImageUtil.internal();
  factory ImageUtil() => instance;
  ImageUtil.internal();

  final _picker = ImagePicker();

  Future<File> getImage({bool takeCamera = false}) async {
    PickedFile file;
    File outFile;

    try {
      if (takeCamera) {
        file = await _picker.getImage(
          source: ImageSource.camera,
        );
      } else {
        //file = await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 60,maxWidth: 640,maxHeight: 480);
        file = await _picker.getImage(
          source: ImageSource.gallery,
        );
      }
      if (file != null) {
        outFile = await _compressObject(file);
        // var i = decodePng(file.readAsBytesSync());
        // var thumbnail = copyResize(i, width: 640);
        // int size = file.lengthSync();
        // debugPrint("FileSize===$size");
        return outFile;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<File> _compressObject(PickedFile imageFile) async {
    // if(imageFile == null) return null;
    var tempDir = await getTemporaryDirectory();

    var targetPath = path.join(
      tempDir.path,
      await getFileNameWithOutExtension(
        File(imageFile.path),
        '.webp',
      ),
    );

    var resultFile = await FlutterImageCompress.compressAndGetFile(
      imageFile.path,
      targetPath,
      minWidth: 1280,
      minHeight: 720,
      quality: 80,
      format: CompressFormat.webp,
    );

    return resultFile;
  }

  Future<String> getFileExtension(File file) async {
    if (await file.exists()) {
      var ext = path.extension(file.path);

      return ext;
    } else {
      return null;
    }
  }

  Future<String> getFileNameWithExtension(File file) async {
    if (await file.exists()) {
      //To get file name without extension

      //return path.basenameWithoutExtension(file.path)+ext;

      //return file with file extension
      return path.basename(file.path);
    } else {
      return null;
    }
  }

  Future<String> getFileNameWithOutExtension(File file, String ext) async {
    if (await file.exists()) {
      //To get file name without extension

      return path.basenameWithoutExtension(file.path) + ext;

      //return file with file extension
      //return basename(file.path);
    } else {
      return null;
    }
  }
}
