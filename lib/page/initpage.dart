import 'package:flutter/material.dart';

import 'package:untitled9_control_gastos/db_admin.dart';
import 'package:untitled9_control_gastos/model/modelgastotruck.dart';
import 'package:untitled9_control_gastos/utils/showmodal_register.dart';

import 'package:untitled9_control_gastos/utils/forms_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  OilExpensive? oilExpensive;




  showDialogForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: MyFormWidget(
            oilExpensive: oilExpensive,
          ),
        );
      },
    ).then((value) {
      setState(() {});
    });
  }

  deleteTask(int taskId) {
    DBAdmin.db.deleteTask(taskId).then((value) {
      if (value > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.indigo,
            content: Row(
              children: const [
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text("Registro eliminado"),
              ],
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HISTORIAL DE GASTOS"),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
              builder: (context) {
                return SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: ShowmodalBottom()));
              },
            ).then((value) => (value) {
              setState(() {

              });
            });
          },child: Icon(Icons.person,color: Colors.white,),),
          SizedBox(height: 10,),
          FloatingActionButton(
            onPressed: () {
              oilExpensive = null;
              showDialogForm();
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: DBAdmin.db.getTasks(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            List<OilExpensive> myList = snap.data;
            return ListView.builder(
              itemCount: myList.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: UniqueKey(),
                  // confirmDismiss: (DismissDirection direction) async{
                  //   return true;
                  // },
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    color: Colors.redAccent,
                  ),
                  // secondaryBackground: Text("Hola 2"),
                  onDismissed: (DismissDirection direction) {
                    deleteTask(myList[index].id!);
                  },
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(myList[index].camionId),
                        Text(myList[index].trabajadorId)
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("S/ ${myList[index].monto.toString()}"),
                        Text(myList[index].fecha)
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        oilExpensive = myList[index];
                        showDialogForm();
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
