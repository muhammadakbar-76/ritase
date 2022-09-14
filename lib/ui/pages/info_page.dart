import 'package:flutter/material.dart';
import 'package:ritase/shared/theme.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'This app is for technical test from PT.Indo Muro Kencana. Build with agile method and Minimum Viable Product strategy to meet the minimum requirement and accomplish the test ASAP',
          style: tBlackText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
