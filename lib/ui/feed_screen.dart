import 'package:city_scope/ui/feed_card.dart';
import 'package:city_scope/ui/image_picker.dart';
import 'package:city_scope/ui/log_report_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/feed.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  
  final feedsRef = FirebaseFirestore.instance.collection('Feed').withConverter<Feed>(fromFirestore: (snapshots, _)=> Feed.fromJson(snapshots.data()!) , toFirestore:(feed, _) => feed.toJson());
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LogReportScreen()));
      },
      child: const Icon(Icons.add_a_photo_outlined),
    ),
      
      body: StreamBuilder(stream: feedsRef.snapshots(), builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Feed>> snapshot) {

        if (snapshot.hasError){
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (!snapshot.hasData){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final data =  snapshot.requireData;

        return ListView.separated(itemBuilder:
        (_, index){
          return FeedCard(feed: data.docs[index].data());
        }, separatorBuilder: (_,__){
          return SizedBox(height: 8,);
        }, itemCount: data.size);


      },)
    );
  }
}
