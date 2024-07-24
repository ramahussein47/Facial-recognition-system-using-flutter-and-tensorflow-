import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/login.dart';
import 'package:project/sidemenufiles/Dashboard.dart';

class Auth_page extends StatefulWidget {
  const Auth_page({super.key});

  @override
  State<Auth_page> createState() => _Auth_pageState();
}

class _Auth_pageState extends State<Auth_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
stream:FirebaseAuth.instance.authStateChanges(),

builder:(context,snapshot){
   if(snapshot.hasData){
      return Homepage();
   }
   else{
      return LoginPage();
   }
}
        ),
    );
  }
}
