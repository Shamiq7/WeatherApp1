//import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';
import 'dart:convert';
import 'dart:ui';

import 'package:app_weather/additionalinfoapp_weather.dart';
import 'package:app_weather/appSecrets.dart';
import 'package:app_weather/appweather_forecast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weatherscreen extends StatefulWidget {
  const Weatherscreen({super.key});

  @override
  State<Weatherscreen> createState() => _WeatherscreenState();
}

class _WeatherscreenState extends State<Weatherscreen> {
  Future getCurrentWeather() async {
    try {
      String cityName = 'London';

      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$openWeatherAPIKey',
        ),
      );
      final data = jsonDecode(res.body);

      if (data['cod'] != 200) {
        throw 'An Unexpected Error Occoured';
      }

      return data;
      //data['main']['temp'];
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
      ),

      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //main card
                SizedBox(
                  width: double.infinity,

                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),

                          child: Column(
                            children: [
                              Text(
                                ' 200 k',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Icon(Icons.cloud, size: 65),
                              const SizedBox(height: 8),
                              Text(
                                'Cloud',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                const Text(
                  'Weather Forecast',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),

                //weather forecast card
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HourlyForecastItem(
                        label: '03:00',
                        icon: Icons.cloud,
                        value: '301.17',
                      ),
                      HourlyForecastItem(
                        label: '04:30',
                        icon: Icons.sunny,
                        value: '200.14',
                      ),
                      HourlyForecastItem(
                        label: '12:00',
                        icon: Icons.cloud,
                        value: '122.19',
                      ),
                      HourlyForecastItem(
                        label: '06:00',
                        icon: Icons.sunny,
                        value: '132.08',
                      ),
                      HourlyForecastItem(
                        label: '09:00',
                        icon: Icons.cloud,
                        value: '320.17',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                //additional info card
                Text(
                  'Additional Infomation',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Additionalinfo_item(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: '98',
                    ),
                    Additionalinfo_item(
                      icon: Icons.wind_power,
                      label: 'Wind Speed',
                      value: '7.3',
                    ),
                    Additionalinfo_item(
                      icon: Icons.umbrella,
                      label: 'Preassure',
                      value: '25atm',
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
