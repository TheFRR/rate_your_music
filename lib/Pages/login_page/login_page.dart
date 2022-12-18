import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:rate_your_music/Pages/music_collection_page/music_collection_page.dart';
import 'package:rate_your_music/Stores/login_store.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginStore loginStore;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool showPassword = true;

  late ReactionDisposer reactionDisposer;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    reactionDisposer();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    loginStore = Provider.of<LoginStore>(context);
    reactionDisposer = reaction((_) => loginStore.isLoggedIn, (bool loggedIn) {
      if (loggedIn) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MusicCollection()));
      }
    });
  }

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
        child: Material(
          child: Observer(
            builder: (_) => SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Логин',
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
                    onPressed: loginStore.login,
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
              onPressed: () {},
              child: const Center(
                child: Text("Создать аккаунт"),
              )),
        ),
      ),
    ]));
  }
}
