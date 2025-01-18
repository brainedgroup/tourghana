import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
  });

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField> {
  bool isObscure = false;
  String? errorMessage;

  // Regular expression for email validation
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

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
              // Validate email format
              if (value.isEmpty) {
                setState(() {
                  errorMessage = null; // Clear error if empty
                });
              } else if (!emailRegex.hasMatch(value)) {
                setState(() {
                  errorMessage = 'Please enter a valid email address';
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
              suffixIcon: widget.obscureText
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      child: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                    )
                  : null,
              errorText: errorMessage, // Show error message if exists
            ),
            style: const TextStyle(fontSize: 16), // Increase text size
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
