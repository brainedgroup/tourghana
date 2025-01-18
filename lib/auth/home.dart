import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourgh/auth/login.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const backgroundImagePath = 'assets/image/gh1.jpg'; // Background image path
    const overlayImagePath = 'assets/image/logo.png'; // Overlay image path
    const airplaneIconPath = 'assets/image/fly.png'; // Airplane icon path

    return Scaffold(
      body: Stack(
        children: [
          // Background image layer
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage(backgroundImagePath), // Set the background image
                fit: BoxFit.cover, // Cover the entire screen
              ),
            ),
          ),
          // Green overlay layer
          Container(
            color: const Color(0xFF176C02)
                .withOpacity(0.5), // Green color with transparency
          ),
          // Overlay image at the top center
          Positioned(
            top: 50, // Adjust the top position as needed
            left: MediaQuery.of(context).size.width / 2 -
                50, // Center horizontally
            child: Image.asset(
              overlayImagePath, // Overlay image path
              width: 100, // Set the width of the overlay image
              height: 100, // Set the height of the overlay image
            ),
          ),
          // Column to center the text below the overlay image
          Positioned(
            top: 160, // Adjust this value based on the overlay image height
            left: 0, // Align to the left edge
            right: 0, // Align to the right edge
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TOURGHANA',
                  style: GoogleFonts.montserratAlternates(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 400), // Space between texts
                const Text(
                  'Your All in One app to explore Ghana',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Center text alignment
                ),
                const SizedBox(height: 30), // Space before the button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const LoginPage())); // Add your onPressed function here
                  },
                  icon: Image.asset(
                    airplaneIconPath, // Airplane icon path
                    width: 24, // Icon width
                    height: 24, // Icon height
                  ),
                  label: const Text('Start Touring'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Button background color
                    foregroundColor: const Color(0xFF176C02), // Text color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
