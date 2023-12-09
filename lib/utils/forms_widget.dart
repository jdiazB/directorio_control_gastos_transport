import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:untitled9_control_gastos/db_admin.dart';
import 'package:untitled9_control_gastos/model/modelgastotruck.dart';
import 'package:untitled9_control_gastos/model/modeltruck.dart';


class MyFormWidget extends StatefulWidget {

  OilExpensive? oilExpensive;
  MyFormWidget({this.oilExpensive,});

  @override
  State<MyFormWidget> createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {

  final _formKey = GlobalKey<FormState>();

  bool isFinished = false;
  final TextEditingController _tipoController = TextEditingController();
  // final TextEditingController _camionController = TextEditingController();
  // final TextEditingController _trabajadorController = TextEditingController();
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  late double valor;

  DateTime _selectedDate = DateTime.now();
  String? _valorselecionadocamion;
  String? _valorselecionadotrabajador;

  @override
  initState(){
    super.initState();
    if(widget.oilExpensive != null){
      _tipoController.text = widget.oilExpensive!.tipo;
      _valorselecionadocamion = widget.oilExpensive!.camionId;
      _valorselecionadotrabajador = widget.oilExpensive!.trabajadorId;
      _montoController.text = widget.oilExpensive!.monto.toString();
      _fechaController.text = widget.oilExpensive!.fecha;



    }
  }



  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate, // Referencia a la fecha actual
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        _fechaController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
  }


  saveTask() {
    if(_formKey.currentState!.validate()){
      OilExpensive oilExpensive = OilExpensive(
        tipo: _tipoController.text,
        camionId: _valorselecionadocamion!,
        trabajadorId: _valorselecionadotrabajador!,
        monto: valor,
        fecha: _fechaController.text
      );
      if(widget.oilExpensive == null){
        DBAdmin.db.insertTask(oilExpensive).then((value){
          if(value > 0){
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                duration: const Duration(milliseconds: 1400),
                content: Row(
                  children: const [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Registrado con éxito",
                    ),
                  ],
                ),
              ),
            );
          }
        });
      }else{
        oilExpensive.id = widget.oilExpensive!.id!;
        DBAdmin.db.updateTask(oilExpensive).then((value){
          if(value > 0){
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                duration: const Duration(milliseconds: 1400),
                content: Row(
                  children: const [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Registrado con éxito",
                    ),
                  ],
                ),
              ),
            );
          }
        });
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    print(DBAdmin.db.getTasksCamion());
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Agregar registro",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 6.0,
            ),
            //widget para ingresar fecha
            InkWell(
              onTap: () => _selectDate(context),
              child: IgnorePointer(
                child: TextFormField(
                  controller: _fechaController,
                  decoration: InputDecoration(hintText: 'Fecha'),
                ),
              ),
            ),
            TextFormField(
              style: TextStyle(height: 2,fontSize: 20),
              controller: _tipoController,
              decoration: InputDecoration(
                isDense: true,
                  contentPadding: EdgeInsets.only(top:20),


                  hintText: "Tipo"),
              validator: (String? value){

                if(value!.isEmpty){
                  return "El campo es obligatorio";
                }

                if(value.length < 6){
                  return "Debe de tener min 6 caracteres";
                }

                return null;
              },
            ),
            const SizedBox(
              height: 15.0,
            ),
            FutureBuilder(
              future: DBAdmin.db.getTasksCamion(),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  List<Camion> myList = snap.data;
                  print(myList);
                    return DropdownButton<String>(
                      isExpanded: true,
                      value: _valorselecionadocamion,
                      style: TextStyle(fontSize: 20,color: Colors.black),
                      padding: EdgeInsets.only(top:10),
                      isDense: true,
                      hint: Text("Selecionar un camion",),
                      items: myList.map((nuevovalue) {
                        return DropdownMenuItem<String>(
                          value: nuevovalue.camion,
                          child: Text(nuevovalue.camion),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _valorselecionadocamion = value;
                        setState(() {});
                      },
                    );
                  }
                else
                  return CircularProgressIndicator();
              },
            ),
            // TextFormField(
            //   style: TextStyle(height: 2,fontSize: 20),
            //   controller: _camionController,
            //   maxLines: 2,
            //   decoration: InputDecoration(hintText: "camion",
            //     isDense: true,
            //     contentPadding: EdgeInsets.only(top:20),),
            //   validator: (String? value){
            //     if(value!.isEmpty){
            //       return "El campo es obligatorio";
            //     }
            //     return null;
            //   },
            // ),
            SizedBox(height: 20,),
            FutureBuilder(
              future: DBAdmin.db.getTasksTrabajador(),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  List<Trabajador> myList = snap.data;
                  print(myList);
                  return DropdownButton<String>(
                    isExpanded: true,
                    value: _valorselecionadotrabajador,
                    style: TextStyle(fontSize: 20,color: Colors.black),
                    padding: EdgeInsets.only(top:10),
                    isDense: true,
                    hint: Text("Selecionar un trabajador",),
                    items: myList.map((nuevovalue) {
                      return DropdownMenuItem<String>(
                        value: nuevovalue.trabajador,
                        child: Text(nuevovalue.trabajador),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _valorselecionadotrabajador = value;
                      setState(() {});
                    },
                  );
                }
                else
                  return CircularProgressIndicator();
              },
            ),
            // TextFormField(
            //   style: TextStyle(height: 2,fontSize: 20),
            //   controller: _trabajadorController,
            //   decoration: InputDecoration(hintText: "trabajador",
            //     isDense: true,
            //     contentPadding: EdgeInsets.only(top:20),),
            //   validator: (String? value){
            //     if(value!.isEmpty){
            //       return "El campo es obligatorio";
            //     }
            //     return null;
            //   },
            // ),
            SizedBox(height: 10,),
            TextFormField(
              style: TextStyle(height: 2,fontSize: 20),
              controller: _montoController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(hintText: "monto",
                isDense: true,
                contentPadding: EdgeInsets.only(top:20),),
              validator: (String? value){
                if(value!.isEmpty){
                  return "El campo es obligatorio";
                }
                return null;
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
              ],
              onChanged: (text) {
                valor = double.parse(text);
              },
            ),
            const SizedBox(
              height: 6.0,
            ),
            // Row(
            //   children: [
            //     const Text("Estado: "),
            //     const SizedBox(
            //       width: 6.0,
            //     ),
            //     Checkbox(
            //       value: isFinished,
            //       onChanged: (value) {
            //         isFinished = value!;
            //         setState(() {});
            //       },
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancelar",
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    saveTask();

                  },
                  child: Text(
                    "Aceptar",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}