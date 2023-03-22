import 'package:flutter/material.dart';

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
          children: [
            Image.network(
              feed.image.first, // probably will be link to wherever image will be in on firebase
              fit: BoxFit.fill,
            ),
            Text(feed.title),
            Text(feed.description),
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