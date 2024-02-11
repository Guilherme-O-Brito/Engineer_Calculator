import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _numeros = '';

  void _display(String input) {
    switch (input) {
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
      case '0':
        _numeros += input;
        setState(() {
          if (_numeros.contains('.')) {
            double num = double.parse(_numeros);
            _numeros = num.toString();
          } else {
            int num = int.parse(_numeros);
            _numeros = num.toString();
          }
        });
        break;
      case '.':
        setState(() {
          _numeros += '.';
        });
        break;
      case 'C':
        setState(() {
          _numeros = '';
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            _numeros,
            style: TextStyle(fontSize: 65),
            textAlign: TextAlign.right,
          ),
          Text('Barrinha de opções'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => _display('C'),
                child: const Text(
                  'C',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Text(
                'BACKSPACE',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                '%',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                'DIVIDIR',
                style: TextStyle(fontSize: 25),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => _display('7'),
                child: const Text(
                  '7',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _display('8'),
                child: const Text(
                  '8',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _display('9'),
                child: const Text(
                  '9',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Text(
                'X',
                style: TextStyle(fontSize: 25),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => _display('4'),
                child: const Text(
                  '4',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _display('5'),
                child: const Text(
                  '5',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _display('6'),
                child: const Text(
                  '6',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Text(
                '-',
                style: TextStyle(fontSize: 25),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => _display('1'),
                child: const Text(
                  '1',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _display('2'),
                child: const Text(
                  '2',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _display('3'),
                child: const Text(
                  '3',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Text(
                '+',
                style: TextStyle(fontSize: 25),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '+/-',
                style: TextStyle(fontSize: 25),
              ),
              GestureDetector(
                onTap: () => _display('0'),
                child: const Text(
                  '0',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _display('.'),
                child: const Text(
                  ',',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Text(
                '=',
                style: TextStyle(fontSize: 25),
              )
            ],
          )
        ],
      ),
    ));
  }
}
