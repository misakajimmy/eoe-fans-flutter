import 'package:eoe_fans/common/Global.dart';
import 'package:eoe_fans/models/member.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PictureMemberFilter extends StatefulWidget {
  const PictureMemberFilter(
      {Key? key, required this.filter, required this.updateFilterMember})
      : super(key: key);

  final ValueChanged<MemberEnum?> updateFilterMember;
  final MemberEnum? filter;

  @override
  State<PictureMemberFilter> createState() => _PictureMemberFilterState();
}

class _PictureMemberFilterState extends State<PictureMemberFilter> {
  @override
  void initState() {
    print('reload');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:  GridView.count(
          shrinkWrap: true,
          crossAxisCount: 5,
          childAspectRatio: 1.0,
          children: MemberEnum.values
              .map(
                (m) => GestureDetector(
              onTap: () {
                setState(() {
                  if (widget.filter == m) {
                    widget.updateFilterMember(null);
                  } else {
                    widget.updateFilterMember(m);
                  }
                });
              },
              child: Card(
                elevation: widget.filter == m ? 6 : 1,
                shadowColor: widget.filter == m
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
        ),
      ),
    );
  }
}
