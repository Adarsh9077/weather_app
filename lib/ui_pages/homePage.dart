import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/components/weather_item.dart';
import 'package:weather_app/ui_pages/detail_page.dart';
import 'package:weather_app/widgets/constants.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();
  final Constants _constant = Constants();
  static String weather_API_key = '2e9e469410214cb6ada140205250604';

  String location = "Mumbai";
  String weatherIcon = "heavycloudy.png";
  int temperature = 0;
  int humidity = 0;
  int windSpeed = 0;
  int cloud = 0;
  String currentDate = '';

  List hourlyWeatherForecast = [];
  List dailyWeatherForecast = [];

  String currentWeatherStatus = "";

  // api call
  // String searchWeatherAPI =
  //     "http://api.weatherapi.com/v1/current.json?key=$weather_API_key&days=7&q=";
  String searchWeatherAPI =
      "http://api.weatherapi.com/v1/forecast.json?key=$weather_API_key&q=";

  void fetchWeatherData(String searchText) async {
    try {
      var searchResult = await http.get(
        Uri.parse("$searchWeatherAPI$searchText&days=7&aqi=yes"),
      );

      final weatherData = Map<String, dynamic>.from(
        json.decode(searchResult.body) ?? 'No Data',
      );

      var locationData = weatherData["location"];
      var currentWeather = weatherData["current"];

      location = getShortLocationName(locationData['name']);
      var parsedData = DateTime.parse(
        locationData["localtime"].substring(0, 10),
      );
      var newDate = DateFormat("MMMMEEEEd").format(parsedData);
      currentDate = newDate;

      currentWeatherStatus = currentWeather['condition']['text'];
      weatherIcon =
          "${currentWeatherStatus.replaceAll(" ", '').toLowerCase()}.png";

      temperature = currentWeather['temp_c'].toInt();
      humidity = currentWeather['humidity'].toInt();
      windSpeed = currentWeather['wind_kph'].toInt();
      cloud = currentWeather['cloud'].toInt();
      dailyWeatherForecast = weatherData['forecast']['forecastday'];
      if (dailyWeatherForecast.isNotEmpty) {
        hourlyWeatherForecast = dailyWeatherForecast[0]['hour'];
      }
      // print(weatherData['forecast']['forecastday']);

      // print(dailyWeatherForecast[0]['date']);
      // List test = [];
      // test = weatherData['forecast']['forecastday'];
      //
      // print(test.length);
      // print(weatherData);
      // print("object");
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWeatherData(location);
  }

  static String getShortLocationName(String s) {
    List<String> wordList = s.split(" ");
    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return wordList[0] + wordList[1];
      }
      // return wordList["0"];
      else {
        return wordList[0];
      }
    } else {
      return " Error line - 98 ";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        color: _constant.primaryColor.withValues(alpha: 0.2),
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(top: 70, left: 18, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              height: size.height * .7,
              decoration: BoxDecoration(
                gradient: _constant.linearGradientBlue,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: _constant.primaryColor.withValues(alpha: .6),
                    spreadRadius: 5,
                    blurRadius: 12,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/menu.png",
                        width: 38,
                        height: 38,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/pin.png", width: 22),
                          SizedBox(width: 3),
                          Text(
                            location,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          IconButton(
                            onPressed: () {
                              _cityController.clear();
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SingleChildScrollView(
                                    controller: ModalScrollController.of(
                                      context,
                                    ),
                                    child: Container(
                                      height: size.height,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 70,
                                            child: Divider(
                                              thickness: 3,
                                              color: _constant.primaryColor,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          TextField(
                                            onChanged: (searchText) {
                                              fetchWeatherData(searchText);
                                            },
                                            controller: _cityController,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.search,
                                                color: _constant.greyColor,
                                              ),
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  _cityController.clear();
                                                },
                                                child: Icon(Icons.close),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                  color: _constant.greyColor,
                                                ),
                                              ),
                                              hintText: "Location",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          "assets/images/profile.jpg",
                          width: 38,
                          height: 38,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 160,
                    child: Image.asset("assets/images/$weatherIcon"),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Text(
                          temperature.toString(),
                          style: TextStyle(
                            fontSize: 82,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = _constant.shader,
                          ),
                        ),
                      ),
                      Text(
                        'o',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = _constant.shader,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    currentWeatherStatus,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    currentDate,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Divider(color: Colors.white70),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 38, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WeatherItem(
                          value: windSpeed.toInt(),
                          unit: "Km/h",
                          imageURL: "assets/images/windspeed.png",
                        ),
                        WeatherItem(
                          value: humidity.toInt(),
                          unit: "%",
                          imageURL: "assets/images/humidity.png",
                        ),
                        WeatherItem(
                          value: cloud.toInt(),
                          unit: "%",
                          imageURL: "assets/images/cloud.png",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              height: size.height * .225,
              // color: Colors.grey[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "Forecast",
                          style: TextStyle(
                            fontSize: 16,
                            color: _constant.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => DetailPage(
                                    dailyForecastWeather: dailyWeatherForecast,
                                  ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      itemCount: hourlyWeatherForecast.length,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        // print(hourlyWeatherForecast[index][0]);
                        String currentTime = DateFormat(
                          'Hms',
                        ).format(DateTime.now());
                        String currentHour = currentTime.substring(0, 2);
                        String forecastTime =
                            hourlyWeatherForecast[index]['time'].substring(
                              11,
                              16,
                            );
                        String forecastHour =
                            hourlyWeatherForecast[index]['time'].substring(
                              11,
                              13,
                            );
                        String forecastWeatherName =
                            hourlyWeatherForecast[index]["condition"]["text"];
                        String forecastWeatherIcon =
                            "${forecastWeatherName.replaceAll(" ", "").toLowerCase()}.png";
                        String forecastTemperature =
                            hourlyWeatherForecast[index]["temp_c"]
                                .round()
                                .toString();

                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          margin: EdgeInsets.only(right: 12),
                          width: 60,
                          decoration: BoxDecoration(
                            color:
                                currentHour == forecastHour
                                    ? Colors.white
                                    : _constant.primaryColor,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 1),
                                blurRadius: 5,
                                color: _constant.primaryColor.withValues(
                                  alpha: .2,
                                ),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                forecastTime,
                                style: TextStyle(
                                  color: _constant.greyColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Image.asset(
                                "assets/images/$forecastWeatherIcon",
                                width: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    forecastTemperature,
                                    style: TextStyle(
                                      color: _constant.greyColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "o",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _constant.greyColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// part 03 02:00
