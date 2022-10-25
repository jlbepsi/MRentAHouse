import 'package:flutter/material.dart';
import 'package:locations/views/share/bottom_navigation_bar_widget.dart';

class ValidationLocation extends StatefulWidget {
  static String routeName = '/validerlocation';

  const ValidationLocation({Key? key}) : super(key: key);

  @override
  State<ValidationLocation> createState() => _ValidationLocationState();
}

class _ValidationLocationState extends State<ValidationLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
      ),
      body: const Text('Confirm'),
      bottomNavigationBar: const BottomNavigationBarWidget(2),
    );
  }
}
