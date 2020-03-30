import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttersicalc/app_screens/compound_interest_calc.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: "Compound Interest Calculator",
  home: CompoundInterestCalc(),
  theme: ThemeData(
    primaryColor: Colors.indigo,
    accentColor: Colors.indigoAccent,
    brightness: Brightness.dark),
  )
);
