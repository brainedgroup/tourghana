import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tourgh/auth/loarding.dart';
//import 'package:touradmin/auth/loarding.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;

  // Sign in with email and password
  Future<void> signInWithEmail(
      String email, String password, BuildContext context) async {
    // Validate email and password
    if (!_isValidEmail(email)) {
      _showError(context, "Invalid email address.");
      return;
    }

    if (!_isValidPassword(password)) {
      _showError(context, "Password must be at least 6 characters long.");
      return;
    }

    // Show loading state
    isLoading = true;
    notifyListeners();

    try {
      // Perform the Firebase email sign-in
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Navigate to loading page on successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const Loading()), // Replace with your Loading page
      );
    } catch (e) {
      // Handle sign-in errors
      _showError(context, "Failed to sign in. Please try again.");
    } finally {
      // Hide loading state
      isLoading = false;
      notifyListeners();
    }
  }

  // Sign in with Google
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      // Google sign-in flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // If the sign-in was aborted by the user
        isLoading = false;
        notifyListeners();
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase sign-in with Google credentials
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to loading page on successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const Loading()), // Replace with your Loading page
      );
    } catch (e) {
      // Handle Google sign-in errors
      _showError(context, "Failed to sign in with Google. Please try again.");
    } finally {
      // Hide loading state
      isLoading = false;
      notifyListeners();
    }
  }

  // Email validation (simple regex check)
  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
        .hasMatch(email);
  }

  // Password validation (at least 6 characters long)
  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  // Show error message in SnackBar
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
