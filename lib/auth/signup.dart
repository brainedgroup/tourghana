import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tourgh/auth/auth_provider1.dart';
import 'package:tourgh/auth/login.dart';
import 'package:tourgh/auth/myTex_tield.dart';
import 'package:tourgh/auth/mytext.dart';
import 'package:tourgh/auth/mytext_field.dart';
import 'package:tourgh/auth/phonenumber.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider1>(context);

    // Listen for successful account creation and navigate to LoginPage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authProvider.accountCreated) {
        authProvider.resetAccountCreationFlag(); // Reset the flag
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/image/flag.jpg'), // Ensure the path is correct
                fit: BoxFit.cover, // Cover the entire screen
              ),
            ),
          ),
          // Semi-transparent overlay
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Foreground content
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tour into your Account.",
                      style: GoogleFonts.inter(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Sign into your Tour Ghana user account.",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: const Color(0xFF176C02).withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Full Name field
                    MyText(
                      controller: nameController,
                      hintText: 'Full Name',
                      obscureText: false,
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(height: 10),

                    // Phone Number field
                    PhoneNumberInputField(
                      phoneController: phoneController,
                    ),

                    const SizedBox(height: 10),
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(height: 10),
                    MyTextField1(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      prefixIcon: Icons.lock,
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Forgot password?"),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Sign Up button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: authProvider.isLoading
                            ? null
                            : () async {
                                await authProvider.createAccount(
                                  emailController.text,
                                  passwordController.text,
                                  nameController.text,
                                  phoneController.text,
                                );

                                // Clear the text fields after the account is created
                                nameController.clear();
                                phoneController.clear();
                                emailController.clear();
                                passwordController.clear();
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: authProvider.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text("Sign Up",
                                style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Center(child: Text("or sign in with")),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.asset('assets/image/google.jpg'),
                          onPressed: authProvider.isLoading
                              ? null
                              : () {
                                  authProvider.signInWithGoogle(context);
                                },
                        ),
                        IconButton(
                          icon: Image.asset(
                              'assets/image/apple.png'), // Placeholder
                          onPressed: () {
                            // Implement Apple sign-in here
                          },
                        ),
                        IconButton(
                          icon: Image.asset(
                              'assets/image/Vector.png'), // Placeholder
                          onPressed: () {
                            // Implement Facebook sign-in here
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("I have an account?",
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text("Log in",
                            style: TextStyle(color: Colors.green)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
