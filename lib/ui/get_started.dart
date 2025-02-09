import 'package:flutter/material.dart';
import 'package:meteo/models/constants.dart';
import 'package:meteo/ui/welcome.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        // ignore: deprecated_member_use
        color: myConstants.primaryColor.withOpacity(.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/get-started.png',
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Welcome()));
              },
              child: Container(
                height: 60,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: myConstants.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
