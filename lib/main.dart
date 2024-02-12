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
  List<String> _expressao = ['']; // Armazena em forma de lista a expressao matematica inserida
  String _display = ''; // String responsavel por mostrar a expressao matematica inserida na tela
  double? result; //armazena resultado da exprecao e PODE RECEBER NULO
  int i = 0; // Indice usado para navegar na lista _expressao

  // Esta funcao trabalha com as entradas do teclado da calculadora
  void _keyboard(String input) {
    switch (input) {
      case '.':
        setState(() {
          if(_expressao[i].contains('.')) return;
          if(_expressao[i].compareTo('') == 0) {
            _expressao[i] += '0';
          }
          _expressao[i] += '.';
        });
        break;
      case 'C':
        setState(() {
          _expressao = [''];
          i = 0;
        });
        break;
      case '+':
      case '-':
      case 'x':
      case '/':
        setState(() {
          if(_expressao[i].compareTo('') == 0) return;
          _expressao.add(input);
          _expressao.add('');
          i += 2;
        });
        break;

      default:
        setState(() {
          _expressao[i] += input;
          if (!_expressao[i].contains('.')) {
            int num = int.parse(_expressao[i]);
            _expressao[i] = num.toString();
          }
        });
    }

    // Trata a string a ser exibida no display da calculadora removendo os espacos em branco, os [] e as ,
    _display = _expressao.toString();
    _display = _display.replaceAll(RegExp(r'[\[\],\s]'), '');

  }

  void _calcular() {
    // 12+3-5*2
    print(_expressao);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            _display,
            style: const TextStyle(fontSize: 65),
            textAlign: TextAlign.right,
          ),
          Text('Barrinha de opções'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => _keyboard('C'),
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
              GestureDetector(
                onTap: () => _keyboard('/'),
                child: const Text(
                  'DIVIDIR',
                  style: TextStyle(fontSize: 25),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => _keyboard('7'),
                child: const Text(
                  '7',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _keyboard('8'),
                child: const Text(
                  '8',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _keyboard('9'),
                child: const Text(
                  '9',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _keyboard('x'),
                child: const Text(
                  'X',
                  style: TextStyle(fontSize: 25),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => _keyboard('4'),
                child: const Text(
                  '4',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _keyboard('5'),
                child: const Text(
                  '5',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _keyboard('6'),
                child: const Text(
                  '6',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _keyboard('-'),
                child: const Text(
                  '-',
                  style: TextStyle(fontSize: 25),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => _keyboard('1'),
                child: const Text(
                  '1',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _keyboard('2'),
                child: const Text(
                  '2',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _keyboard('3'),
                child: const Text(
                  '3',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _keyboard('+'),
                child: const Text(
                  '+',
                  style: TextStyle(fontSize: 25),
                ),
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
                onTap: () => _keyboard('0'),
                child: const Text(
                  '0',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _keyboard('.'),
                child: const Text(
                  ',',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () => _calcular(),
                child: const Text(
                  '=',
                  style: TextStyle(fontSize: 25),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
