import 'package:flutter/material.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalculatorHomePage(title: 'Calculator Home Page'),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key, required this.title});
  final String title;

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  double _firstNumber = 0.0;
  double _secondNumber = 0.0;
  String _operator = '';
  String _output = '0';

  void _calculateoutputNumber(String buttonValue) {
    setState(() {
      if (buttonValue == 'C') {
        _clear();
      } else if (buttonValue == '+' || buttonValue == '-' ||
        buttonValue == '*' || buttonValue == '/') {
          _addOperator(buttonValue);
      } else if (buttonValue == '=') {
          _calculate();
      } else if (_operator == '') {
          _firstNumber = double.parse(buttonValue);
          _output = '$_firstNumber';
      } else {
          _secondNumber = double.parse(buttonValue);
          _output += ' $buttonValue';
      }
    });
  }

  void _addOperator(String value) {
    _operator = value;
    _output = '$_firstNumber $value';
  }

  void _calculate() {
    if (_operator.isNotEmpty) {
      double result = 0.0;

      switch (_operator) {
        case '+':
          result = _firstNumber + _secondNumber;
          break;
        case '-':
          result = _firstNumber - _secondNumber;
          break;
        case '*':
          result = _firstNumber * _secondNumber;
          break;
        case '/':
          result = _firstNumber / _secondNumber;
          break;
      }

      _firstNumber = result;
      _operator = '';
      _output = '$_output = $result';
    }
  }

  void _clear() {
    _firstNumber = 0.0;
    _secondNumber = 0.0;
    _operator = '';
    _output = '0';
  }

  Widget _buildButton(String buttonValue) {
    return OutlinedButton(
      onPressed: () => _calculateoutputNumber(buttonValue),
      child: Text(
        buttonValue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _output,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('/'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('*'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton('0'),
                _buildButton('C'),
                _buildButton('='),
                _buildButton('+'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
