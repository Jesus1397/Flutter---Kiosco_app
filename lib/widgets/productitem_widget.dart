import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiosco_app/utils/color_palet.dart';
import 'package:kiosco_app/utils/functions.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    Key key,
    @required this.product,
  }) : super(key: key);

  final QueryDocumentSnapshot product;

  @override
  Widget build(BuildContext context) {
    print('Nombre List product: ${product.get('imagen')}');
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: CustomColorDark.primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              FutureBuilder(
                future: getImage(
                  context: context,
                  imageName: product.get('imagen'),
                ),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      width: 50,
                      height: 50,
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
              SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.get('nombre'),
                    style: TextStyle(
                      color: CustomColorDark.detailsColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$${product.get('precio')}',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ],
          ),
          Icon(
            Icons.arrow_right_sharp,
            color: CustomColorDark.detailsColor,
          ),
        ],
      ),
    );
  }
}
