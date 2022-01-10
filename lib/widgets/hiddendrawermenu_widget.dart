import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiosco_app/utils/color_palet.dart';

import 'draweritem_widget.dart';

class HiddenDrawerMenuWidget extends StatelessWidget {
  const HiddenDrawerMenuWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColorDark.primaryColor,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: FaIcon(FontAwesomeIcons.solidUser),
                backgroundColor: CustomColorDark.bgColor,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kiosco App',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Administrador',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              )
            ],
          ),
          Container(
            width: 200,
            padding: EdgeInsets.only(left: 0),
            child: Column(
              children: [
                DrawerItemWidget(
                  icon: FontAwesomeIcons.home,
                  selected: true,
                  text: 'Inicio',
                ),
                DrawerItemWidget(
                  icon: FontAwesomeIcons.cashRegister,
                  selected: false,
                  text: 'Ventas',
                ),
                DrawerItemWidget(
                  icon: FontAwesomeIcons.solidStickyNote,
                  selected: false,
                  text: 'Notas',
                ),
                DrawerItemWidget(
                  icon: FontAwesomeIcons.cog,
                  selected: false,
                  text: 'Configuración',
                ),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(width: 5),
              FaIcon(
                FontAwesomeIcons.moon,
                color: CustomColorDark.detailsColor,
              ),
              Container(
                child: Switch(
                  value: true,
                  activeColor: CustomColorDark.detailsColor,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
