import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rate_your_music/Entities/dart_user.dart';
import 'package:rate_your_music/Pages/home_page/home_page.dart';
import 'package:rate_your_music/Services/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late AuthService authService;

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authService = AuthService();
  }

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
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
              controller: emailController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Пароль',
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
                labelText: 'Повторите пароль',
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
                  onPressed: () async {
                    var email = emailController.text;
                    var password = passwordController.text;
                    DartUser? user =
                        await authService.registerWithEmailAndPassword(
                            email.trim(), password.trim());
                    if (user == null) {
                      Fluttertoast.showToast(
                          msg: "Не получилось зарегать...",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      var email = emailController.text;
                      var password = passwordController.text;
                      DartUser? user =
                          await authService.signInWithEmailAndPassword(
                              email.trim(), password.trim());
                      if (user != null) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      }
                    }
                  },
                  child: const Center(
                    child: Text("Зарегистрироваться"),
                  )),
            ),
          ),
        ),
      ])),
    );
  }
}
