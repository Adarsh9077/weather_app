

import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({
    Key? key,
    required this.value,
    required this.unit,
    required this.imageURL,
  }) : super(key: key);

  final int value;
  final String unit;
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(imageURL),
        ),
        SizedBox(height: 8),
        Text(
          value.toString() + unit,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
