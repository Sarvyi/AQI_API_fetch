import 'package:aqi/data/fetch_data.dart';
import 'package:aqi/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(future: fetchData(),builder: (context, snapshot) {
        if(snapshot.hasData){
          return HomeScreen(snapshot.data!);
        } else {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },),
    );
  }
}
