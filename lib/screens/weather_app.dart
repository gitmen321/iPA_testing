import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/control/custom_cards.dart';
import 'package:weather_app/control/information.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/control/secret.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  void initState() {
    getCurrentWeather();
    super.initState();
  }

  Future getCurrentWeather() async {
    try {
    String cityName = 'London';
    final result = await http.get(
      Uri.parse(
          'https://api.weatherapi.com/v1/forecast.json?key=$openWeatherApiKey &q=$cityName&days=1&aqi=no&alerts=no '),
    );
    final data = jsonDecode(result.body);

    if (data['cod'] != '200') {
      throw 'An error occured';
    }

    }
    catch (e) {
    throw e.toString();

    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (kDebugMode) {
                print('Refreshed');
              }
            },
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 8, top: 15),
                      child: Column(
                        children: [
                          Text(
                            '300°K',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 36),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Icon(
                            Icons.cloud,
                            color: Colors.white,
                            size: 60,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Rain',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Weather Forecast',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CustomCard(
                    currentValue: '301',
                    currentTime: '09:00',
                    icon: Icons.sunny,
                  ),
                  CustomCard(
                    currentValue: '301',
                    currentTime: '11:00',
                    icon: CupertinoIcons.cloud_bolt_rain,
                  ),
                  CustomCard(
                    currentValue: '301',
                    currentTime: '08:00',
                    icon: Icons.cloud,
                  ),
                  CustomCard(
                    currentValue: '301',
                    currentTime: '10:00',
                    icon: Icons.cloudy_snowing,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Additional Information',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
            ),
            const SizedBox(
              height: 8,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomInfo(
                  icon: Icons.water_drop,
                  text: 'Humidity',
                  value: '94',
                ),
                CustomInfo(
                  icon: Icons.air,
                  text: 'WindSpeed',
                  value: '7.67',
                ),
                CustomInfo(
                  icon: Icons.beach_access_sharp,
                  text: 'Pressure',
                  value: '1002',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
