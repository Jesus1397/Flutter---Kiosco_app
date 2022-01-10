import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiosco_app/utils/color_palet.dart';

class DrawerItemWidget extends StatelessWidget {
  const DrawerItemWidget({
    Key key,
    this.selected = false,
    @required this.text,
    @required this.icon,
  }) : super(key: key);

  final bool selected;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? CustomColorDark.bgColor : Colors.transparent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: CustomColorDark.detailsColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: FaIcon(
              icon,
              color: Colors.white,
              size: 18,
            ),
          ),
          SizedBox(width: 15),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
