import 'package:flutter/material.dart';


import 'package:untitled9_control_gastos/page/initpage.dart';




void main() async {

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Control de gastos unidades",
      home: HomePage(),
    );
  }
}
