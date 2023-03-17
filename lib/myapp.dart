import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  String _input = "0";
  final parser = Parser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.black],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(right: 30, bottom: 50),
                alignment: AlignmentDirectional.bottomEnd,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _input,
                      style:
                          GoogleFonts.nunito(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      //calculateOutput(),
                      _input,
                      style:
                          GoogleFonts.nunito(color: Colors.white, fontSize: 30),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Color(0xffE7D74A),
              thickness: 1,
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalculatorButton(
                        buttonText: 'AC',
                        buttonFrontColor: Colors.white,
                      ),
                      CalculatorButton(
                        buttonText: '( )',
                        buttonFrontColor: Colors.white,
                      ),
                      CalculatorButton(
                        buttonText: '%',
                        buttonFrontColor: Colors.white,
                      ),
                      CalculatorButton(
                        buttonText: '+',
                        buttonFrontColor: const Color(0xffE7D74A),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalculatorButton(
                        buttonText: '1',
                        buttonFrontColor: Colors.white,
                      ),
                      CalculatorButton(
                        buttonText: '2',
                        buttonFrontColor: Colors.white,
                      ),
                      CalculatorButton(
                        buttonText: '3',
                        buttonFrontColor: Colors.white,
                      ),
                      CalculatorButton(
                        buttonText: '-',
                        buttonFrontColor: const Color(0xffE7D74A),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalculatorButton(
                        buttonText: '4',
                        buttonFrontColor: Colors.white,
                      ),
                      CalculatorButton(
                        buttonText: '5',
                        buttonFrontColor: Colors.white,
                      ),
                      CalculatorButton(
                        buttonText: '6',
                        buttonFrontColor: Colors.white,
                      ),
                      CalculatorButton(
                        buttonText: '*',
                        buttonFrontColor: const Color(0xffE7D74A),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalculatorButton(
                        buttonText: '7',
                        buttonFrontColor: Colors.white,
                      ),
                      CalculatorButton(
                        buttonText: '8',
                        buttonFrontColor: Colors.white,
                      ),
                      CalculatorButton(
                        buttonText: '9',
                        buttonFrontColor: Colors.white,
                      ),
                      CalculatorButton(
                        buttonText: '/',
                        buttonFrontColor: const Color(0xffE7D74A),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalculatorButton(
                        buttonText: 'Del',
                        buttonFrontColor: Colors.white,
                      ),
                      CalculatorButton(
                        buttonText: '0',
                        buttonFrontColor: Colors.white,
                      ),
                      CalculatorButton(
                        buttonText: '.',
                        buttonFrontColor: Colors.white,
                      ),
                      CalculatorButton(
                        buttonText: '=',
                        buttonFrontColor: const Color(0xffE7D74A),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CalculatorButton({
    required String buttonText, Color? buttonFrontColor}) {
    return InkWell(
      onTap: () => buttonPressed(buttonText),
      child: Container(
        width: 90,
        height: 90,
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: buttonFrontColor,
            ),
          ),
        ),
      ),
    );
  }

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        _input = "0";
      }
      else if (buttonText == 'Del') {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
        }
      }
      else if (buttonText == "%") {
        _input += "/100";
      }
      else if (buttonText == "( )") {
        if(_input == "0"){
          _input = "*(";
        }
        else{
          if (_input.contains("(")) {
            if (_input.endsWith("+") ||
                _input.endsWith("/") ||
                _input.endsWith("*") ||
                _input.endsWith("-")) {
              _input += "(";
            } else {
              _input += ")";
            }
          }
          else {
            _input += "*(";
          }
        }
      }
      else if (buttonText == "=") {
        _input = "${calculateOutput()}";
      }
      else {
        if(_input == "0"){
          _input = buttonText;
        }
        else{
          _input += buttonText;
        }

      }
    });
  }

  String calculateOutput() {
    try {
      final expression = parser.parse(_input);
      final result =
          expression.evaluate(EvaluationType.REAL, ContextModel()).toString();
      return result;
    } catch (e) {
      return e.toString();

    }
  }
}
