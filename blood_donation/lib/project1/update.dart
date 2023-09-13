import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final Bloodgrps = ['A-', 'A+', 'B-', 'B+', 'O+', 'O-', 'AB+', 'AB-'];
  String? selectedgrp;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();
  void updateDonor(docid) {
    final data = {
      'Name': donorName.text,
      'Phone': donorPhone.text,
      'Group': selectedgrp
    };
    donor.doc(docid).update(data).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorName.text = args['name'];
    donorPhone.text = args['Phone'];
    selectedgrp = args['Group'];
    final docid = args['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text("UPDATE Donors"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: donorName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Name"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: donorPhone,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Phone Number"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownButtonFormField(
                  value: selectedgrp,
                  decoration: InputDecoration(
                    label: Text("Select Blood Group"),
                  ),
                  items: Bloodgrps.map((e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      )).toList(),
                  onChanged: (val) {
                    selectedgrp = val;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                  onPressed: () {
                    updateDonor(docid);
                  },
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child: Text("UPDATE", style: const TextStyle(fontSize: 20))),
            ),
          ],
        ),
      ),
    );
  }
}
