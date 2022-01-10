import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiosco_app/models/args_model.dart';
import 'package:kiosco_app/utils/color_palet.dart';

class GridviewItemWidget extends StatelessWidget {
  const GridviewItemWidget({
    Key key,
    @required this.doc,
  }) : super(key: key);

  final QueryDocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          'products',
          arguments: ArgModel(
            id: doc.id,
            name: doc.get('name'),
            colName: doc.get('colName'),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        child: Text(
          doc.get('name'),
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: CustomColorDark.primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
