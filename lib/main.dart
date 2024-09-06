import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(CalculadoraApp());

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      home: CalculadoraHomePage(),
    );
  }
}

class CalculadoraHomePage extends StatefulWidget {
  @override
  _CalculadoraHomePageState createState() => _CalculadoraHomePageState();
}

class _CalculadoraHomePageState extends State<CalculadoraHomePage> {
  String equation = "0";
  String result = "0";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
      } else if (buttonText == "+/-") {
        if (equation != "0") {
          if (equation[0] != '-') {
            equation = '-$equation';
          } else {
            equation = equation.substring(1);
          }
        }
      } else if (buttonText == "=") {
        String expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          double evalResult = exp.evaluate(EvaluationType.REAL, cm);
          result = evalResult.toString();
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
      if (buttonText != "=") {
        // Update result in real-time while typing
        String expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          double evalResult = exp.evaluate(EvaluationType.REAL, cm);
          result = evalResult.toString();
        } catch (e) {
          result = "Error";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculadora',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                equation,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                result,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 10),

              _buildButtonGrey('AC'),
              SizedBox(width: 10),

              _buildButtonGrey('+/-'),
              SizedBox(width: 10),

              _buildButtonGrey('%'),
              SizedBox(width: 10),

              _buildButtonOrange('÷'),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              SizedBox(width: 10),
              
              _buildButton('7'),
              SizedBox(width: 10),

              _buildButton('8'),
              SizedBox(width: 10),

              _buildButton('9'),
              SizedBox(width: 10),

              _buildButtonOrange('x'),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              SizedBox(width: 10),

              _buildButton('4'),
              SizedBox(width: 10),

              _buildButton('5'),
              SizedBox(width: 10),

              _buildButton('6'),
              SizedBox(width: 10),
              
              _buildButtonOrange('-'),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              SizedBox(width: 10),
              _buildButton('1'),
              SizedBox(width: 10),
              _buildButton('2'),
              SizedBox(width: 10),
              _buildButton('3'),
              SizedBox(width: 10),
              _buildButtonOrange('+'),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              SizedBox(width: 10),
              _buildButton('0'),
              SizedBox(width: 10),
              _buildButton(','),
              SizedBox(width: 10),
              _buildButtonOrange('='),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(24.0),
          side: BorderSide(
            color: Color.fromARGB(255, 44, 44, 44),
            width: 1.0,
          ),
          backgroundColor: Color.fromARGB(255, 44, 44, 44),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  Widget _buildButtonOrange(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Color.fromARGB(251, 241, 123, 44),
          padding: EdgeInsets.all(24.0),
          side: BorderSide(color: Color.fromARGB(251, 241, 123, 44)),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  Widget _buildButtonGrey(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Color.fromARGB(250, 145, 145, 145),
          padding: EdgeInsets.all(24.0),
          side: BorderSide(color: Color.fromARGB(250, 145, 145, 145)),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }
}
