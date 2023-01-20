import 'package:eoe_fans/models/member.dart';
import 'package:eoe_fans/states/ProfileChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:eoe_fans/common/Global.dart';
import 'package:provider/provider.dart';

class SettingTheme extends StatefulWidget {
  const SettingTheme({Key? key}) : super(key: key);

  @override
  State<SettingTheme> createState() => _SettingThemeState();
}

class _SettingThemeState extends State<SettingTheme> {
  MemberEnum _memberSelect = MemberEnum.zao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("主题"),
        flexibleSpace: Container(
          height: double.maxFinite,
          child: Image(
            image: AssetImage('assets/${_memberSelect.name}/head_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: Stack(
        children: [
          Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Image(
                  image: AssetImage(
                      'assets/head/${MemberEnum.values[index].name}.jpg'),
                  fit: BoxFit.cover,
                ),
              );
            },
            itemCount: MemberEnum.values.length,
            onIndexChanged: (int index) {
              setState(() {
                _memberSelect = MemberEnum.values[index];
                Provider.of<ThemeModel>(context, listen: false).theme = _memberSelect.name;
              });
            },
            pagination: const SwiperPagination(
              alignment: Alignment.bottomRight,
              builder: DotSwiperPaginationBuilder(
                  color: Colors.black12, // 其他点的颜色
                  activeColor: Colors.white,
                  space: 2, // 点与点之间的距离
                  activeSize: 15 // 当前点的大小
                  ),
            ),
          ),
          // Positioned(
              // child: IconButton(
              //   icon: Icon(
              //       Icons.check_box
              //   ),
              // )
          // )
        ],
      ),
    );
  }
}
