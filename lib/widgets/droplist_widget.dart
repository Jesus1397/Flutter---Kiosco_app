// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:kiosco_app/utils/color_palet.dart';

// class DropListWidget extends StatefulWidget {
//   @override
//   _DropListWidgetState createState() => _DropListWidgetState();
// }

// class _DropListWidgetState extends State<DropListWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
//       margin: EdgeInsets.only(bottom: 20),
//       decoration: BoxDecoration(
//         color: CustomColorDark.primaryColor,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       alignment: Alignment.center,
//       height: 56,
//       child: Row(
//         children: [
//           FaIcon(
//             FontAwesomeIcons.balanceScaleRight,
//             color: CustomColorDark.detailsColor,
//             size: 20,
//           ),
//           SizedBox(width: 15),
//           Expanded(
//             child: DropdownButtonFormField<String>(
//               decoration: InputDecoration.collapsed(hintText: ''),
//               value: widget.dropValue,
//               items: <String>[
//                 'Mililitros',
//                 'Litros',
//                 'Gramos',
//                 'Kilos',
//               ].map<DropdownMenuItem<String>>(
//                 (String value) {
//                   return DropdownMenuItem<String>(
//                     value: widget.dropValue,
//                     child: Text(
//                       value,
//                     ),
//                   );
//                 },
//               ).toList(),
//               hint: Text(
//                 "Unidad",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               onChanged: (String value) {
//                 setState(() {
//                   widget.dropValue = value;
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
