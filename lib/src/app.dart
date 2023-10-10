// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: GoRouter(routes: [
        GoRoute(
            path: '/',
            name: HomeScreen.routeName,
            pageBuilder: (context, state) => NoTransitionPage(
                  child: HomeScreen(),
                ))
      ]),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
