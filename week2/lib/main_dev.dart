import 'env/app_env.dart';
import 'package:flutter/material.dart';
import 'main.dart';

void main() {
  AppEnvironment.setupEnvironment(Environment.dev);
  runApp(MyApp());
}
