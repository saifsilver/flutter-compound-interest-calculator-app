import 'package:flutter/material.dart';
import 'package:fluttersicalc/utilities/decimal_text_input_formatter.dart';

class NumberTextFormField extends StatelessWidget {
  final String hintTxt;
  final String helperTxt;
  final String labelTxt;
  final String suffixTxt;
  final Function onChangeFunc;

  const NumberTextFormField(
      this.hintTxt,
      this.helperTxt,
      this.labelTxt,
      this.suffixTxt,
      this.onChangeFunc
      ) : super();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (String value) {
          if (value.isEmpty) {
            return "Please enter a valid input.";
          }

          return null;
        },
        style: textStyle,
        //keyboardType: TextInputType.number,
        //inputFormatters: <TextInputFormatter>[
        //  LengthLimitingTextInputFormatter(12),
        //  WhitelistingTextInputFormatter.digitsOnly,
        //  BlacklistingTextInputFormatter.singleLineFormatter,
        //],
        inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: new InputDecoration(
          //filled: true,
          //fillColor: Colors.white,
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
          //hintText: hintTxt,
          helperText: helperTxt,
          labelText: labelTxt,
          prefixIcon: const Icon(
            Icons.arrow_right,
            color: Colors.green,
            size: 36.0,
          ),
          prefixText: '',
          suffixText: suffixTxt,
          //suffixStyle: const TextStyle(
          //    color: Colors.green
          //)
        ),
        cursorColor: Colors.black,
        onChanged: (String userInput) {
          if (userInput.trim().length == 0)
            onChangeFunc('0');
          else
            onChangeFunc(userInput);
        },
      ),
    );
  }
}