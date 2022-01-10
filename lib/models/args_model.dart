import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArgModel {
  String id;
  String name;
  String colName;

  ArgModel({
    @required this.id,
    @required this.name,
    @required this.colName,
  });
}

class NameArgs {
  final String name;

  NameArgs({@required this.name});
}

class ProdEditArgs {
  final QueryDocumentSnapshot product;
  final String colName;

  ProdEditArgs({@required this.colName, @required this.product});
}
