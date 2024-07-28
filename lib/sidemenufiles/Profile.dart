import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                maxRadius: 50,
                backgroundColor: Colors.grey,
                child: Text('Add image', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Username',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'ramadhan',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {

              },
            ),
         const    Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Handle logout tap
              },
            ),
          ],
        ),
      ),
    );
  }
}
