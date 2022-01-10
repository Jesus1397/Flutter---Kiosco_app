import 'package:flutter/material.dart';
import 'package:kiosco_app/utils/color_palet.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    Key key,
    @required this.name,
    this.icon,
    this.obscureText = false,
    this.typeNumber = false,
    @required this.validator,
    this.controller,
  }) : super(key: key);

  final String name;
  final IconData icon;
  final bool obscureText;
  final bool typeNumber;
  final Function validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: CustomColorDark.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: CustomColorDark.detailsColor,
        keyboardType: typeNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: name,
          icon: Icon(
            icon,
            color: CustomColorDark.detailsColor,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
