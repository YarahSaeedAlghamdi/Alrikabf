
import 'package:alrikabf/Pages/show_page.dart';
import 'package:alrikabf/auth/auth_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,Snapshot){
          if (Snapshot.hasData) {
            return ShowPage();
            
          }else{
            return AuthPage();
          }
        }
      ),
    );
  }
}
