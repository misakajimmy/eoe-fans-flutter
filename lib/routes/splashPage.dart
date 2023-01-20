import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    startTime();
    super.initState();
  }

  startTime() {
    _timer = Timer(Duration(milliseconds: 2000), () {
      _timer.cancel();
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child:  Image(
          image: AssetImage('assets/open/open.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
