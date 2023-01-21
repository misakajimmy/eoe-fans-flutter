import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PicturePage extends StatefulWidget {
  const PicturePage({Key? key}) : super(key: key);

  @override
  State<PicturePage> createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        padding: EdgeInsets.only(bottom: 50),
        child: Image(
          image: AssetImage('assets/jijiji.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
