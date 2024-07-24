import 'package:flutter/material.dart';

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
            Text(
              'Welcome to the Facial Recognition System!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                        // Navigate to Register Face screen
                      },
                    ),
                  ),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Icon(Icons.search),
                      title: Text('Identify Face'),
                      subtitle: Text('Identify faces by capturing and matching with the database.'),
                      onTap: () {
                        // Navigate to Identify Face screen
                      },
                    ),
                  ),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Icon(Icons.history),
                      title: Text('View Records'),
                      subtitle: Text('View the list of registered faces and past activities.'),
                      onTap: () {
                        // Navigate to View Records screen
                      },
                    ),
                  ),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                      subtitle: Text('Adjust system settings and configurations.'),
                      onTap: () {
                        // Navigate to Settings screen
                      },
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle logout action
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
