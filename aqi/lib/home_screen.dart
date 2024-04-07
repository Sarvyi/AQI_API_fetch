import 'dart:ui';
import 'package:aqi/data/air_quality.dart';
import 'package:aqi/painter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final AirQuality airQuality;
  const HomeScreen(this.airQuality, {super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(
            "Weather AQI API",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          centerTitle: true),
      body: SizedBox(
        height: height,
        child: Stack(
          children: [
            // background image
            Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage('assets/back.png'))),
            ),
            // for blurring the background
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                decoration: const BoxDecoration(color: Colors.black12),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight * 2),
              child: SizedBox(
                height: height,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Stack(
                    children: [
                      // AQI Bar indicator
                      CustomPaint(
                        size: Size(width, width),
                        painter: AirQualityPainter(airQuality.aqi),
                      ),
                      
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                              width: 400,
                              height: height * 0.5,
                              child: Column(children: [
                                // AQI
                                Text(
                                  "${airQuality.aqi}, ${airQuality.cityName.split(",")[0]}",
                                  style: TextStyle(
                                      color: airQuality.color == 0 ? Colors.green : (airQuality.color == 1 ? Colors.yellow : (airQuality.color == 2 ? Colors.orange : (airQuality.color == 3 ? Colors.red : (airQuality.color == 4 ? Colors.purple : Color.fromARGB(255, 159, 48, 48))))),
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold),
                                ),
                                // emoji
                                Container(
                                  width: 400,
                                  height: height * 0.25,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/${airQuality.emojiRef}"))),
                                ),
                                Container(
                                  width: 400,
                                  height:
                                      MediaQuery.of(context).size.height * 0.18,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white70,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        airQuality.message!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            height: 1.5,
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                )
                              ]))),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
