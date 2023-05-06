import 'dart:io';
import 'package:image/image.dart' as img;

class ImageRotation {
  static File rotate(File imageFile, int rotationCount) {
    final image = img.decodeImage(imageFile.readAsBytesSync())!;
    final rotatedImage = img.copyRotate(image, rotationCount * 90);
    return File(imageFile.path)..writeAsBytesSync(img.encodePng(rotatedImage));
  }
}
