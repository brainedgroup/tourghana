import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourgh/auth/home.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next page after a 2-second delay
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const imagePath = 'assets/image/logo.png';

    return Scaffold(
      body: Container(
        color: const Color(0xFF176C02), // Background color for #176C02
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath), // Display the logo image
              const SizedBox(height: 20),
              Text(
                'TOURGHANA',
                style: GoogleFonts.montserratAlternates(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
