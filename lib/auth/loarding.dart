import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
//import 'package:touradmin/auth/login.dart';
import 'package:tourgh/auth/login.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  // Simulate the loading process
  Future<void> loadData() async {
    if (_isDisposed) return;

    await Future.delayed(const Duration(seconds: 2));

    if (!_isDisposed) {
      navigateToNextPage();
    }
  }

  // Function to handle navigation to the next page
  void navigateToNextPage() {
    if (_isDisposed) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Trigger loading after delay
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
          'https://lottie.host/0b95598f-16af-4ce1-a428-b782c9a668b2/GvODoKB1Au.json',
        ),
      ),
    );
  }
}
