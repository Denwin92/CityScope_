import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/globals.dart';
import 'log_report_screen.dart';

class ManageProfileScreen extends StatefulWidget {
  const ManageProfileScreen({super.key});

  @override
  State<ManageProfileScreen> createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Center(child: Text("Personal Details")),
        //   backgroundColor: Colors.white
        // ),
        body: Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Text(
          'Personal Details',
          style: TextStyle(
              fontSize: 22, fontFamily: GoogleFonts.lato().fontFamily),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username',
                  style: TextStyle(color: Colors.black45),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(Globals.cityScopeUser.id, style: TextStyle(color: Colors.black45),),
                Divider(
                  color: Colors.black,
                ),
                Text(
                  'Full Name',
                  style: TextStyle(color: Colors.black45),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(Globals.cityScopeUser.name),
                Divider(
                  color: Colors.black,
                ),
                Text(
                  'Email Address',
                  style: TextStyle(color: Colors.black45),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(Globals.cityScopeUser.email),
                Divider(
                  color: Colors.black,
                ),
                Text(
                  'Contact Number',
                  style: TextStyle(color: Colors.black45),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(Globals.cityScopeUser.number),
                Divider(
                  color: Colors.black,
                ),
                Text(
                  'Update Password',
                  style: TextStyle(color: Colors.black45),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(Globals.cityScopeUser.password),
              ],
            ),
          ),
        ),
        SizedBox(height: 350),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogReportScreen()));
              },
              child: Icon(Icons.edit_note_sharp),
            ),
          ),
        )
      ],
    ));
  }
}
