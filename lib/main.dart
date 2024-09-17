// main.dart
import 'package:flutter/material.dart';
import 'styled_button.dart';
import 'styled_body.dart';
import 'package:expressions/expressions.dart'; // Import the expressions package

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 214, 214, 214)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sofia Mancini'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String input = ''; // Store user input
  String result = '0'; // Store the result

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        // Clear the input and result
        input = '';
        result = '0';
      } else if (value == '=') {
        // Calculate the result
        try {
          result = _calculateResult(input);
        } catch (e) {
          result = 'Error';
        }
      } else {
        // Append the pressed button's value to the input
        input += value;
      }
    });
  }

String _calculateResult(String expression) {
  // Use the expressions package to parse and evaluate the expression
  try {
    final sanitizedExpression = expression.replaceAll('x', '*');
    final parsedExpression = Expression.parse(sanitizedExpression);
    final evaluator = const ExpressionEvaluator();
    final evalResult = evaluator.eval(parsedExpression, {});

    // Convert the result to a string and format it to four characters
    String result = evalResult.toString();

    // Check if the result can be converted to a number and format accordingly
    if (evalResult is num) {
      // Format for integers or floating-point numbers with up to four significant digits
      result = evalResult.toStringAsFixed(3); // Fix to 3 decimal places
      if (result.length > 4) {
        result = evalResult.toStringAsPrecision(4); // Use precision if fixed length exceeds 4 characters
      }
    }

    // Ensure the result doesn't exceed four characters
    if (result.length > 4) {
      result = result.substring(0, 4); // Trim to four characters if necessary
    }

    return result;
  } catch (e) {
    return 'Error';
  }
}


 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(widget.title),
    ),
    body: Column(
      children: [
        // Input and result display area
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Input display
              StyledBodyText(
                input,
                textAlign: TextAlign.right, // Align input text to the right
              ),
              const SizedBox(height: 5), // Space between input and result
              // Result display
              StyledBodyText(
                '= $result',
                textAlign: TextAlign.right, // Align result text to the right
              ),
            ],
          ),
        ),
        // Spacer to push the grid to the bottom
        const Spacer(),
        // Align the GridView at the bottom
        GridView.count(
          crossAxisCount: 4, // Creates a 4-column grid
          shrinkWrap: true, // Shrink the grid to fit its contents
          physics: const NeverScrollableScrollPhysics(), // Prevent scrolling
          padding: const EdgeInsets.all(8.0), // Add padding around the grid
          children: [
            _buildButton('C'),
            _buildButton('('),
            _buildButton(')'),
            _buildButton('/'),
            _buildButton('7'),
            _buildButton('8'),
            _buildButton('9'),
            _buildButton('x'),
            _buildButton('4'),
            _buildButton('5'),
            _buildButton('6'),
            _buildButton('-'),
            _buildButton('1'),
            _buildButton('2'),
            _buildButton('3'),
            _buildButton('+'),
            _buildButton('0'),
            _buildButton('.'),
            _buildButton('%'),
            _buildButton('='), // Position for the '=' button
          ],
        ),
      ],
    ),
  );
}

  Widget _buildButton(String value) {
    return StyledButton(
      onPressed: () => onButtonPressed(value),
      child: Text(value, style: const TextStyle(fontSize: 24)),
    );
  }
}
