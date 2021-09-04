import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_registration_app/sing_in_page.dart';
//import '../log_in/login_screen.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final auth = FirebaseAuth.instance;
  late String email;
  late String password;

  TextEditingController _passwordController = new TextEditingController();

  // void _submit() async{
  //   try{
  //     final user=await auth.createUserWithEmailAndPassword(
  //         email: email,
  //         password: password
  //     ).then((value) => Navigator.pushNamed(context,'/')
  //     );
  //   }catch(e){
  //     print(e);
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: Text('Sign Up'),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            child: Row(
              children: <Widget>[Text('Login'), Icon(Icons.person)],
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                height: 400,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //Name
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Name'),
                          keyboardType: TextInputType.name,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Please enter your name!';
                          //   }
                          //   return null;
                          // },
                          //onSaved: (value) {},
                        ),

                        //Email
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'invalid email!\nPlease try again with correct email address.';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value;
                          },
                        ),

                        //Password
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                value.length <= 7 ||
                                value.length >= 50) {
                              return 'invalid password';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            password = value;
                          },
                        ),

                        //Confirm Password
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          // validator: (value) {
                          //   if (value!.isEmpty ||
                          //       value != _passwordController.text) {
                          //     return 'invalid password';
                          //   }
                          //   return null;
                          // },
                          //onSaved: (value) {},
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        // ignore: deprecated_member_use
                        RaisedButton(
                          child: Text('submit'),
                          onPressed: () async {
                            //_submit();
                            await auth
                                .createUserWithEmailAndPassword(
                                    email: email, password: password)
                                .then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen())));
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.blue,
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
