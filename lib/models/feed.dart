class Feed {
  String description = '';
  String id = '';
  List<String> image = [];
  dynamic location;
  dynamic timestamp;
  String title = '';

  Feed();

  Feed.fromJson(Map<String,dynamic> json){
    description = json['description'];
    id = json['id'];
    image = List<String>.from((json['image'] as List).map((e) => e).toList());
    location = json['location'];
    timestamp = json['timestamp'];
    title = json ['title'];
  }

  Map<String,dynamic> toJson() => {
    "description": description,
    "title": title,
    "image" : ["https://image-prod.iol.co.za/16x9/800/A-wrecked-white-minibus-and-a-wrecked-white-car-entangled-after-a-head-on-crash?source=https://xlibris.public.prod.oc.inl.infomaker.io:8443/opencontent/objects/285910b6-8fcc-5839-838a-0f3e0fdc22f8&operation=CROP&offset=0x132&resize=1408x792"],
    "timestamp" : DateTime.now(),
    "location": '',
    "id" : "",

  };

}
