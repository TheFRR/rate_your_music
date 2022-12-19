import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_your_music/Entities/dart_user.dart';
import 'package:rate_your_music/Pages/home_page/home_page.dart';
import 'package:rate_your_music/Pages/login_page/login_page.dart';
import 'package:rate_your_music/Services/auth.dart';
import 'package:rate_your_music/Stores/music_collection_store.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final MusicCollectionStore _musicCollectionStore = MusicCollectionStore();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<DartUser?>.value(
              value: AuthService().currentUser, initialData: null),
          Provider<MusicCollectionStore>(create: (_) => _musicCollectionStore)
        ],
        child: MaterialApp(
          title: 'RateYourMusic',
          theme: ThemeData(
            backgroundColor: Colors.white,
            primarySwatch: Colors.blue,
          ),
          home: const LoginPage(),
        ));
  }
}
