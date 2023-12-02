import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:untitled9_control_gastos/model/modelgastotruck.dart';

class GastosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gastos'),
      ),
      body: FutureBuilder(
        future: Hive.openBox('gastos'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else {
              var box = Hive.box('gastos');
              return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  var gasto = box.getAt(index) as Gasto;
                  return ListTile(
                    title: Text('${gasto.tipo} - ${gasto.monto}'),
                    subtitle: Text('Camión: ${gasto.camionId}, Trabajador: ${gasto.trabajadorId}'),
                  );
                },
              );
            }
          }
          else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}
