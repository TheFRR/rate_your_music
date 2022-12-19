import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rate_your_music/Services/auth.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        child: ElevatedButton(
            onPressed: () {
              AuthService().logOut();
            },
            child: const Center(
              child: Text("Выйти из аккаунта"),
            )),
      ),
    );
  }
}
