import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_registration_app/alldata.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String name;
  late String address;
  late String phone;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text("Congratullations!"),
              Text("You Have Successfully Logged IN."),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Name",
                  icon: const Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: const Icon(Icons.people),
                  ),
                ),
                onChanged: (input) {
                  setState(
                    () {
                      name = input;
                    },
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Address",
                  icon: const Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: const Icon(Icons.home),
                  ),
                ),
                onChanged: (input) {
                  setState(
                    () {
                      address = input;
                    },
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone",
                  icon: const Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: const Icon(Icons.phone),
                  ),
                ),
                onChanged: (input) {
                  setState(
                    () {
                      phone = input;
                    },
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.blue,
                child: Text("Send Data"),
                onPressed: () {
                  setState(() async {
                    await firestore.collection('Test1').add({
                      'Name': name,
                      'Address': address,
                      'Phone': phone,
                    });
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.teal,
                child: Text("Get Data"),
                onPressed: () {
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AllData()));
                  });
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}






// drawer: Drawer(
      //   child: Column(
      //     children: <Widget>[
      //       UserAccountsDrawerHeader(
      //         currentAccountPicture: CircleAvatar(
      //           backgroundColor: Colors.white,
      //           child: Icon(
      //             Icons.person,
      //             size: 50.0,
      //           ),
      //         ),
      //         accountName: Text('Imam Hasan'),//user name
      //         accountEmail: Text('imam.hasan.diu@gmail.com'),//email
      //       ),
      //       ListTile(
      //         leading: CircleAvatar(
      //           child: Icon(
      //             Icons.person_outline,
      //             color: Colors.white,
      //             size: 30.0,
      //           ),
      //         ),
      //         title: Text("Profile Settings"),
      //         onTap: () {},
      //       ),
      //       ListTile(
      //         leading: CircleAvatar(
      //           child: Icon(
      //             Icons.settings,
      //             color: Colors.white,
      //             size: 30.0,
      //           ),
      //         ),
      //         title: Text("Settings"),
      //         onTap: () {},
      //       ),
      //       Divider(),
      //       ListTile(
      //         leading: CircleAvatar(
      //           child: Icon(
      //             Icons.help_outline,
      //             color: Colors.white,
      //             size: 30.0,
      //           ),
      //         ),
      //         title: Text("About us"),
      //         onTap: () {},
      //       ),
      //       ListTile(
      //         leading: CircleAvatar(
      //           child: Icon(
      //             Icons.cached,
      //             color: Colors.white,
      //             size: 30.0,
      //           ),
      //         ),
      //         title: Text("Recenceter"),
      //         onTap: () {
      //           Navigator.pushNamed(context, '/login');
      //         },
      //       ),
      //       ListTile(
      //         leading: CircleAvatar(
      //           child: Icon(
      //             Icons.exit_to_app,
      //             color: Colors.white,
      //             size: 30.0,
      //           ),
      //         ),
      //         title: Text("Logout"),
      //       ),
      //     ],
      //   ),
      // ),


      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color(0xff6bceff),
      //   onPressed: () {},
      //   child: Icon(Icons.add, color: Colors.white),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home,
      //         color: Color(0xff6bceff),
      //       ),
      //       // ignore: deprecated_member_use
      //       title: Text(
      //         'Home',
      //         style: TextStyle(
      //           color: Color(0xff6bceff),
      //         ),
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.history),
      //       // ignore: deprecated_member_use
      //       title: Text('Histories'),
      //     ),
      //   ],
      // ),