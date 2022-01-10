import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kiosco_app/models/args_model.dart';

import 'color_palet.dart';

Future<String> getImage({
  BuildContext context,
  String imageName = 'question.png',
}) async {
  // storage.ref('Directory/$filename').getDownloadURL();
  String image;
  await FirebaseStorage.instance
      .ref('productos/$imageName')
      .getDownloadURL()
      .then((value) {
    image = value;
  });
  return image;
}

void modalBottomSheet(
  BuildContext context,
  QueryDocumentSnapshot product,
  String colName,
) {
  String day1 = product.get('vencimiento').toString()[0];
  String day2 = product.get('vencimiento').toString()[1];
  String mon1 = product.get('vencimiento').toString()[2];
  String mon2 = product.get('vencimiento').toString()[3];
  String year1 = product.get('vencimiento').toString()[4];
  String year2 = product.get('vencimiento').toString()[5];

  String day = '$day1$day2';
  String mon = '$mon1$mon2';
  String year = '$year1$year2';

  print('day' + day);
  print('mon' + mon);
  print('year' + year);

  Size size = MediaQuery.of(context).size;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        height: size.height * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_sharp,
                      color: CustomColorDark.detailsColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      'editProduct',
                      arguments: ProdEditArgs(
                        product: product,
                        colName: colName,
                      ),
                    );
                  },
                  child: Container(
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: CustomColorDark.detailsColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Precio',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white38,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              product.get('precio').toString(),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cantidad',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white38,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              product.get('stock').toString(),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vencimiento',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white38,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '$day/$mon/$year',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sabor',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white38,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              product.get('sabor').toString(),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  height: 200,
                  child: FutureBuilder(
                    future: getImage(
                      context: context,
                      imageName: product.get('imagen'),
                    ),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              snapshot.data,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.get('nombre'),
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.green,
                  size: 30,
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

String getValue(String unidad) {
  switch (unidad) {
    case 'Mililitros':
      return 'ml';
      break;
    case 'Litros':
      return 'L';
      break;
    case 'Gramos':
      return 'gr';
      break;
    case 'Kilos':
      return 'kg';
      break;
    default:
      return '-';
  }
}

String getValueName(String unidad) {
  switch (unidad) {
    case 'ml':
      return 'Mililitros';
      break;
    case 'L':
      return 'Litros';
      break;
    case 'gr':
      return 'Gramos';
      break;
    case 'kg':
      return 'Kilos';
      break;
    default:
      return '-';
  }
}
