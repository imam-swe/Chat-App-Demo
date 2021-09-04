import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var loginuser = FirebaseAuth.instance.currentUser;

class ChatBoxPage extends StatefulWidget {
//  var userName;
//  ChatBoxPage(var userName){
//    this.userName=userName;
//  }
  @override
  _ChatBoxPageState createState() => _ChatBoxPageState();
}

class _ChatBoxPageState extends State<ChatBoxPage> {
//  var userName;
//  _ChatBoxPageState(var userName){
//    this.userName=userName;
//  }
//  var user;
//  ChatBoxPage(var user){
//    this.user=user;
//  }

//  Service service = Service();
//  final auth = FirebaseAuth.instance;
//
//  //String uname="";
//  //for current user
//  getCurrentUser() {
//    final user = auth.currentUser;
//    if (user != null) {
//      loginuser = user;
//    }
//  }
//
//  @override
//  void initState() {
// ignore: todo
//    // TODO: implement initState
//    super.initState();
//    getCurrentUser();
//  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loginuser!.email.toString()),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signin');
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * .8,
          width: MediaQuery.of(context).size.width * .95,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('User')
                  //.doc(loginuser!.uid)
                  //.doc()
                  //.collection('info')
                  .orderBy('messageTime', descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text("no data");
                }
                return SingleChildScrollView(
                  child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      //shrinkWrap: true,
                      //itemCount:18,
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot documents) {
                        Map<String, dynamic> data =
                            documents.data()! as Map<String, dynamic>;
                        return Column(
                          crossAxisAlignment: loginuser!.email == data['Email']
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: loginuser!.email == data['Email']
                                    ? Colors.blueGrey.withOpacity(0.2)
                                    : Colors.amberAccent.withOpacity(0.4),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        loginuser!.email == data['Email']
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['text'] ?? "",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      Text(
                                        data['user'] ?? "",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            )
                            //Text(data['Last Name'] ?? "rrr "),
                            //Text(data['Gender'] ?? "rrr "),
                            //Text(data['Address'] ?? "rrr "),
                            //Text(data['Contact No'] ?? "rrr "),
                          ],
                        );
                      }).toList()),
                );
              }),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: MediaQuery.of(context).size.height * .08,
          //width: 350,
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.black12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * .8,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Type here",
                  ),
                  onChanged: (value) {
                    text = value;
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .006,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                    onPressed: () async {
                      //final user=await auth.s
                      //final user = await auth.currentUser;
                      //users = user!.email!;
//                      await firestore
//                          .collection('Data')
//                          //.doc(loginuser!.uid)
//                          //.collection('info')
//                          .add({
//                        //'Username':uname,
//                            'messageTime': DateTime.now(),
//                            'text': text,
//                            'Email': loginuser!.email,
//                          })
//                          .then((value) => print(loginuser!.email))
//                          .then((value) => print("text Added"))
//                          .then(
//                              (value) => Navigator.pushNamed(context, '/data'));
                      //UserName uN = new UserName("");
                      //uN.setUser("something");

                      final user = FirebaseAuth.instance.currentUser;
                      print(user!.displayName.toString());
                      //loginuser=user;
                      //final CollectionReference vaultCollection =
                      await FirebaseFirestore.instance
                          .collection('User')
                          //.doc()//loginuser!.email
                          //.collection('info')
                          .add({
//                        'Username': username,
//                        'timeStamp': Timestamp.now()
                            'messageTime': DateTime.now(),
                            'text': text,
                            'Email': loginuser!.email,
                            'user': user.displayName.toString(),
                            //'username': user.displayName
                          })
                          .then((value) => print(loginuser!.email))
                          .then((value) => print(user.displayName.toString()))
                          .then((value) => print("text Added"));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatBoxPage()));
                    },
                    icon: Icon(Icons.send)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
