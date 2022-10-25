import 'package:flutter/material.dart';


class LoginPageArgument {
  final String routeNameNext;

  LoginPageArgument(this.routeNameNext);
}

class LoginPage extends StatefulWidget {
  static String routeName = 'login';
  final String routeNameNext;
  const LoginPage(this.routeNameNext, {Key? key}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String routeNameToUse = widget.routeNameNext;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          const SizedBox(height: 80.0),
          Column(
            children: <Widget>[
              Image.asset('assets/images/locations/location.png'),
            ],
          ),
          const SizedBox(height: 120.0),
          TextField(
            controller: _mailController,
            decoration: const InputDecoration(
              filled: true,
              labelText: 'Email',
            ),
          ),
          const SizedBox(height: 12.0),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              filled: true,
              labelText: 'Mot de passe',
            ),
            obscureText: true,
          ),
          OverflowBar(
            alignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  _mailController.clear();
                  _passwordController.clear();
                },
                child: const Text('Annuler'),
              ),
              ElevatedButton(
                onPressed: () {
                  _logUser(context, routeNameToUse);
                },
                child: const Text('Valider'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _logUser(BuildContext context, String routeName) {
    // La connection est validée;
  }
}
