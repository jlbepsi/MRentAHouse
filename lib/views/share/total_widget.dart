

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:locations/share/location_text_style.dart';

import '../../share/location_style.dart';

class TotalWidget extends StatelessWidget {
  final double total;

  const TotalWidget(this.total, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var format = NumberFormat("###.00 €");
    String totalAffiche = format.format(total);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: LocationStyle.backgroundColorDarkBlueLight,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 12.0),
              child: Text(
                'TOTAL',
                style: LocationTextStyle.priceTextStyle,
                textAlign: TextAlign.end,
              ),
            ),
          ),
          Expanded(
            child: Text(
              totalAffiche,
              style: LocationTextStyle.priceTextStyle,
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    );
  }
}
