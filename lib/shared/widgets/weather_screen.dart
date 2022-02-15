import 'package:flutter/material.dart';
import 'package:flutter_templates/constants/constants.dart';
import 'package:flutter_templates/constants/theme.dart';
import 'package:flutter_templates/repository/repository.dart';
import 'package:flutter_templates/saved_locations/saved_locations.dart';
import 'package:flutter_templates/shared/shared.dart';
import 'package:flutter_templates/utility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatelessWidget {
  /// # WeatherScreen
  /// Widget to display retrieved data from OpenWeather API.
  /// ---
  /// [required] populated WeatherModel.
  const WeatherScreen({Key? key, required this.weatherData}) : super(key: key);

  final WeatherModel weatherData;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 12, top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lucknow',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        DateFormat('EEE, MMM dd').add_jm().format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  weatherData.current.dt * 1000),
                            ),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SavedLocationPage(),
                              ),
                            );
                          },
                          icon: const FaIcon(FontAwesomeIcons.plus),
                        ),
                        Constants.gap10w,
                        IconButton(
                          onPressed: () {},
                          icon: const FaIcon(FontAwesomeIcons.search),
                        ),
                        Constants.gap10w,
                        IconButton(
                          onPressed: () {},
                          icon: const FaIcon(FontAwesomeIcons.bars),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Constants.gap20h,
              Stack(
                children: [
                  Positioned(
                    top: height * 0.05,
                    left: width * 0.25,
                    // TODO: Make this dynamic and react to weather condition,
                    // If possible have it animated or gradient at least.
                    child: FaIcon(
                      getIconFromWeather(
                          weatherData.current.weather.first.description.name),
                      color: MyTheme.eerieBlack,
                      size: MediaQuery.of(context).size.height * 0.35,
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: Row(
                      children: [
                        Constants.gap40w,
                        const FaIcon(FontAwesomeIcons.umbrella, size: 15),
                        Constants.gap5w,
                        Text(
                          ' ${weatherData.current.uvi.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Constants.gap20w,
                        const Icon(Icons.visibility, size: 15),
                        Constants.gap5w,
                        Text(
                          ' ${weatherData.current.visibility.toString()}m',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Constants.gap20w,
                        const Icon(Icons.compress, size: 15),
                        Constants.gap5w,
                        Text(
                          ' ${weatherData.current.pressure.toString()} hPa',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.7,
                    width: width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              weatherData.current.temp.toStringAsFixed(0),
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                              textScaleFactor: 2.5,
                            ),
                            Text(
                              ' ${weatherData.current.weather.first.main.name}',
                              style: const TextStyle(
                                color: MyTheme.fireOpal,
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            ),
                            Constants.gap10h,
                            Row(
                              children: [
                                Constants.gap10w,
                                // TODO: Make this dynamic,
                                // Based on the temperature change icon
                                // FontAwesome has multiple icons for different
                                // conditions and temperature ranges.
                                FaIcon(
                                  getIconFromTemp(int.parse(weatherData
                                      .current.temp
                                      .toStringAsFixed(0))),
                                  size: 20,
                                ),
                                Constants.gap5w,
                                Text(
                                  ' ${weatherData.current.feelsLike.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Constants.gap20w,
                                const FaIcon(FontAwesomeIcons.water, size: 20),
                                Constants.gap5w,
                                Text(
                                  ' ${weatherData.current.humidity.toString()}%',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Constants.gap20w,
                                const FaIcon(FontAwesomeIcons.wind, size: 20),
                                Constants.gap5w,
                                Text(
                                  ' ${weatherData.current.windSpeed.toString()} m/s',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                weatherData
                                    .current.weather.first.description.name
                                    .replaceAll(RegExp("_"), " "),
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                                textScaleFactor: 1.4,
                              ),
                            ),
                            Constants.gap40h
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // Horizontal View Hourly Weather Data
              Constants.gap40h,
              SizedBox(
                height: height * 0.2,
                width: width,
                child: HourlyWeather(hourlyData: weatherData.hourly),
              ),
              Constants.gap40h,
              // Vertical View Daily Weather Data
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: SizedBox(
                  height: height * 0.51,
                  width: double.infinity,
                  child: DailyWeather(dailyData: weatherData.daily),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
