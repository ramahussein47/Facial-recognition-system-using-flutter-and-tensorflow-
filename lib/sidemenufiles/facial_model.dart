/*import 'package:flutter/material.dart';
import 'dart:io';





class Facial_model extends StatefulWidget {
  @override
  _Facial_modelState createState() => _Facial_modelState();
}

class _Facial_modelState extends State<Facial_model> {
  final ImageCapture _imageCapture = ImageCapture();
  final FacialRecognition _facialRecognition = FacialRecognition();
  final FirebaseService _firebaseService = FirebaseService();
  File? _image;

  @override
  void initState() {
    super.initState();
    _facialRecognition.loadModel();
  }

  Future<void> _captureAndRecognize() async {
    _image = await _imageCapture.getImage();
    if (_image != null) {
      List? recognitions = await _facialRecognition.recognizeFace(_image!.path);
      if (recognitions == null || recognitions.isEmpty) {
        // Assume user is new, upload image to Firebase
        String userId = 'new_user_id';  // Generate or get a user ID
        await _firebaseService.uploadImage(_image!, userId);
      } else {
        // Handle recognized user
        print('User recognized: ${recognitions[0]}');
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facial Recognition'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
            ElevatedButton(
              onPressed: _captureAndRecognize,
              child: Text('Capture and Recognize'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
