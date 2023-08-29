import 'package:city_scope/resources/app_themes/city_scope_theme.dart';
import 'package:city_scope/ui/feed_screen.dart';
import 'package:city_scope/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'firebase_options.dart';


Position? position;
String? _address = "";
Placemark? placeMark;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await Future.delayed(const Duration(seconds: 2));
  // FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CityScope',
      theme:  CityScopeTheme.getMainAppThemeData,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/home': (context) => FeedScreen(),
        });
  }
}

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  late String imageUrl;

  @override
  Widget build(BuildContext context) {
    backgroundColor: Colors.white;
    return Scaffold(
    appBar: AppBar(
    title: Text('Upload Image', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),
    centerTitle: true,
    elevation: 0.0,
    backgroundColor: Colors.white,
    ),
    body: Container()
    );
  }

  // void _getPlace() async {
  //   List<Placemark> newPlace = await placemarkFromCoordinates(position!.latitude, position!.longitude);
  //
  //   Placemark placeMark  = newPlace[0];
  //   String? name = placeMark.name;
  //   String? subLocality = placeMark.subLocality;
  //   String? locality = placeMark.locality;
  //   String? administrativeArea = placeMark.administrativeArea;
  //   String? postalCode = placeMark.postalCode;
  //   String? country = placeMark.country;
  //   String? address = "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";
  //
  //   print(address);
  //
  //   setState(() {
  //     _address = address; // update _address
  //   });
  // }
  //
  // @override
  // void initState() {
  //
  //   super.initState();
  //   _getPlace();
  //
  // }
}