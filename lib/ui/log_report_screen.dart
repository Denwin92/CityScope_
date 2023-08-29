// import 'dart:html';
import 'dart:io' as i;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import '../models/feed.dart';
import 'feed_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LogReportScreen extends StatefulWidget {
  const LogReportScreen({super.key});

  @override
  State<LogReportScreen> createState() => _LogReportScreenState();
}

class _LogReportScreenState extends State<LogReportScreen> {
  ImagePicker picker = ImagePicker();
  XFile? image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Feed _feed = Feed();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Text(
                  "Log a new report here: ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            SizedBox(
              height: 8,
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
                   _feed.title = value!;
                },
                keyboardType: TextInputType.text,
                // initialValue: 'Your Name',
                decoration: InputDecoration(
                  hintText: 'Title',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: TextFormField(
                validator: (value) {
                  if (value != null && value.isNotEmpty){
                    return null;
                  } else {
                    return "Required Field.";
                  }
                },
                onSaved: (value){
                  _feed.description = value!;
                },
                keyboardType: TextInputType.multiline,
                // initialValue: 'Your Name',
                decoration: InputDecoration(
                  hintText: 'Description',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
                onPressed: () async {
                  image = await picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    //update UI
                  });
                },
                child: Icon(
                  Icons.add_a_photo_outlined,
                  semanticLabel: 'Attach Image',
                )),
            // image == null
                // ? Container()
                // :
                // Image.file(i.File(image!.path)),
            SizedBox(
              height: 8,
            ),
                Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                    child: Container(
                      height: 250,
                      width: 500,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: (image?.path == null) ? Image.network('https://i.imgur.com/sUFH1Aq.png'): Image.file(i.File(image!.path))
                          ),
                        ),
                      ),
                    ),
                  ),

            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                ),
                onPressed: () { _onSubmitPressed();

                },
                child: Text('Submit Report')),

          ],
        ),
      ),
    );
  }

  void _onSubmitPressed() {
    var formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return Scaffold(backgroundColor: Colors.white.withOpacity(0.5), body: Center(child: SpinKitCircle(color: Colors.indigo),),);
      }));

      FirebaseStorage.instance
          .ref('files/${DateTime.now().millisecondsSinceEpoch}.jpg')
          .putFile(i.File(image!.path))
          .then((value) async {
            _feed.image.add( await value.ref.getDownloadURL());
      FirebaseFirestore.instance.runTransaction((transaction)async{

        transaction.set(FirebaseFirestore.instance.collection('Feed').doc(), _feed.toJson());

      }).then((value){
        Navigator.pop(context);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("Post submitted, please refresh your page.")));

      });


      });
    }
  }

}

