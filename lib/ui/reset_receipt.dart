import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetReceipt extends StatefulWidget {
  const ResetReceipt({super.key});

  @override
  State<ResetReceipt> createState() => _ResetReceiptState();
}

class _ResetReceiptState extends State<ResetReceipt> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Align(alignment: Alignment.center,
            child: Text('Thank you! Please check your emails for reset instructions.'),),
          ),

          SizedBox(height: 30,),
          Icon(Icons.facebook)



        ],
      ),


    );
  }
}
