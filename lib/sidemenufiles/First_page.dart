import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:project/sidemenufiles/Bargraph/Records/records.dart';
import 'package:project/sidemenufiles/Capture_face.dart';

class Firstpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FRAS'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                   Card(
                    elevation: 5,

                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Icon(Icons.add_a_photo),
                      title: Text('Register Face'),
                      subtitle: Text('Capture and register a new face in the system.'),
                      onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RecognitionScreen()));
                      },
                    ),
                  ),

                  Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Icon(Icons.history),
                      title: const Text('View Records'),
                      subtitle: Text('View the list of registered faces and past activities.'),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Records_Page()));
                      },
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
