import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourgh/auth/welcome.dart';
import 'package:tourgh/auth/auth_provider.dart';
import 'package:tourgh/auth/auth_provider1.dart';
// import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
            create: (_) => AuthProvider1()), // Placeholder provider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 8, 1, 19)),
        useMaterial3: true,
      ),
      home: const Welcome(),
    );
  }
}
