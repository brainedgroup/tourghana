import 'package:flutter/material.dart';

class MyTextField1 extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;

  const MyTextField1({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon, required bool obscureText,
  });

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField1> {
  bool isObscure = true; // Password fields should start as obscured
  String? errorMessage;

  // Function to validate password criteria
  bool isValidPassword(String password) {
    // Example criteria: at least 8 characters, at least one uppercase letter, one lowercase letter, and one digit
    return password.length >= 8 &&
            password.contains(RegExp(r'[A-Z]')) &&
            password.contains(RegExp(r'[a-z]')) &&
            password.contains(RegExp(r'[0-9]'));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          TextField(
            controller: widget.controller,
            obscureText: isObscure,
            onChanged: (value) {
              // Validate password on change
              if (value.isEmpty) {
                setState(() {
                  errorMessage = null; // Clear error if empty
                });
              } else if (!isValidPassword(value)) {
                setState(() {
                  errorMessage = 'Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, and a digit.';
                });
              } else {
                setState(() {
                  errorMessage = null; // Clear error if valid
                });
              }
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[200],
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0), // Circular corners
                borderSide: const BorderSide(color: Color(0xFF176C02)), // Border color
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0), // Circular corners
                borderSide: const BorderSide(color: Color(0xFF176C02)), // Border color
              ),
              prefixIcon: Icon(
                widget.prefixIcon,
                size: 24.0,
                color: Colors.black,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                child: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
              ),
              errorText: errorMessage, // Show error message if exists
            ),
          ),
          const SizedBox(height: 8), // Add space between TextField and error message
          if (errorMessage != null)
            Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}