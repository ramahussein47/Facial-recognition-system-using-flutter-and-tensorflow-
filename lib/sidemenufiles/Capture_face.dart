/*import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';


class Capture_face extends StatefulWidget {
  const Capture_face({super.key});

  @override
  State<Capture_face> createState() => _Capture_faceState();
}

class _Capture_faceState extends State<Capture_face> {
  final FaceDetector _faceDetector = GoogleMlKit.vision.faceDetector(
    FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
    ),
  );
  XFile? _imageFile;
  List<Face>? _faces;

  Future<void> _captureImage() async {
    final ImagePicker _picker = ImagePicker();
    // Capture a photo using the camera
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _imageFile = image;
      });
      await _detectFaces(image);
    }
  }

  Future<void> _detectFaces(XFile imageFile) async {
    final inputImage = InputImage.fromFilePath(imageFile.path);
    final List<Face> faces = await _faceDetector.processImage(inputImage);

    setState(() {
      _faces = faces;
    });
  }

  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capture Face'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null)
              Container(
                constraints: BoxConstraints.expand(height: 300),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(File(_imageFile!.path), fit: BoxFit.cover),
                    if (_faces != null)
                      CustomPaint(
                        painter: FacePainter(_faces!, Size(300, 300)),
                      ),
                  ],
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _captureImage,
              child: Text('Capture Image'),
            ),
          ],
        ),
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  final List<Face> faces;
  final Size imageSize;

  FacePainter(this.faces, this.imageSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;

    for (final face in faces) {
      final rect = Rect.fromLTRB(
        face.boundingBox.left,
        face.boundingBox.top,
        face.boundingBox.right,
        face.boundingBox.bottom,
      );

      final scaleX = size.width / imageSize.width;
      final scaleY = size.height / imageSize.height;
      final scaledRect = Rect.fromLTRB(
        rect.left * scaleX,
        rect.top * scaleY,
        rect.right * scaleX,
        rect.bottom * scaleY,
      );

      canvas.drawRect(scaledRect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
*/
