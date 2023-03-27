import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TargetCreate extends StatefulWidget {
  const TargetCreate({super.key});

  @override
  State<TargetCreate> createState() => _TargetCreateState();
}

class _TargetCreateState extends State<TargetCreate> {
  TextEditingController txtName = new TextEditingController();
  TextEditingController txtAmount = new TextEditingController();
  DateTime? date;

  DateTime? get nul => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Card(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("ADD NEW TARGET", textScaleFactor: 1.3),
                SizedBox(height: 20.0),
                Text("Target Name"),
                TextFormField(
                  controller: txtName,
                ),
                SizedBox(height: 20.0),
                Text("Target Amount"),
                TextFormField(
                  controller: txtAmount,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20.0),
                Text("Target Date"),
                ElevatedButton(
                    onPressed: () async {
                      date = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          initialDate: date ?? DateTime.now(),
                          lastDate: DateTime(2500, 9, 7, 17, 30));
                    },
                    child: Text("Select a Date")),
                ButtonBar(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          txtName.clear();
                          txtAmount.clear();
                          date = null;
                        },
                        child: Text("CLEAR")),
                    ElevatedButton(
                        onPressed: () {
                          String name = txtName.text;
                          String amount = txtAmount.text;

                          FirebaseFirestore.instance.collection("targets").add({
                            "name": name,
                            "amount": int.parse(amount),
                            "date": date,
                            "complete": 0,
                            "contribution_total": 0
                          });
                          txtName.clear();
                          txtAmount.clear();
                          date = null;
                        },
                        child: Text("SAVE")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
