import 'package:city_scope/ui/feed_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/user.dart';

class NewSignUp extends StatefulWidget {
  const NewSignUp({super.key});

  @override
  State<NewSignUp> createState() => _NewSignUpState();
}

class _NewSignUpState extends State<NewSignUp> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CityScopeUser _user = CityScopeUser();

  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(),
      
      body: Form(key: _formKey, child: Column(

        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Text("Hello There! Please enter the required information below: ", style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.normal
              ) ,),
            ),
          ),
          SizedBox(height: 50),
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
              onSaved: (value){
                _user.name = value!;
              },
              keyboardType: TextInputType.name,
              // initialValue: 'Your Name',
              decoration: InputDecoration(
                hintText: 'Your Name',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),

          SizedBox(height: 8.0,),

          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              validator: (value){
                if (value != null && value.isNotEmpty){
                  return null;
                } else { return "Required Field.";
              }}, onSaved: (value){
                _user.email = value!;
            },
              keyboardType: TextInputType.emailAddress,
              // initialValue: 'Your email here',
              decoration: InputDecoration(
                hintText: 'Your Email',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),

          SizedBox(height: 8,),

          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              validator: (value){
                if (value != null && value.isNotEmpty){
                  return null;
                } else{
                  return "Required Field";
                }
              },onSaved: (value){
                _user.number = value!;
            },
              keyboardType: TextInputType.phone,
              // initialValue: 'Your Contact Number',
              decoration: InputDecoration(
                hintText: 'Your Number',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              validator: (value){
                if (value != null && value.isNotEmpty){

                  return null;
                } else {

                  return "Required Field";
                }
              },
              onSaved: (value){

                _user.password = value!;

              },
              // initialValue: 'Your password',
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: TextFormField(
              validator: (value){

                if(value != null && value.isNotEmpty){

                  return null;
                } else {

                  return "Required Field.";
                }

              },

              onSaved: (value){

                _user.confirmPassword;
              },

              // initialValue: 'Your password',
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Reconfirm your Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),
          SizedBox(height: 8.0),

          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              ),
              onPressed: () {
                onCreatePressed();
              },
              child: Text('Create Account')),




        ],
      ),






    ));



  }

  void onCreatePressed(){

    var formState = _formKey.currentState;
    if ( formState!.validate()){
      formState.save();

      registerNewUser();


    }
  }

  void registerNewUser() async{

    try {
      final credential = await  FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _user.email,
        password: _user.password,
      );

      FirebaseFirestore.instance.runTransaction((transaction)async{
        transaction.set(FirebaseFirestore.instance.collection('User').doc(credential.user!.uid), _user.toJson());
      }).then((value){
        Navigator.pop(context);
      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
       SnackBar(content: Text('Your Password is too Weak'));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
