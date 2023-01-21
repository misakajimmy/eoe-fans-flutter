import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
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
