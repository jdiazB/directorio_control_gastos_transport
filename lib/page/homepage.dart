import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:untitled9_control_gastos/model/modelgastotruck.dart';
import 'package:untitled9_control_gastos/page/registro_page.dart';

class Homepage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Registro de Gastos'),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              DropdownButton<String>(
                items: <String>['Camión 1', 'Camión 2', 'Camión 3'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              DropdownButton<String>(
                items: <String>['Trabajador 1', 'Trabajador 2', 'Trabajador 3'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Monto del Gasto',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2025),
                  );
                },
                child: Text('Seleccionar Fecha'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Aquí iría el código para guardar el gasto
                  // Ejemplo de cómo guardar un gasto
                  var gasto = Gasto(id: '1', fecha: DateTime.now(), tipo: 'Materia Prima', monto: 100.0, camionId: '1', trabajadorId: '1');
                  var box = await Hive.openBox('gastos');
                  box.put(gasto.id, gasto);
                },
                child: Text('Guardar Gasto'),
              ),
              ElevatedButton(
                onPressed: ()  {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GastosPage()),
                  );

                },
                child: Text('Historial'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
