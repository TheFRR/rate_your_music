import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Wrap(children: [
      Center(
        child: Text("RateYourMusic",
            style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                foreground: Paint()..shader = linearGradient)),
      ),
      Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Логин',
            ),
          ),
        ),
      ),
      Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Пароль',
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: ElevatedButton(
                onPressed: () {},
                child: const Center(
                  child: Text("Войти"),
                )),
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
        child: Center(child: Text("Нет аккаунта? Зарегистрируйтесь!")),
      ),
      Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: ElevatedButton(
              onPressed: () {},
              child: const Center(
                child: Text("Создать аккаунт"),
              )),
        ),
      ),
    ]));
  }
}
