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
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Numerinhos',
            style: TextStyle(fontSize: 65),
            textAlign: TextAlign.right,
          ),
          Text('Barrinha de opções'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'C',
                style: TextStyle(fontSize: 25),
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
              Text(
                '7',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                '8',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                '9',
                style: TextStyle(fontSize: 25),
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
              Text(
                '4',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                '5',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                '6',
                style: TextStyle(fontSize: 25),
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
              Text(
                '1',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                '2',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                '3',
                style: TextStyle(fontSize: 25),
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
              Text(
                '0',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                ',',
                style: TextStyle(fontSize: 25),
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
