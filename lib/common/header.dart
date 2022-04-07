import 'package:flutter/material.dart';

void main() {
  runApp(const header());
}

// ignore: camel_case_types
class header extends StatelessWidget {
  const header({Key key}) : super(key: key);

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: Stack(children: <Widget>[
        Positioned(
          right: -getBiglDiameter(context) / 2,
          bottom: -getBiglDiameter(context) / 2,
          child: Container(
            width: getBiglDiameter(context),
            height: getBiglDiameter(context),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xFFF3E9EE)),
          ),
        ),
        Positioned(
          right: -getSmallDiameter(context) / 3,
          top: -getSmallDiameter(context) / 3,
          child: Container(
            width: getSmallDiameter(context),
            height: getSmallDiameter(context),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 126, 212, 247),
                  Color.fromARGB(255, 36, 109, 218)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
        ),
        Positioned(
          left: -getBiglDiameter(context) / 6,
          top: -getBiglDiameter(context) / 4,
          child: Container(
            child: const Center(
              child: Text(
                "Smart Diary",
                style: TextStyle(
                    fontFamily: "Pacifico", fontSize: 36, color: Colors.white),
              ),
            ),
            width: getBiglDiameter(context),
            height: getBiglDiameter(context),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 126, 212, 247),
                  Color.fromARGB(255, 36, 109, 218)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
        ),
        Positioned(
          right: -getBiglDiameter(context) / 2,
          bottom: -getBiglDiameter(context) / 2,
          child: Container(
            width: getBiglDiameter(context),
            height: getBiglDiameter(context),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xFFF3E9EE)),
          ),
        ),
      ]),
    );
  }
}
