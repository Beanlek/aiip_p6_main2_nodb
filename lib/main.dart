// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'src/app.dart';

void main() {
  const myApp = MyApp();
  runApp(const ProviderScope(
    child: myApp,
  ));
}
