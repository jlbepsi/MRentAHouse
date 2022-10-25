import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:locations/models/habitation.dart';
import 'package:locations/share/location_style.dart';
import 'package:locations/share/location_text_style.dart';
import 'package:locations/views/share/total_widget.dart';
import 'package:locations/views/validation_location.dart';

class OptionPayanteCheck extends OptionPayante {
  bool checked;

  OptionPayanteCheck(super.id, super.libelle, this.checked,
      {super.description = "", super.prix});
}

class ResaLocation extends StatefulWidget {
  final Habitation _habitation;
  const ResaLocation(this._habitation, {Key? key}) : super(key: key);

  @override
  State<ResaLocation> createState() => _ResaLocationState();
}

class _ResaLocationState extends State<ResaLocation> {
  DateTime dateDebut = DateTime.now();
  DateTime dateFin = DateTime.now().add(const Duration(days: 1));
  String nbPersonnes = '1';
  List<OptionPayanteCheck> optionPayanteChecks = [];

  var format = NumberFormat("### €");
  double get prixTotal {
    Duration duration = dateFin.difference(dateDebut);
    double prix = widget._habitation.prixnuit * duration.inDays;

    if (optionPayanteChecks.isNotEmpty) {
      optionPayanteChecks.forEach((element) {
        if (element.checked) {
          prix += element.prix;
        }
      });
    }
    return prix;
  }

  @override
  Widget build(BuildContext context) {
    _loadOptionPayantes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Réservation'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(4.0),
        children: [
          _buildResume(),
          _buildDates(),
          _buildNbPersonnes(),
          _buildOptionsPayantes(context),
          TotalWidget(prixTotal),
          _buildRentButton(),
        ],
      ),
    );
  }

  dateTimeRangePicker() async {
    DateTimeRange? datePicked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDateRange: DateTimeRange(start: dateDebut, end: dateFin),
      cancelText: 'Annuler',
      confirmText: 'Valider',
      locale: const Locale("fr", "FR"),
    );
    if (datePicked != null) {
      setState(() {
        dateDebut = datePicked.start;
        if (datePicked.end.compareTo(dateDebut) == 0) {
          dateFin = datePicked.end.add(const Duration(days: 1));
        } else {
          dateFin = datePicked.end;
        }
      });
    }
  }

  _buildResume() {
    return ListTile(
      leading: const Icon(Icons.house),
      title: Text(widget._habitation.libelle),
      subtitle: Text(widget._habitation.adresse),
    );
  }

  _buildRowDate(DateTime dateTime) {
    return Row(
      children: [
        const Icon(Icons.calendar_today_outlined),
        const SizedBox(width: 8.0),
        Center(
          child: Text(
            DateFormat('d MMM y').format(dateTime),
            style: LocationTextStyle.largeTextStyle,
          ),
        ),
      ],
    );
  }

  _buildDates() {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 12.0),
      child: GestureDetector(
        onTap: () {
          dateTimeRangePicker();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildRowDate(dateDebut),
            const CircleAvatar(
              //backgroundColor: LocationStyle.backgroundColorDarkBlue,
              child: Icon(Icons.arrow_forward),
            ),
            _buildRowDate(dateFin),
          ],
        ),
      ),
    );
  }

  _buildNbPersonnes() {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 12.0),
      child: Row(
        children: [
          Text(
            'Nombre de personnes',
            style: LocationTextStyle.subTitleboldTextStyle,
          ),
          const SizedBox(
            width: 10.0,
          ),
          DropdownButton(
              items: <String>['1', '2', '3', '4', '5', '6', '7', '8']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              value: nbPersonnes,
              onChanged: (String? newValue) {
                setState(() {
                  nbPersonnes = newValue!;
                });
              }),
        ],
      ),
    );
  }

  _buildOptionsPayantes(BuildContext context) {
    if (optionPayanteChecks.isEmpty) {
      return Container(
          padding: const EdgeInsets.only(left: 16.0, right: 12.0),
          child: Text(
            'Aucune option',
            style: LocationTextStyle.subTitleboldTextStyle,
          ));
    }

    return Column(
        children: Iterable.generate(
      optionPayanteChecks.length,
      (index) => CheckboxListTile(
        //dense: true,
        title: Text(
            '${optionPayanteChecks[index].libelle} (${format.format(optionPayanteChecks[index].prix)})'),
        value: optionPayanteChecks[index].checked,
        onChanged: (bool? value) {
          setState(() {
            optionPayanteChecks[index].checked = value!;
          });
        },
        subtitle: Text(optionPayanteChecks[index].description),
        secondary: const Icon(Icons.add_shopping_cart),
      ),
    ).toList());
  }

  void _loadOptionPayantes() {
    if (optionPayanteChecks.isEmpty &&
        widget._habitation.optionpayantes.isNotEmpty) {
      optionPayanteChecks = widget._habitation.optionpayantes
          .map((element) => OptionPayanteCheck(
              element.id, element.libelle, false,
              description: element.description, prix: element.prix))
          .toList();
    }
  }

  _buildRentButton() {
    return Container(
      decoration: BoxDecoration(
        color: LocationStyle.backgroundColorDarkBlue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                LocationStyle.backgroundColorDarkBlue)),
        onPressed: () {
          print('_buildRentButton pressed');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ValidationLocation()));
        },
        child: Text(
          'Louer',
          style: LocationTextStyle.priceWhiteTextStyle,
        ),
      ),
    );
  }
}
