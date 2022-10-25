import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'package:locations/models/habitation.dart';
import 'package:locations/models/typehabitat.dart';
import 'package:locations/share/location_style.dart';
import 'package:locations/share/location_text_style.dart';
import 'package:locations/views/share/bottom_navigation_bar_widget.dart';

import 'services/habitation_service.dart';
import 'views/habitation_details.dart';
import 'views/habitation_list.dart';
import 'views/location_list.dart';
import 'views/login_page.dart';
import 'views/profil.dart';
import 'views/validation_location.dart';

void main() {
  Intl.defaultLocale = 'fr';

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final backgroundColor =
  LocationStyle.colorToMaterialColor(LocationStyle.backgroundColorDarkBlue);
  final backgroundLightColor = LocationStyle.colorToMaterialColor(
      LocationStyle.backgroundColorDarkBlueLight);

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locations',
      theme: ThemeData(
        primarySwatch: backgroundColor,
        backgroundColor: backgroundColor,
        bottomAppBarColor: backgroundColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  LocationStyle.backgroundColorDarkBlueLight)),
        ),
      ),
      home: MyHomePage(title: 'Mes locations'),
      // Le code précédent ...
      routes: {
        Profil.routeName: (context) => const Profil(),
        LoginPage.routeName: (context) => const LoginPage('/'),
        LocationList.routeName: (context) => const LocationList(),
        ValidationLocation.routeName: (context) => const ValidationLocation(),
      },
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('en'), Locale('fr')],
    );
  }
}

class MyHomePage extends StatelessWidget {
  final HabitationService service = HabitationService();
  final String title;
  late Future<List<TypeHabitat>> _typehabitats;
  late Future<List<Habitation>> _habitations;

  MyHomePage({required this.title, Key? key})
      : super(key: key) {
    _habitations = service.getHabitationsTop10();
    _typehabitats = service.getTypeHabitats();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            _buildTypeHabitat(context),
            const SizedBox(height: 20),
            _buildDerniereLocation(context),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(0),
    );
  }

  _buildTypeHabitat(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      height: 100,
      child: FutureBuilder<List<TypeHabitat>>(
        future: _typehabitats,
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildRowTypeHabitat(context, snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
                  'Impossible de récupérer les données : ${snapshot.error}',
                  style: LocationTextStyle.errorTextStyle,
                ));
          }
          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _buildRowTypeHabitat(BuildContext context, List<TypeHabitat> typehabitats) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        typehabitats.length,
            (index) => _buildHabitat(context, typehabitats[index]),
      ),
    );
  }

  _buildHabitat(BuildContext context, TypeHabitat typeHabitat) {
    var icon = Icons.house;
    switch (typeHabitat.id) {
      // case 1: House
      case 2:
        icon = Icons.apartment;
        break;
      default:
        icon = Icons.home;
    }
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: LocationStyle.backgroundColorDarkBlue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HabitationList(typeHabitat.id == 1),
                ));
          },
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white70,
            ),
            const SizedBox(width: 5),
            Text(
              typeHabitat.libelle,
              style: LocationTextStyle.regularWhiteTextStyle,
            )
          ],
        ),
      ),),
    );
  }

  _buildDerniereLocation(BuildContext context) {
    return SizedBox(
      height: 240,
      child: FutureBuilder<List<Habitation>>(
          future: _habitations,
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemExtent: 220,
                itemBuilder: (context, index) =>
                    _buildRow(snapshot.data![index], context),
                scrollDirection: Axis.horizontal,
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                    'Impossible de récupérer les données : ${snapshot.error}',
                    style: LocationTextStyle.errorTextStyle,
                  ));
            }
            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  _buildRow(Habitation habitation, BuildContext context) {
    var format = NumberFormat("### €");

    return Container(
      width: 240,
      margin: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HabitationDetails(habitation)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                'assets/images/locations/${habitation.image}',
                fit: BoxFit.fitWidth,
              ),
            ),
            Text(
              habitation.libelle,
              style: LocationTextStyle.regularTextStyle,
            ),
            Row(
              children: [
                const Icon(Icons.location_on_outlined),
                Text(
                  habitation.adresse,
                  style: LocationTextStyle.regularTextStyle,
                ),
              ],
            ),
            Text(
              format.format(habitation.prixnuit),
              style: LocationTextStyle.boldTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
