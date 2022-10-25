import 'package:flutter/material.dart';
import 'package:locations/views/share/bottom_navigation_bar_widget.dart';

class Profil extends StatefulWidget {
  static String routeName = '/profil';
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon profil'),
      ),
      body: Text('Profil a faire'),
      bottomNavigationBar: const BottomNavigationBarWidget(1),
    );
  }
}
