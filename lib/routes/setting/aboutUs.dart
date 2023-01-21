import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

const developers = [
  {'name': '乔治', 'title': '总技术负责人'},
  {'name': '阿正', 'title': '后端负责人'},
  {'name': '艾米莉娅', 'title': '后端开发'},
  {'name': '锋子', 'title': '前端开发'},
  {'name': 'master1lan', 'title': '前端开发'},
  {'name': '御坂吉米', 'title': '移动端开发'},
  {'name': '隔壁PM（Wing）', 'title': '产品经理'},
  {'name': 'UI-阿池', 'title': 'UI设计'},
  {'name': '梁心', 'title': 'LOGO设计'},
];

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(270),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            height: double.maxFinite,
            child: Image(
              alignment: Alignment.topCenter,
              image: AssetImage(
                  'assets/logo.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: ListView(
        children: developers
            .map((e) => ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.manage_accounts_rounded,
                      size: 24,
                    ),
                  ),
                  title: Text(e['title']!),
                  subtitle: Text(e['name']!),
                ))
            .toList(),
      ),
    );
  }
}
