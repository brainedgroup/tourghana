import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tourgh/auth/loarding.dart';
import 'package:tourgh/auth/myTex_tield.dart';
import 'package:tourgh/auth/mytext_field.dart';
import 'package:tourgh/auth/signup.dart';
import 'auth_provider.dart'; // Ensure you have the AuthProvider

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          _buildBackgroundImage(),

          // Semi-transparent overlay
          _buildOverlay(),

          // Foreground content (Login Form)
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
              child: _buildLoginForm(
                  context, authProvider, emailController, passwordController),
            ),
          ),
        ],
      ),
    );
  }

  // Background Image
  Widget _buildBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage('assets/image/flag.jpg'), // Ensure the path is correct
          fit: BoxFit.cover, // Cover the entire screen
        ),
      ),
    );
  }

  // Semi-transparent overlay
  Widget _buildOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
    );
  }

  // Login Form
  Widget _buildLoginForm(
    BuildContext context,
    AuthProvider authProvider,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8), // Box with reduced opacity
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(height: 8),
          _buildSubtitle(),
          const SizedBox(height: 30),
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
          _buildForgotPasswordButton(),
          const SizedBox(height: 10),
          _buildSignInButton(
              authProvider, emailController, passwordController, context),
          const SizedBox(height: 10),
          const Center(child: Text("or sign in with")),
          const SizedBox(height: 10),
          _buildSocialMediaButtons(authProvider),
          const SizedBox(height: 10),
          _buildNoAccountButton(context),
          _buildSignUpButton(context),
        ],
      ),
    );
  }

  // Title Text
  Widget _buildTitle() {
    return Text(
      "Tour into your Account.",
      style: GoogleFonts.inter(
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    );
  }

  // Subtitle Text
  Widget _buildSubtitle() {
    return Text(
      "Sign into your Tour Ghana user account.",
      style: GoogleFonts.inter(
        fontSize: 16,
        color: const Color(0xFF176C02).withOpacity(0.5),
      ),
    );
  }

  // Forgot Password Button
  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Add forgot password functionality here
        },
        child: const Text("Forgot password?"),
      ),
    );
  }

  // Sign In Button
  Widget _buildSignInButton(
    AuthProvider authProvider,
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext context,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: authProvider.isLoading
            ? null
            : () {
                // Call the sign-in method in AuthProvider
                authProvider.signInWithEmail(
                  emailController.text,
                  passwordController.text,
                  context,
                );
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: authProvider.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text("Sign In", style: TextStyle(fontSize: 18)),
      ),
    );
  }

  // Social Media Sign-In Buttons
  Widget _buildSocialMediaButtons(AuthProvider authProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Image.asset('assets/image/google.jpg'),
          onPressed: authProvider.isLoading
              ? null
              : () {
                  // Pass context here to sign in with Google
                  authProvider
                      .signInWithGoogle(const Loading() as BuildContext);
                },
        ),
        IconButton(
          icon: Image.asset('assets/image/apple.png'),
          onPressed: () {
            // Implement Apple sign-in here
          },
        ),
        IconButton(
          icon: Image.asset('assets/image/Vector.png'),
          onPressed: () {
            // Implement Facebook sign-in here
          },
        ),
      ],
    );
  }

  // "I don't have an account" Button
  Widget _buildNoAccountButton(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          // Add your desired functionality here
        },
        child: const Text("I don’t have an account?",
            style: TextStyle(color: Colors.grey)),
      ),
    );
  }

  // Sign Up Button
  Widget _buildSignUpButton(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Signup()),
          );
        },
        child: const Text("Sign Up", style: TextStyle(color: Colors.green)),
      ),
    );
  }
}
