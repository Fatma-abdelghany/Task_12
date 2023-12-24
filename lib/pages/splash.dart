import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopify/pages/register_tab_pages.dart';

import 'master_page.dart';
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  StreamSubscription<User?>? _listener;

  @override
  void initState() {
    checkUser();
    super.initState();
  }



  void checkUser() async {
    await Future.delayed(const Duration(seconds: 2));
    _listener = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const RegisterTabPages()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const MasterPage()));
      }
    });
  }

  @override
  void dispose() {
    _listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/Logo.png"),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
