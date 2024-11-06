import 'package:flutter/material.dart';
import 'package:weatherify/moduls/search_page/other_search_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigoAccent, Colors.cyan],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Weatherify',
              style: TextStyle(
                fontSize: 34.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            // const SizedBox(height: 24.0),
            // Container(
            //   padding: const EdgeInsets.all(12.0),
            // decoration: BoxDecoration(
            //   shape: BoxShape.circle,
            //   color: Colors.white.withOpacity(0.8),
            // ),
            //   child: Image.asset(
            //     'assets/images/logo.png',
            //     height: 120.0,
            //     width: 120.0,
            //   ),
            // ),
            const SizedBox(height: 48.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherSearchScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent[700],
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 80.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                shadowColor: Colors.black54,
                elevation: 10,
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
