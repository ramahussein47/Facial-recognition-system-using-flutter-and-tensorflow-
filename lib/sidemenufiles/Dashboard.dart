import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

          bottomNavigationBar: BottomNavigationBar(items: const [

         BottomNavigationBarItem(icon: Icon(Icons.home),

         label: 'home'),

                  BottomNavigationBarItem(icon: Icon(Icons.book_online),
                  label: 'Attedance Records'),
                     BottomNavigationBarItem(icon: Icon(Icons.person_2),
                     label: 'Profile'),
          ]),
    );
  }
}
