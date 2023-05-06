import 'dart:io';
import 'package:image/image.dart' as img;

void rotateImage(File file, int times) {
  img.Image? image = img.decodeImage(file.readAsBytesSync());

  for (int i = 0; i < times; i++) {
    image = img.copyRotate(image!, 90);
  }

  final encodedImage = img.encodePng(image!);
  final rotatedFile = File(file.path)..writeAsBytesSync(encodedImage);
  file.deleteSync();
  file = rotatedFile;
}
