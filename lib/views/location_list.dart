import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:locations/share/location_text_style.dart';
import 'package:locations/views/share/bottom_navigation_bar_widget.dart';

import '../models/location.dart';
import '../services/location_service.dart';
import '../share/location_style.dart';

class LocationList extends StatefulWidget {
  static String routeName = '/locations';
  const LocationList({Key? key}) : super(key: key);

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  final LocationService service = LocationService();
  late Future<List<Location>> _locations;

  @override
  void initState() {
    super.initState();
    _locations = service.getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes locations'),
      ),
      body: Center(
        child: FutureBuilder<List<Location>>(
          future: _locations,
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildListView(context, snapshot.data!);
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

  _buildListView(BuildContext context, List<Location> locations) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: locations.length,
      itemBuilder: (context, index) => _buildRow(locations[index], context),
      itemExtent: 165,
    );
  }

  _buildRow(Location location, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildResume(location),
          _buildDates(location.dateDebut, location.dateFin),
          _buildFacture(location),
          const Divider(
            color: LocationStyle.backgroundColorDarkBlue,
            height: 10,),
        ],
      ),
    );
  }

  _buildResume(Location location) {
    var format = NumberFormat("### €");
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: ListTile(
            title: Text(location.habitation==null ? '' : location.habitation!.libelle),
            subtitle: Text(location.habitation==null ? '' : location.habitation!.adresse),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            format.format(location.montanttotal),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              fontSize: 22,
            ),
          ),
        ),
      ],
    );
  }

  _buildDates(DateTime dateDebut, DateTime dateFin) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
              children: [
                const Icon(Icons.calendar_today_outlined),
                const SizedBox(width: 8.0),
                Center(
                  child: Text(
                    DateFormat('d MMM y').format(dateDebut),
                    style: LocationTextStyle.priceTextStyle,
                  ),
                ),
              ],
            ),
          const CircleAvatar(
            child: Icon(Icons.arrow_forward),
          ),
          Row(
              children: [
                const Icon(Icons.calendar_today_outlined),
                const SizedBox(width: 8.0),
                Center(
                  child: Text(
                    DateFormat('d MMM y').format(dateFin),
                    style: LocationTextStyle.priceTextStyle,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  _buildFacture(Location location) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: location.facture == null ?
        const Text('Aucune facture') :
        Text('Facture délivrée le ${DateFormat('d MMM y').format(location.facture!.date)}'),
    );
  }
}
