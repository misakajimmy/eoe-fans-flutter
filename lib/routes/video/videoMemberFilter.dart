import 'package:eoe_fans/common/Global.dart';
import 'package:eoe_fans/models/member.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class VideoMemberFilter extends StatefulWidget {
  const VideoMemberFilter({Key? key, required this.updateFilterMember})
      : super(key: key);

  final ValueChanged<MemberEnum?> updateFilterMember;

  @override
  State<VideoMemberFilter> createState() => _VideoMemberFilterState();
}

class _VideoMemberFilterState extends State<VideoMemberFilter> {
  MemberEnum? _filter;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView.count(
      crossAxisCount: 5,
      childAspectRatio: 1.0,
      children: MemberEnum.values
          .map(
            (m) => GestureDetector(
              onTap: () {
                setState(() {
                  if (_filter ==m) {
                    _filter = null;
                  } else {
                    _filter = m;
                  }
                  widget.updateFilterMember(_filter);
                });
              },
              child: Card(
                elevation: _filter == m ? 6 : 1,
                shadowColor: _filter == m
                    ? HexColor(Global.members[m]?.color ?? '#66CCFF')
                    : null,
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: Center(
                    child: Flex(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Image(
                            image: AssetImage(
                              'assets/${Global.themes.firstWhere((e) => e.id == m.name, orElse: () => Global.themes.first).filter}',
                            ),
                            fit: BoxFit.contain,
                            // fit: BoxFit.fitWidth
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            Global.members[m]?.firstName ?? m.name,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    ));
  }
}
