import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiosco_app/models/args_model.dart';
import 'package:kiosco_app/utils/color_palet.dart';
import 'package:kiosco_app/utils/functions.dart';
import 'package:kiosco_app/widgets/textinput_widget.dart';
import 'package:path/path.dart' as path;

class EditProductPage extends StatefulWidget {
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
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

        print('💀 $name');
        print('💀 $basename');
      } else {
        // print('💀 No image selected.');
      }
    });
  }

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

  @override
  Widget build(BuildContext context) {
    final ProdEditArgs args = ModalRoute.of(context).settings.arguments;
    nomController.text = args.product.get('nombre');
    marcaController.text = args.product.get('marca');
    precioController.text = args.product.get('precio').toString();
    contController.text = args.product.get('contenido').toString();
    cantController.text = args.product.get('stock').toString();
    saborController.text = args.product.get('sabor');
    vencController.text = args.product.get('vencimiento');
    dropValue = getValueName(args.product.get('unidad'));

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
                      'Editar Producto',
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
                              child: FutureBuilder(
                                future: getImage(
                                  context: context,
                                  imageName: args.product.get('imagen'),
                                ),
                                builder: (
                                  BuildContext context,
                                  AsyncSnapshot<String> snapshot,
                                ) {
                                  print(
                                      'Nombre edit future : ${args.product.get('imagen')}');
                                  if (snapshot.hasData) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: _image == null
                                            ? Image.network(
                                                snapshot.data,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(_image),
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
                        onTap: () async {
                          try {
                            if (_formKey.currentState.validate()) {
                              await FirebaseFirestore.instance
                                  .collection(
                                      'categorias/${args.colName}/productos')
                                  .doc(args.product.id)
                                  .update({
                                "nombre": nomController.text.trim(),
                                "marca": marcaController.text.trim(),
                                "precio": precioController.text.trim(),
                                "sabor": saborController.text.trim(),
                                "contenido": contController.text.trim(),
                                "stock": cantController.text.trim(),
                                "unidad": getValue(dropValue),
                                "vencimiento": vencController.text.trim(),
                                "imagen": _image == null
                                    ? args.product.get('imagen')
                                    : basename,
                                "disponible": true,
                              });
                              if (_image != null) {
                                try {
                                  await FirebaseStorage.instance
                                      .ref(
                                          'productos/${args.product.get('imagen')}')
                                      .delete()
                                      .then((value) async {
                                    print('borrado');
                                    await FirebaseStorage.instance
                                        .ref('productos/$basename')
                                        .putFile(_image)
                                        .then(
                                      (_) {
                                        Navigator.pushReplacementNamed(
                                            context, 'home');
                                      },
                                    );
                                  });
                                } catch (e) {}
                              }
                            }
                            Future.delayed(Duration(milliseconds: 600), () {
                              Navigator.pushReplacementNamed(context, 'home');
                            });
                          } catch (e) {
                            // print('🥶 $e');
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
