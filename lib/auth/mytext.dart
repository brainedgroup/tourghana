import 'package:flutter/material.dart';

class MyText extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;

  const MyText({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon, required bool obscureText,
  });

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyText> {
  String? errorMessage;

  // Validation to ensure input is only alphabetic and under 25 characters
  bool isValidName(String name) {
    return name.length <= 25 && RegExp(r'^[a-zA-Z\s]+$').hasMatch(name);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          TextField(
            controller: widget.controller,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  errorMessage = null; // Clear error if empty
                });
              } else if (!isValidName(value)) {
                setState(() {
                  errorMessage = 'Name should contain only letters and be up to 25 characters.';
                });
              } else {
                setState(() {
                  errorMessage = null; // Clear error if valid
                });
              }
            },
            maxLength: 25,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[200],
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Color(0xFF176C02)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Color(0xFF176C02)),
              ),
              prefixIcon: Icon(
                widget.prefixIcon,
                size: 24.0,
                color: Colors.black,
              ),
              errorText: errorMessage,
            ),
          ),
          const SizedBox(height: 8),
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
