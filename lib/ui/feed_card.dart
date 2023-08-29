
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/feed.dart';

class FeedCard extends  StatelessWidget{

  final Feed feed;

  const FeedCard({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.network(
            //   feed.image.first, // probably will be link to wherever image will be in on firebase
            //   fit: BoxFit.fill,
            // ),

            CachedNetworkImage(
              imageUrl: feed.image.first,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Text(feed.title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(feed.description),
            Row(
              children: [
                Expanded(child: Text(feed.sublocality??'')),
                // SizedBox(width: 10,),
                Text(feed.timestamp!.toDate().toString(), style: TextStyle(color: Colors.grey),)
              ],
            )



            
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }
}