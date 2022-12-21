import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rate_your_music/Pages/login_page/login_page.dart';
import 'package:rate_your_music/Services/auth.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Observer(
        builder: (context) => Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: ElevatedButton(
                onPressed: () {
                  AuthService().logOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: const Center(
                  child: Text("Выйти из аккаунта"),
                )),
          ),
        ),
      ),
    );
  }
}
