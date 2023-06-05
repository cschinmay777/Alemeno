import 'package:finalgame/routes/approutes.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: height / 2,
              width: width / 2,
              // margin: EdgeInsets.only(bottom: height / 8),
              child: Lottie.asset("assets/wc.json"),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height / 14,
              width: width / 1.8,
              margin: EdgeInsets.only(bottom: height / 8),
              child: TextButton(
                child: Text(
                  "Share your meal",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "Andika",
                      fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.homescreen);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xff3E8B3A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
