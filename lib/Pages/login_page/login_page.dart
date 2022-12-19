import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:rate_your_music/Entities/dart_user.dart';
import 'package:rate_your_music/Pages/home_page/home_page.dart';
import 'package:rate_your_music/Pages/music_collection_page/music_collection_page.dart';
import 'package:rate_your_music/Pages/register_page/register_page.dart';
import 'package:rate_your_music/Services/auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool showPassword = true;

  late ReactionDisposer reactionDisposer;

  late AuthService authService;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    reactionDisposer();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
    final DartUser? user = Provider.of<DartUser?>(context);
    bool isLoggedIn = user != null;
    return isLoggedIn
        ? const HomePage()
        : Scaffold(
            body: Center(
                child: Wrap(children: [
              Center(
                child: Text("RateYourMusic",
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = linearGradient)),
              ),
              Center(
                child: Material(
                  child: Observer(
                    builder: (_) => SizedBox(
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
                ),
              ),
              Center(
                child: Material(
                  child: Observer(
                    builder: (_) => SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Пароль',
                            ))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Material(
                    child: Observer(
                      builder: (_) => SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: ElevatedButton(
                            onPressed: () async {
                              var _email = emailController.text;
                              var _password = passwordController.text;
                              DartUser? user =
                                  await authService.signInWithEmailAndPassword(
                                      _email.trim(), _password.trim());
                              if (user == null) {
                                Fluttertoast.showToast(
                                    msg: "Не получилось...",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage()));
                              }
                            },
                            child: const Center(
                              child: Text("Войти"),
                            )),
                      ),
                    ),
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                      },
                      child: const Center(
                        child: Text("Создать аккаунт"),
                      )),
                ),
              ),
            ])),
          );
  }
}
