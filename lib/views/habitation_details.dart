import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:locations/models/habitation.dart';
import 'package:locations/views/share/bottom_navigation_bar_widget.dart';
import 'package:locations/views/share/habitation_features_widget.dart';

import '../share/location_style.dart';
import '../share/location_text_style.dart';
import 'resa_location.dart';

class HabitationDetails extends StatefulWidget {
  final Habitation _habitation;
  const HabitationDetails(this._habitation, {Key? key}) : super(key: key);

  @override
  State<HabitationDetails> createState() => _HabitationDetailsState();
}

class _HabitationDetailsState extends State<HabitationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._habitation.libelle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(4.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'assets/images/locations/${widget._habitation.image}',
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: Text(widget._habitation.libelle),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 2.0),
            margin: const EdgeInsets.all(8.0),
            child: Text(widget._habitation.adresse),
          ),
          HabitationFeaturesWidget(widget._habitation),
          _buildItems(),
          _buildOptionsPayantes(),
          _buildRentButton(),
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(2),
    );
  }

  _buildRentButton() {
    var format = NumberFormat("### €");

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: LocationStyle.backgroundColorDarkBlue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              format.format(widget._habitation.prixnuit),
              style: LocationTextStyle.priceWhiteTextStyle,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ResaLocation(widget._habitation)));
              },
              child: const Text('Réserver'),
            ),
          ),
        ],
      ),
    );
  }

  _buildItems() {
    if (widget._habitation.options.isEmpty) {
      return Container();
    }

    var width = (MediaQuery.of(context).size.width / 2) - 15;
    return Column(children: [
      _buildDivider('Inclus'),
      Wrap(
        spacing: 2.0,
        children: Iterable.generate(
          widget._habitation.options.length,
          (i) => Container(
            padding: const EdgeInsets.only(left: 15),
            margin: const EdgeInsets.all(2.0),
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget._habitation.options[i].libelle),
                Text(
                  widget._habitation.options[i].description,
                  style: LocationTextStyle.regularGreyTextStyle,
                ),
              ],
            ),
          ),
        ).toList(),
      ),
    ]);
  }

  _buildOptionsPayantes() {
    if (widget._habitation.options.isEmpty) {
      return Container(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Aucune option',
            style: LocationTextStyle.subTitleboldTextStyle,
          ));
    }

    var format = NumberFormat("### €");
    var width = (MediaQuery.of(context).size.width / 3) - 15;
    return Column(children: [
      _buildDivider('Options'),
      Wrap(
        spacing: 2.0,
        children: Iterable.generate(
          widget._habitation.optionpayantes.length,
          (i) => Container(
            padding: const EdgeInsets.only(left: 15),
            margin: const EdgeInsets.all(2.0),
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget._habitation.optionpayantes[i].libelle),
                Text(
                  format.format(widget._habitation.optionpayantes[i].prix),
                  style: LocationTextStyle.priceGreyTextStyle,
                ),
              ],
            ),
          ),
        ).toList(),
      ),
    ]);
  }

  _buildDivider(String text) {
    return Row(children: [
      const SizedBox(
        width: 8,
      ),
      Text(
        text,
        style: LocationTextStyle.subTitleboldTextStyle,
      ),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Divider(
              color: LocationStyle.backgroundColorDarkBlue,
              height: 36,
            )),
      ),
    ]);
  }
}
