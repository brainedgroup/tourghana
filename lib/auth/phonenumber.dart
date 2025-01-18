import 'package:flutter/material.dart';

class PhoneNumberInputField extends StatefulWidget {
  final TextEditingController phoneController;
  final int maxLength; // New parameter for maximum length

  const PhoneNumberInputField({
    super.key,
    required this.phoneController,
    this.maxLength = 10, // Default to 10
  });

  @override
  _PhoneNumberInputFieldState createState() => _PhoneNumberInputFieldState();
}

class _PhoneNumberInputFieldState extends State<PhoneNumberInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity, // Ensures full width
            child: TextField(
              controller: widget.phoneController,
              keyboardType: TextInputType.number,
              maxLength: widget.maxLength, // Set the maximum length
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
                filled: true,
                fillColor: Colors.grey[200],
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(color: Color(0xFF176C02)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(color: Color(0xFF176C02)),
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '+233', // Change this to the desired country code format
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                counterText: '', // Hide the counter text
              ),
              onChanged: (value) {
                // Optionally handle changes
                if (value.length > widget.maxLength) {
                  widget.phoneController.text =
                      value.substring(0, widget.maxLength);
                  widget.phoneController.selection = TextSelection.fromPosition(
                    TextPosition(offset: widget.phoneController.text.length),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
