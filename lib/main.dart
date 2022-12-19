import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rate_your_music/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
