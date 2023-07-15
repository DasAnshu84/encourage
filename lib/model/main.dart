import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() => runApp(MaterialApp(
      title: "TODO APP",
      home: TODOAPP(),
    ));

class CheckBoxState {
  final String title;
  bool val;

  CheckBoxState({
    required this.title,
    this.val = false,
  });
}

class TODOAPP extends StatefulWidget {
  const TODOAPP({super.key});

  @override
  State<TODOAPP> createState() => _TODOAPPState();
}

class _TODOAPPState extends State<TODOAPP> {
  bool first = false;
  final myController = TextEditingController();
  var list = [];

  void add() {
    setState(() {
      list.add(CheckBoxState(title: myController.text));
      myController.clear();
    });
  }

  void remove(int index) {
    setState(() {
      list.removeAt(index);
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget buildSingleCheckbox(CheckBoxState checkbox) => CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      checkColor: Colors.black,
      activeColor: Colors.amberAccent,
      value: checkbox.val,
      title: Text(
        checkbox.title,
        style: TextStyle(fontSize: 20),
      ),
      onChanged: (value) {
        setState(() => checkbox.val = value!);
      });

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TO DO"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    child: AlertDialog(
                      title: Text("Add a work"),
                      content: TextField(
                        controller: myController,
                        decoration:
                            InputDecoration(hintText: "Enter a work to do"),
                      ),
                      actions: [
                        TextButton(onPressed: add, child: Text('Add')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              myController.clear();
                            },
                            child: Text('Cancel')),
                      ],
                    ),
                  );
                });
          }),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Slidable(
              endActionPane: ActionPane(
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    backgroundColor: Colors.redAccent,
                    icon: Icons.delete,
                    label: 'Delete',
                    onPressed: (context) => remove(index),
                  )
                ],
              ),
              child: buildSingleCheckbox(list[index]));
        },
        itemCount: list.length,
        /*separatorBuilder: (context, index) {
            return Divider(height: 100, thickness: 2);
          }*/
      ),
    );
  }
}
