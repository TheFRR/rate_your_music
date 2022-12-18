import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rate_your_music/Theme/icons.dart';

class HomePageNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const HomePageNavigation(
      {Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const items = [musicNoteSvg, addBoxSvg, searchSvg, personSvg];

    return Theme(
        data: ThemeData().copyWith(splashFactory: NoSplash.splashFactory),
        child: NavigationBar(
          backgroundColor: Colors.black,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          onDestinationSelected: onTap,
          height: 55,
          elevation: 0,
          selectedIndex: currentIndex,
          destinations: items
              .map((e) => NavigationDestination(
                    label: '',
                    icon: SvgPicture.asset(
                      e,
                      color: currentIndex == items.indexOf(e)
                          ? Colors.white
                          : Colors.white60,
                    ),
                  ))
              .toList(),
        ));
  }
}
