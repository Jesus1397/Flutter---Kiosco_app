import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiosco_app/models/args_model.dart';
import 'package:kiosco_app/utils/color_palet.dart';
import 'package:kiosco_app/utils/functions.dart';
import 'package:kiosco_app/widgets/textinput_widget.dart';
import 'package:path/path.dart' as path;

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nomController;
  TextEditingController marcaController;
  TextEditingController precioController;
  TextEditingController contController;
  TextEditingController cantController;
  TextEditingController saborController;
  TextEditingController vencController;
  String dropValue;
  String basename;

  @override
  void initState() {
    super.initState();
    nomController = TextEditingController();
    marcaController = TextEditingController();
    precioController = TextEditingController();
    contController = TextEditingController();
    cantController = TextEditingController();
    saborController = TextEditingController();
    vencController = TextEditingController();
  }

  @override
  void dispose() {
    nomController.dispose();
    marcaController.dispose();
    precioController.dispose();
    contController.dispose();
    cantController.dispose();
    saborController.dispose();
    vencController.dispose();
    super.dispose();
  }

  File _image;
  final picker = ImagePicker();

  Future getImageFromGalery(String name) async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        basename = '$name-${path.basename(_image.path)}';

        // print('💀 $basename');
      } else {
        // print('💀 No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final NameArgs args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          color: CustomColorDark.bgColor,
          child: Column(
            children: [
              Container(
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
                      'Agregar Producto',
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
              ),
              Form(
                key: _formKey,
                child: Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: CustomColorDark.primaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: _image == null
                                    ? FaIcon(FontAwesomeIcons.question)
                                    : Image.file(_image),
                              ),
                            ),
                            Positioned(
                              bottom: -10,
                              right: -10,
                              child: GestureDetector(
                                onTap: () => getImageFromGalery(
                                  nomController.text.trim(),
                                ),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: CustomColorDark.detailsColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: FaIcon(FontAwesomeIcons.plus),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      TextInputWidget(
                        controller: nomController,
                        name: 'Nombre',
                        icon: FontAwesomeIcons.boxOpen,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese nombre de producto';
                          }
                          return null;
                        },
                      ),
                      TextInputWidget(
                        controller: marcaController,
                        name: 'Marca',
                        icon: FontAwesomeIcons.copyright,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese marca de producto';
                          }
                          return null;
                        },
                      ),
                      TextInputWidget(
                        controller: precioController,
                        name: 'Precio',
                        icon: FontAwesomeIcons.dollarSign,
                        typeNumber: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese precio de producto';
                          }
                          return null;
                        },
                      ),
                      TextInputWidget(
                        controller: saborController,
                        name: 'Sabor',
                        icon: FontAwesomeIcons.cookieBite,
                        validator: null,
                      ),
                      TextInputWidget(
                        controller: contController,
                        name: 'Contenido',
                        icon: FontAwesomeIcons.weight,
                        typeNumber: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese contenido de producto';
                          }
                          return null;
                        },
                      ),
                      TextInputWidget(
                        controller: cantController,
                        name: 'Cantidad',
                        icon: FontAwesomeIcons.cubes,
                        typeNumber: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese cantidad de producto';
                          }
                          return null;
                        },
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: CustomColorDark.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        height: 56,
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.balanceScaleRight,
                              color: CustomColorDark.detailsColor,
                              size: 20,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration:
                                    InputDecoration.collapsed(hintText: ''),
                                value: dropValue,
                                items: <String>[
                                  'Mililitros',
                                  'Litros',
                                  'Gramos',
                                  'Kilos',
                                ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    );
                                  },
                                ).toList(),
                                hint: Text(
                                  "Unidad",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    dropValue = value;
                                  });
                                },
                                validator: (value) => value == null
                                    ? 'Seleccione una opcion'
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextInputWidget(
                        controller: vencController,
                        name: 'Vencimiento',
                        icon: FontAwesomeIcons.calendarAlt,
                        typeNumber: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese vencimiento de producto';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          // print(_image.uri);
                          if (_formKey.currentState.validate()) {
                            FirebaseFirestore.instance
                                .collection(
                              'categorias/${args.name}/productos',
                            )
                                .add(
                              {
                                "nombre": nomController.text.trim(),
                                "marca": marcaController.text.trim(),
                                "precio": precioController.text.trim(),
                                "sabor": saborController.text.trim(),
                                "contenido": contController.text.trim(),
                                "stock": cantController.text.trim(),
                                "unidad": getValue(dropValue),
                                "vencimiento": vencController.text.trim(),
                                "imagen": basename,
                                "disponible": true,
                              },
                            ).then((value) {
                              // print('Ok');
                            });

                            FirebaseStorage.instance
                                .ref()
                                .child('productos')
                                .child(basename)
                                .putFile(_image);
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          width: 140,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: CustomColorDark.detailsColor,
                          ),
                          child: Text('Confirmar'),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red.withOpacity(0.5),
                          ),
                          child: Text('Cancelar'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
