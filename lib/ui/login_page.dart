import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:city_scope/ui/forgot_password_screen.dart';
import 'package:city_scope/ui/new_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import 'feed_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CityScopeUser _user = CityScopeUser();


  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {

      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) {
          return FeedScreen();
        }),(Route<dynamic> route) => false,);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 150.0,
                  child: Image.asset('assets/images/cs_logo1.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "Required Field.";
                      }
                    },
                    onSaved: (value) {
                      _user.email = value!;
                    },
                    keyboardType: TextInputType.emailAddress,
                    // initialValue: 'Your email here',
                    decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "Required Field.";
                      }
                    },
                    onSaved: (value) {
                      _user.password = value!;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    ),
                    onPressed: () {
                      showLoaderDialog(context);
                      onLoginPressed();
                      // Navigator.pop(context);

                    },
                    child: Text('Login')),
                SizedBox(height: 8.0),
                TextButton(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.black54),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                  },
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                          child: Text(
                            'New Here? Create an Account',
                            style: TextStyle(color: Colors.black54),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewSignUp()));
                          },
                        )))
              ],
            )));
  }

  onLoginPressed(){

    var formState = _formKey.currentState;

    if (formState!.validate()){

      formState.save();
      signInWithEmailAndPassword();
      // FeedScreen();
    }

  }

  signInWithEmailAndPassword() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _user.email, password: _user.password);


    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}



// ButtonStyle(
// shape: MaterialStateProperty.all<RoundedRectangleBorder>(
// RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0))
// ),

showLoaderDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}