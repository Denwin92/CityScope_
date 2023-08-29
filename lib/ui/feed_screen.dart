import 'package:city_scope/main.dart';
import 'package:city_scope/ui/feed_card.dart';
import 'package:city_scope/ui/log_report_screen.dart';
import 'package:city_scope/ui/login_page.dart';
import 'package:city_scope/ui/manage_posts.dart';
import 'package:city_scope/ui/manage_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/feed.dart';
import 'package:geocoding/geocoding.dart';

String _address = ""; // create this variable
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final feedsRef = FirebaseFirestore.instance
      .collection('Feed')
      .orderBy('timestamp', descending: true)
      .withConverter<Feed>(
          fromFirestore: (snapshots, _) => Feed.fromJson(snapshots.data()!),
          toFirestore: (feed, _) => feed.toJson());

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    position = await Geolocator.getCurrentPosition();
    _getPlace();
  }

  void _getPlace() async {
    List<Placemark> newPlace =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);

    placeMark = newPlace[0];
    String? name = placeMark?.name;
    String? subLocality = placeMark?.subLocality;
    String? locality = placeMark?.locality;
    String? administrativeArea = placeMark?.administrativeArea;
    String? postalCode = placeMark?.postalCode;
    String? country = placeMark?.country;
    String? address =
        "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";

    print(address);

    setState(() {
      _address = address; // update _address
    });
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Updates based on your Location'),
          actions: <Widget>[
            PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: Text('Logout')),
                PopupMenuItem<int>(value: 1, child: Text('Manage Profile')),
                PopupMenuItem<int>(value: 2, child: Text('Edit Posts')),

              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LogReportScreen()));
          },
          child: const Icon(Icons.add_a_photo_outlined),
        ),
        body: StreamBuilder(
          stream: feedsRef.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Feed>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final data = snapshot.requireData;

            return ListView.separated(
                itemBuilder: (_, index) {
                  return FeedCard(feed: data.docs[index].data());
                },
                separatorBuilder: (_, __) {
                  return SizedBox(
                    height: 8,
                  );
                },
                itemCount: data.size);
          },
        ));
  }

  void handleClick(int item) {
    switch (item) {
      case 0:
        FirebaseAuth.instance.signOut().then((value) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) {
              return LoginPage();
            }),
            (Route<dynamic> route) => false,
          );
        });
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ManageProfileScreen();
        }));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ManagePostsScreen();
    }));
  }
}}
