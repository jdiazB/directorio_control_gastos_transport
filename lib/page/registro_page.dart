//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:untitled9_control_gastos/model/modelgastotruck.dart';
//
// class GastosPage extends StatefulWidget {
//   @override
//   State<GastosPage> createState() => _GastosPageState();
// }
//
// class _GastosPageState extends State<GastosPage> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gastos'),
//         actions: [
//           ElevatedButton(onPressed: () async {
//
//           },style: ElevatedButton.styleFrom(backgroundColor: Colors.green)
//           , child: Text("Descargar Excel"))
//         ],
//
//       ),
//       body: FutureBuilder(
//         future: Hive.openBox('gastos'),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError)
//               return Text(snapshot.error.toString());
//             else {
//               var box = Hive.box('gastos');
//               return ListView.builder(
//                 itemCount: box.length,
//                 itemBuilder: (context, index) {
//                   var gasto = box.getAt(index) as Gasto;
//                   return ListTile(
//                     leading: Text("${gasto.id}"),
//                     title: Text('${gasto.tipo} - ${gasto.monto}'),
//                     subtitle: Text('Camión: ${gasto.camionId}, Trabajador: ${gasto.trabajadorId}'),
//                   );
//                 },
//               );
//             }
//           }
//           else
//             return CircularProgressIndicator();
//         },
//       ),
//     );
//   }
// }
