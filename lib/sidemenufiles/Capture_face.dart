import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:project/sidemenufiles/Face_recongizer.dart';

class RecognitionScreen extends StatefulWidget {
  const RecognitionScreen({Key? key}) : super(key: key);

  @override
  State<RecognitionScreen> createState() => _HomePageState();
}

class _HomePageState extends State<RecognitionScreen> {
  // Variables
  late ImagePicker imagePicker;
  File? _image;
  late FaceDetector faceDetector;
  List<Face> faces = [];
  dynamic image;

  // Face recognizer (you need to define and initialize this based on your specific implementation)
  late FaceRecognizer recognizer;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();

    // Initialize face detector
    faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        enableContours: true,
        enableClassification: true,
      ),
    );

    // Initialize face recognizer (you need to define how the recognizer works)
    recognizer = FaceRecognizer();
  }

  // Capture image using camera
  _imgFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        doFaceDetection();
      });
    }
  }

  // Choose image using gallery
  _imgFromGallery() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        doFaceDetection();
      });
    }
  }

  // Face detection
  doFaceDetection() async {
    if (_image != null) {
      // Remove rotation of camera images
      File rotatedImage = await removeRotation(_image!);

      // Convert to input image for face detection
      final inputImage = InputImage.fromFile(rotatedImage);

      // Passing input to face detector and getting detected faces
      final List<Face> detectedFaces = await faceDetector.processImage(inputImage);
      setState(() {
        faces = detectedFaces;
      });

      // Call the method to perform face recognition on detected faces
      for (Face face in detectedFaces) {
        performFaceRecognition(face);
      }

      // Draw rectangles around detected faces
      drawRectangleAroundFaces();
    }
  }

  // Remove rotation of camera images
  Future<File> removeRotation(File inputImage) async {
    final img.Image? capturedImage = img.decodeImage(await File(inputImage.path).readAsBytes());
    final img.Image orientedImage = img.bakeOrientation(capturedImage!);
    return await File(_image!.path).writeAsBytes(img.encodeJpg(orientedImage));
  }

  // Perform Face Recognition
  performFaceRecognition(Face face) {
    // Assuming `recognizer` has a method to recognize faces
    Uint8List croppedFace = _cropFaceFromImage(face);
    Recognition recognition = recognizer.recognizeFace(croppedFace);

    // Optionally show face registration dialog if needed
    showFaceRegistrationDialogue(croppedFace, recognition);
  }

  // Crop the face from the image (this is a placeholder function)
  Uint8List _cropFaceFromImage(Face face) {
    // Implement cropping logic based on face.boundingBox
    // This is where you would crop the face from the image and return it as Uint8List
    return Uint8List(0); // Replace with actual cropped face data
  }

  // Face Registration Dialogue
  TextEditingController textEditingController = TextEditingController();
  showFaceRegistrationDialogue(Uint8List croppedFace, Recognition recognition) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("FRAS", textAlign: TextAlign.center),
        alignment: Alignment.center,
        content: SizedBox(
          height: 340,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.memory(
                croppedFace,
                width: 200,
                height: 200,
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter Name",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  recognizer.registerFaceInDB(textEditingController.text, recognition.embeddings);
                  textEditingController.text = "";
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Face Registered"),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(200, 40),
                ),
                child: const Text("Register"),
              )
            ],
          ),
        ),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

drawRectangleAroundFaces() async {
  if (_image != null) {
    try {
      // Read the image bytes
      final imageBytes = await _image!.readAsBytes();

      // Decode the image
      final decodedImage = await decodeImageFromList(imageBytes);

      if (decodedImage != null) {
        setState(() {
          // Update the image and faces if necessary
          image = decodedImage;

          // Make sure to update faces here if you need to.
          // For example: faces = _detectFaces(decodedImage);
        });
      } else {
        print("Failed to decode the image.");
      }
    } catch (e) {
      print("Error decoding image: $e");
    }
  } else {
    print("No image selected.");
  }
}



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _image != null
              ? Container(
                  margin: const EdgeInsets.only(top: 100),
                  width: screenWidth - 50,
                  height: screenWidth - 50,
                  child: Image.file(_image!),
                )
              : Container(
                  margin: const EdgeInsets.only(
                      top: 60, left: 30, right: 30, bottom: 0),
  child: image != null
  ? FittedBox(
      child: SizedBox(
        width: image.width.toDouble(),
        height: image.width.toDouble(),
        child: CustomPaint(
          painter: FacePainter(
            facesList: faces,
            imageFile: image,
          ),
        ),
      ),
    )
  : Container(

      height: 200, // or any other size you deem appropriate
      width: 200,  // or any other size you deem appropriate
      color: Colors.grey[300], // Placeholder color or any other widget
      child: Center(
        child: Text("No image selected"),
      ),
    ),


                ),
          Container(
            margin: const EdgeInsets.only(top: 100),
            child: Image.asset(
              "images/logo.png",
              width: screenWidth - 100,
              height: screenWidth - 100,
            ),
          ),
          Container(
            height: 50,
          ),
          // Buttons for choosing and capturing images
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(200))),
                  child: InkWell(
                    onTap: () {
                      _imgFromGallery();
                    },
                    child: SizedBox(
                      width: screenWidth / 2 - 70,
                      height: screenWidth / 2 - 70,
                      child: Icon(Icons.image,
                          color: Colors.blue, size: screenWidth / 7),
                    ),
                  ),
                ),
                Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(200))),
                  child: InkWell(
                    onTap: () {
                      _imgFromCamera();
                    },
                    child: SizedBox(
                      width: screenWidth / 2 - 70,
                      height: screenWidth / 2 - 70,
                      child: Icon(Icons.camera,
                          color: Colors.blue, size: screenWidth / 7),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  List<Face> facesList;
  dynamic imageFile;
  FacePainter({required this.facesList, this.imageFile});

  @override
  void paint(Canvas canvas, Size size) {
    if (imageFile != null) {
      canvas.drawImage(imageFile, Offset.zero, Paint());
    }

    Paint p = Paint();
    p.color = Colors.red;
    p.style = PaintingStyle.stroke;
    p.strokeWidth = 3;

    for (Face face in facesList) {
      canvas.drawRect(face.boundingBox, p);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
