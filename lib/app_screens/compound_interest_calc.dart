import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:fluttersicalc/utilities/number_field.dart';
import 'package:intl/intl.dart';

class CompoundInterestCalc extends StatefulWidget {
  @override
  _CompoundInterestCalcState createState() => _CompoundInterestCalcState();
}

class _CompoundInterestCalcState extends State<CompoundInterestCalc> {
  var _formKey = GlobalKey<FormState>();

  double principalAmt = 0.0, annualRate = 0.0;
  int compoundsPerYear = 1, terms = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compound Interest Calculator"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              NumberTextFormField(
                  hintTxt:'100000',
                  helperTxt:'You can enter any amount',
                  labelTxt: 'Principal Amount (P)',
                  suffixTxt:'Rupees',
                  onChangeFunc:setPrincipal
              ),
              NumberTextFormField(
                  hintTxt:'10',
                  helperTxt:'You can enter percentage value e.g. 10',
                  labelTxt: 'Annual Rate (r)',
                  suffixTxt:'%',
                  onChangeFunc:setAnnualRate
              ),
              NumberTextFormField(
                  hintTxt:'1',
                  helperTxt:'You can enter how many times the interest get credited in a year',
                  labelTxt: 'Compounds per year (n)',
                  suffixTxt:'Times',
                  onChangeFunc:setCompoundPerYear
              ),
              NumberTextFormField(
                  hintTxt:'5',
                  helperTxt:'You can enter no of years you planning to invest',
                  labelTxt: 'Years (t)',
                  suffixTxt:'Years',
                  onChangeFunc:setTerms
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 15.0),
                child: Text(
                  "P ( 1 + r / 100 ) ^ (n t) \n=\n ${displayAmt(calculateEarnWCI())}",
                  style: Theme.of(context).textTheme.display1,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 15.0),
                child: Text(
                  showExtraResult(),
                  style: Theme.of(context).textTheme.body1,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String displayAmt(double amt) {
    return NumberFormat.currency(locale: 'en_US', name: '₹')
        .format(amt.round());
  }

  double calculateEarnWCI() {
    return principalAmt *
        math.pow((1 + (annualRate / 100)), (compoundsPerYear * terms));
  }

  double calculateEarnWOCI() {
    double interestAmt = principalAmt * (annualRate / 100);
    double amountEarned = (interestAmt * terms) + principalAmt;
    return amountEarned;
  }

  String showExtraResult() {
    if (_formKey.currentState != null && _formKey.currentState.validate()) {
      double woci = calculateEarnWOCI();
      double wci = calculateEarnWCI();
      return 'Without compound interest, you would earn only ${displayAmt(woci)}. ' +
          'This means that thanks to the power of compound interest you will earn an additional ' +
          '${displayAmt(wci - woci)} in interest at the end of the $terms year term.';
    }

    return "";
  }

  void setPrincipal(String userInput) {
    setState(() {
      this.principalAmt = double.parse(userInput);
    });
  }

  void setAnnualRate(String userInput) {
    setState(() {
      this.annualRate = double.parse(userInput);
    });
  }

  void setCompoundPerYear(String userInput) {
    setState(() {
      this.compoundsPerYear = int.parse(userInput);
    });
  }

  void setTerms(String userInput) {
    setState(() {
      this.terms = int.parse(userInput);
    });
  }
}