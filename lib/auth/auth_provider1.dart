import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider1 with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  bool accountCreated = false;  // Flag for account creation
  User? _user;

  bool get isLoading => _isLoading;
  User? get user => _user;

  AuthProvider1() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // Method to reset account creation flag
  void resetAccountCreationFlag() {
    accountCreated = false;
    notifyListeners();  // Notify listeners to update the UI
  }

  // Google sign-in method
  Future<void> signInWithGoogle(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in process
        _isLoading = false;
        notifyListeners();
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Google credentials
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      _user = userCredential.user;

      // Store user data in Firestore
      if (_user != null) {
        await _firestore.collection('users').doc(_user!.uid).set({
          'name': _user!.displayName,
          'email': _user!.email,
          'photoUrl': _user!.photoURL,
        });
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      _showError("Failed to sign in with Google. Please try again.");
    }
  }

  // Create account method
  Future<void> createAccount(String email, String password, String name, String phone) async {
    _isLoading = true;
    notifyListeners();

    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'phone': phone,
          'email': email,
        });

        accountCreated = true;  // Set account creation flag to true
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      // Handle errors
      if (e.code == 'email-already-in-use') {
        _showError("The email address is already in use by another account.");
      } else if (e.code == 'weak-password') {
        _showError("The password provided is too weak.");
      } else {
        _showError("An error occurred. Please try again.");
      }
    } catch (e) {
      _showError("An unexpected error occurred.");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sign out method
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
    _user = null;
    notifyListeners();
  }

  // Show error method (for debugging)
  void _showError(String message) {
    debugPrint("Error: $message");
  }
}
