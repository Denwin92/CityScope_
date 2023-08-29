import 'package:city_scope/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Feed {
  String description = '';
  String id = '';
  List<String> image = [];
  dynamic location;
  Timestamp? timestamp;
  String title = '';
  String? sublocality;


  Feed();

  Feed.fromJson(Map<String,dynamic> json){
    description = json['description'];
    id = json['id'];
    image = List<String>.from((json['image'] as List).map((e) => e).toList());
    location = json['location'];
    timestamp = json['timestamp'];
    title = json ['title'];
    sublocality = json['sub_locality'];
  }

  Map<String,dynamic> toJson() => {
    "description": description,
    "title": title,
    "image" : image.map((e) => e).toList(),
    "timestamp" : DateTime.now(),
    "location": GeoPoint(position!.latitude, position!.longitude),
    "id" : "",
    "sub_locality" : placeMark?.subLocality

  };

}
