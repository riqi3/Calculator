// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:calculator/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '';

  List<String> btnChar = [
    'AC',
    '±',
    '00',
    '/',
    // '÷',
    '7',
    '8',
    '9',
    '*',
    // '×',
    '4',
    '5',
    '6',
    '-',
    // '−',
    '1',
    '2',
    '3',
    '+',
    // '+',
    '←',
    '0',
    '.',
    '='
    // '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screen,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerRight,
                child: Text(input,
                    style: TextStyle(fontSize: 40, color: Colors.white)),
              ),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerRight,
                child: Text(result,
                    style: TextStyle(fontSize: 70, color: Colors.white)),
              ),
            ]),
          ),
          Divider(
            color: Colors.white,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: btnChar.length,
                itemBuilder: (BuildContext context, int index) {
                  return calcBtn(btnChar[index]);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, mainAxisSpacing: 2, crossAxisSpacing: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  handleBtn(String btntxt) {
    if (btntxt == 'AC') {
      input = '';
      result = '0';
      return;
    }

    if (btntxt == '←') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
        return;
      } else {
        return null;
      }
    }

    if (btntxt == '=') {
      result = total();
      input = result;

      if (input.endsWith('.0')) {
        input = input.replaceAll('.0', '');
      }
      if (result.endsWith('.0')) {
        result = result.replaceAll('.0', '');
        return;
      }
    }

    input = input + btntxt;
  }

  String total() {
    try {
      var exp = Parser().parse(input);
      var eva = exp.evaluate(EvaluationType.REAL, ContextModel());
      return eva.toString();
    } catch (e) {
      return 'Error!';
    }
  }

  Widget calcBtn(String btntxt) {
    return InkWell(
      onTap: () {
        setState(() {
          handleBtn(btntxt);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBGColor(btntxt),
        ),
        child: Center(
          child: Text(
            btntxt,
            style: TextStyle(
                fontSize: 40, color: Colors.white, fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }

  getBGColor(String btntxt) {
    if (btntxt == 'AC' ||
        btntxt == '±' ||
        btntxt == '←' ||
        btntxt == '7' ||
        btntxt == '8' ||
        btntxt == '9' ||
        btntxt == '4' ||
        btntxt == '5' ||
        btntxt == '6' ||
        btntxt == '1' ||
        btntxt == '2' ||
        btntxt == '3' ||
        btntxt == '0' ||
        btntxt == '.' ||
        btntxt == '00') {
      return btnColor1;
    } else {
      return btnColor2;
    }
  }
}
