import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rate_your_music/Pages/add_album_page/add_album_page.dart';
import 'package:rate_your_music/Pages/login_page/login_page.dart';
import 'package:rate_your_music/Pages/music_collection_page/music_collection_page.dart';
import 'package:rate_your_music/Pages/navigation.dart';
import 'package:rate_your_music/Pages/profile_page/profile.dart';
import 'package:rate_your_music/Pages/register_page/register_page.dart';
import 'package:rate_your_music/Pages/search_page/search_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _screens = <Widget>[
    const MusicCollection(),
    const AddAlbum(),
    const Search(),
    const Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        bottomNavigationBar: HomePageNavigation(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        body: SafeArea(
          child: _screens[_currentIndex],
        ));
  }
}
