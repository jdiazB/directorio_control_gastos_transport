import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled9_control_gastos/hive/register_adapter.dart';
import 'package:untitled9_control_gastos/page/homepage.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(CamionAdapter());
  Hive.registerAdapter(TrabajadorAdapter());
  Hive.registerAdapter(GastoAdapter());
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "UI-Future",
      home: Homepage(),
    );
  }
}
