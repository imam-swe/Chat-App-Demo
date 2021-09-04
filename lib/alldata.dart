import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';

class AllData extends StatefulWidget {
  // const AllData({Key? key}) : super(key: key);

  @override
  _AllDataState createState() => _AllDataState();
}

class _AllDataState extends State<AllData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Data"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Test1")
            .orderBy(timeDilation)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("No Data");
          }
          return ListView(
            // scrollDirection: Axis.vertical,
            // physics: ScrollPhysics(),
            // padding: EdgeInsets.only(top: 24),
            children: snapshot.data!.docs.map((document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Column(
                children: [
                  Text(data["Name"].toString()),
                  Text(data["Address"].toString()),
                  Text(data["Phone"].toString()),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
