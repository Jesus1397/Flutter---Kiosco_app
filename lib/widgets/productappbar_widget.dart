import 'package:flutter/material.dart';
import 'package:kiosco_app/models/args_model.dart';
import 'package:kiosco_app/utils/color_palet.dart';

class ProductAppbarWidget extends StatelessWidget {
  const ProductAppbarWidget({
    Key key,
    @required this.args,
  }) : super(key: key);

  final ArgModel args;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: kToolbarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: CustomColorDark.detailsColor,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Text(
            args.name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
