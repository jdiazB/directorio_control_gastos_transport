import 'package:flutter/material.dart';
import 'package:untitled9_control_gastos/db_admin.dart';
import 'package:untitled9_control_gastos/model/modeltruck.dart';

class ShowmodalBottom extends StatefulWidget {

  Camion? camion;
  Trabajador? trabajador;
  ShowmodalBottom({this.trabajador,this.camion});

  @override
  State<ShowmodalBottom> createState() => _ShowmodalBottomState();
}

class _ShowmodalBottomState extends State<ShowmodalBottom> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  TextEditingController _controlleroperario = TextEditingController();
  TextEditingController _controllnuevocamion = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    if(widget.camion != null || widget.trabajador != null){

    _controllnuevocamion.text = widget.trabajador!.trabajador;
    _controllnuevocamion.text = widget.camion!.camion;


    }
  }
  saveTaskregistrar() {
    if(_formKey.currentState!.validate()){

      Trabajador trabajador = Trabajador( trabajador: _controlleroperario.text);

      if(widget.trabajador == null ){
        DBAdmin.db.insertTasktrabajador(trabajador).then((value){
          if(value > 0){
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
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
  saveTaskregistrarCamion() {
    if(_formKey.currentState!.validate()){

      Camion camion = Camion(camion: _controllnuevocamion.text);


      if( widget.camion==null){

        DBAdmin.db.insertTaskcamion(camion).then((value){
          if(value > 0){
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
            unselectedLabelColor: Colors.black26,
            indicatorColor: Colors.white,
            controller: _tabController,
            labelColor: Colors.black,
            tabs: [
              Tab(
                child: Text("Operario",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              Tab(
                child: Text("Camion",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              )
            ]),
        Container(
          height: 200,
          child: Form(
            key: _formKey,
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(height: 2,fontSize: 20),
                        controller: _controlleroperario,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.only(top:20),
                          hintText: "nombre"
                        ),
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(onPressed: () {
                        saveTaskregistrar();


                      }, child: Text("Guardar"),)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(height: 2,fontSize: 20),
                        controller: _controllnuevocamion,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.only(top:20),
                            hintText: "Unidad"
                        ),
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(onPressed: () {
                        saveTaskregistrarCamion();

                      }, child: Text("Guardar"),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
