import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/components/weather_item.dart';
import 'package:weather_app/widgets/constants.dart';

class DetailPage extends StatefulWidget {
  final dailyForecastWeather;

  const DetailPage({super.key, required this.dailyForecastWeather});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Constants _constants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var weatherData = widget.dailyForecastWeather;
    Map getForecastWeather(int index) {
      int maxWindSpeed = weatherData[index]["day"]["maxwind_kph"].toInt();
      int avgHumidity = weatherData[index]["day"]["avghumidity"].toInt();
      int changeOfRain =
          weatherData[index]["day"]["daily_chance_of_rain"].toInt();

      var parsedData = DateTime.parse(weatherData[index]['date']);
      var forecastDate = DateFormat('EEEE,d MMMM').format(parsedData);

      String weatherName = weatherData[index]["day"]["condition"]["text"];
      String weatherIcon =
          "${weatherName.replaceAll(" ", "").toLowerCase()}.png";
      int minTemperature = weatherData[index]["day"]['mintemp_c'].toInt();
      int maxTemperature = weatherData[index]["day"]['maxtemp_c'].toInt();

      var forecastData = {
        'maxWindSpeed': maxWindSpeed,
        'avgHumidity': avgHumidity,
        'changeOfRain': changeOfRain,
        'forecastDate': forecastDate,
        'weatherName': weatherName,
        'weatherIcon': weatherIcon,
        'minTemperature': minTemperature,
        'maxTemperature': maxTemperature,
      };
      return forecastData;
    }
    print(weatherData[0]);

    return Scaffold(
      backgroundColor: _constants.primaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Forecasts", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: _constants.primaryColor,
        elevation: 0.0,

        // toolbarTextStyle: TextStyle(color: Colors.white),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                print("Setting icon Clicked...");
              },
              icon: Icon(Icons.settings, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * .75,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(50),
                  left: Radius.circular(50),
                ),
                color: Colors.white,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    left: 20,
                    right: 20,
                    child: Container(
                      height: 300,
                      width: size.width * .7,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.center,
                          colors: [Color(0xffa9c1f5), Color(0xff6696f5)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withValues(alpha: .1),
                            offset: Offset(0, 25),
                            blurRadius: 3,
                            spreadRadius: -10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            child: Image.asset(
                              "assets/images/${getForecastWeather(0)["weatherIcon"]}",
                              width: 150,
                            ),
                          ),
                          Positioned(
                            top: 152,
                            left: 35,
                            child: Text(
                              "${getForecastWeather(0)["weatherName"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              width: size.width * .8,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["maxWindSpeed"],
                                    unit: "kph",
                                    imageURL: "assets/images/windspeed.png",
                                  ),
                                  WeatherItem(
                                    value: getForecastWeather(0)["avgHumidity"],
                                    unit: "%",
                                    imageURL: "assets/images/humidity.png",
                                  ),
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["changeOfRain"],
                                    unit: "%",
                                    imageURL: "assets/images/lightrain.png",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getForecastWeather(
                                    0,
                                  )["maxTemperature"].toString(),
                                  style: TextStyle(
                                    fontSize: 88,
                                    fontWeight: FontWeight.bold,
                                    foreground:
                                        Paint()..shader = _constants.shader,
                                  ),
                                ),
                                Text(
                                  "o",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35,
                                    foreground:
                                        Paint()..shader = _constants.shader,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 300,
                    left: size.width * .05,
                    child: SizedBox(
                      height: 415,
                      width: size.width * .9,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Card(
                            elevation: 3,
                            margin: EdgeInsets.only(bottom: 20),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                spacing: 10,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        getForecastWeather(
                                          0,
                                        )["forecastDate"].toString(),
                                        style: TextStyle(
                                          color: _constants.primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 10,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${getForecastWeather(0)["minTemperature"]}",
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                "o",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey[500],
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${getForecastWeather(0)["maxTemperature"]}",
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  color:
                                                      _constants.primaryColor,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                "o",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color:
                                                      _constants.primaryColor,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        spacing: 8,
                                        children: [
                                          SizedBox(
                                            width: 25,
                                            child: Image.asset(
                                              "assets/images/${getForecastWeather(0)["weatherIcon"]}",
                                            ),
                                          ),
                                          Text(
                                            "${getForecastWeather(0)["weatherName"]}",
                                          ),
                                        ],
                                      ),
                                      Row(
                                        spacing: 8,
                                        children: [
                                          Text(
                                            "${getForecastWeather(0)["changeOfRain"]}%",
                                          ),
                                          SizedBox(
                                            width: 25,
                                            child: Image.asset(
                                              "assets/images/cloud.png",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Card(
                            elevation: 3,
                            margin: EdgeInsets.only(bottom: 20),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                spacing: 10,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        getForecastWeather(
                                          1,
                                        )["forecastDate"].toString(),
                                        style: TextStyle(
                                          color: _constants.primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 10,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${getForecastWeather(1)["minTemperature"]}",
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                "o",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey[500],
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${getForecastWeather(1)["maxTemperature"]}",
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  color:
                                                      _constants.primaryColor,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                "o",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color:
                                                      _constants.primaryColor,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        spacing: 8,
                                        children: [
                                          SizedBox(
                                            width: 25,
                                            child: Image.asset(
                                              "assets/images/${getForecastWeather(1)["weatherIcon"]}",
                                            ),
                                          ),
                                          Text(
                                            "${getForecastWeather(1)["weatherName"]}",
                                          ),
                                        ],
                                      ),
                                      Row(
                                        spacing: 8,
                                        children: [
                                          Text(
                                            "${getForecastWeather(1)["changeOfRain"]}%",
                                          ),
                                          SizedBox(
                                            width: 25,
                                            child: Image.asset(
                                              "assets/images/cloud.png",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Card 3 start
                          Card(
                            elevation: 3,
                            margin: EdgeInsets.only(bottom: 20),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                spacing: 10,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        getForecastWeather(
                                          2,
                                        )["forecastDate"].toString(),
                                        style: TextStyle(
                                          color: _constants.primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 10,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${getForecastWeather(2)["minTemperature"]}",
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                "o",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey[500],
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${getForecastWeather(2)["maxTemperature"]}",
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  color:
                                                      _constants.primaryColor,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                "o",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color:
                                                      _constants.primaryColor,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        spacing: 8,
                                        children: [
                                          SizedBox(
                                            width: 25,
                                            child: Image.asset(
                                              "assets/images/${getForecastWeather(2)["weatherIcon"]}",
                                            ),
                                          ),
                                          Text(
                                            "${getForecastWeather(2)["weatherName"]}",
                                          ),
                                        ],
                                      ),
                                      Row(
                                        spacing: 8,
                                        children: [
                                          Text(
                                            "${getForecastWeather(2)["changeOfRain"]}%",
                                          ),
                                          SizedBox(
                                            width: 25,
                                            child: Image.asset(
                                              "assets/images/cloud.png",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//25:00 part 3
