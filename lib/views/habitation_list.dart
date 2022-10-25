import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:locations/models/habitation.dart';
import 'package:locations/views/share/habitation_features_widget.dart';

import '../services/habitation_service.dart';
import '../share/location_text_style.dart';
import 'habitation_details.dart';
import 'share/bottom_navigation_bar_widget.dart';

class HabitationList extends StatelessWidget {
  final HabitationService service = HabitationService();
  late Future<List<Habitation>> _habitations;
  final bool isHouseList;

  HabitationList(this.isHouseList, {Key? key}) : super(key: key) {
    _habitations =
        isHouseList ? service.getMaisons() : service.getAppartements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des ${isHouseList ? 'maisons' : 'appartements'}"),
      ),
      body: Center(
        child: FutureBuilder<List<Habitation>>(
          future: _habitations,
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) =>
                    _buildRow(snapshot.data![index], context),
                itemExtent: 285,
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
          },
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(2),
    );
  }

  _buildRow(Habitation habitation, BuildContext context) {
    return Container(
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
          children: [
            SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/images/locations/${habitation.image}',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            _buildDetails(habitation),
          ],
        ),
      ),
    );
  }

  _buildDetails(Habitation habitation) {
    var format = NumberFormat("### €");

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: ListTile(
                title: Text(habitation.libelle),
                subtitle: Text(habitation.adresse),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                format.format(habitation.prixnuit),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
        HabitationFeaturesWidget(habitation),
      ],
    );
  }
}
