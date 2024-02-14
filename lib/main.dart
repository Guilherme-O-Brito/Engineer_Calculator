import 'package:flutter/material.dart';
import '';

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
  double? _resultado; //armazena resultado da exprecao e PODE RECEBER NULO
  String _resultadoString = ''; // Armazena o resultado da expressao matematica em forma de string
  int i = 0; // Indice usado para navegar na lista _expressao

  // Esta funcao trabalha com as entradas do teclado da calculadora
  void _keyboard(String input) {
    List<String> splited = []; //Lista auxiliar para tratamento de strings
    switch (input) {
      case '.':
        setState(() {
          if (_expressao[i].contains('.')) return;
          if (_expressao[i].compareTo('') == 0) {
            _expressao[i] += '0';
          }
          _expressao[i] += '.';
        });
        break;
      case 'C':
        setState(() {
          _expressao = [''];
          _resultado = null;
          i = 0;
        });
        break;
      case '<<':
        if(_expressao[i] == ''){
          _expressao.removeLast();
          _expressao.removeLast();
          i -= 2;
        } else {
          _expressao[i] = _expressao[i].substring(0,_expressao[i].length-1);
        }
        break;  
      case '=':
        if(_resultado != null){
          _expressao = [];
          i = 0;
          splited = _resultado.toString().split('.');
          if (double.parse(splited.last) == 0) {
            int temp = int.parse(splited.first);
            _expressao.add('$temp');
          } else {
            _expressao.add('$_resultado');
          }  
        }
        break;  
      case '+':
      case '-':
      case 'x':
      case '/':
        setState(() {
          if (_expressao[i].compareTo('') == 0) return;
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
    _resultado = _calcular(_expressao);

    setState(() {
      if (_resultado == null) {
        _resultadoString = '';
      } else {
        
        _resultadoString = _resultado.toString();
        List<String> splited = _resultadoString.split('.');
        if(double.parse(splited.last) == 0){
          _resultadoString = splited.first;
        }
      }
    });
  }

  double? _calcular(List<String> calcs) {
    double num = 0;

    calcs = List<String>.from(calcs);
    int multiplicacao = calcs.indexOf('x');
    int divisao = calcs.indexOf('/');
    int soma = calcs.indexOf('+');
    int subtracao = calcs.indexOf('-');

    if (soma == -1 && subtracao == -1 && multiplicacao == -1 && divisao == -1) {
      return null;
    }

    while (calcs.contains('x') || calcs.contains('/') || calcs.contains('+') || calcs.contains('-')) {
      multiplicacao = calcs.indexOf('x');
      divisao = calcs.indexOf('/');
      soma = calcs.indexOf('+');
      subtracao = calcs.indexOf('-');

      if (multiplicacao != -1 && divisao == -1) {
        if (calcs[multiplicacao + 1] != '') {
          num = double.parse(calcs[multiplicacao - 1]) * double.parse(calcs[multiplicacao + 1]);
          calcs.removeAt(multiplicacao + 1);
          calcs.removeAt(multiplicacao);
          calcs.removeAt(multiplicacao - 1);
          calcs.insert(multiplicacao - 1, num.toString());
          continue;
        } else {
          return null;
        }
      }

      if (multiplicacao == -1 && divisao != -1) {
        if (calcs[divisao + 1] != '' && double.parse(calcs[divisao + 1]) != 0) {
          num = double.parse(calcs[divisao - 1]) / double.parse(calcs[divisao + 1]);
          calcs.removeAt(divisao + 1);
          calcs.removeAt(divisao);
          calcs.removeAt(divisao - 1);
          calcs.insert(divisao - 1, num.toString());
          continue;
        } else {
          return null;
        }
      }

      if (multiplicacao != -1 && divisao != -1) {
        if (multiplicacao < divisao) {
          if (calcs[divisao + 1] != '' && double.parse(calcs[divisao + 1]) != 0)  {
            num = double.parse(calcs[multiplicacao - 1]) * double.parse(calcs[multiplicacao + 1]);
            calcs.removeAt(multiplicacao + 1);
            calcs.removeAt(multiplicacao);
            calcs.removeAt(multiplicacao - 1);
            calcs.insert(multiplicacao - 1, num.toString());
            continue;
          } else {
            return null;
          }
        } else if (_expressao[divisao + 1] != '') {
          num = double.parse(calcs[divisao - 1]) / double.parse(calcs[divisao + 1]);
          calcs.removeAt(divisao + 1);
          calcs.removeAt(divisao);
          calcs.removeAt(divisao - 1);
          calcs.insert(divisao - 1, num.toString());
          continue;
        } else {
          return null;
        }
      }

      if (soma != -1 && subtracao == -1) {
        if (calcs[soma + 1] != '') {
          num = double.parse(calcs[soma - 1]) + double.parse(calcs[soma + 1]);
          calcs.removeAt(soma + 1);
          calcs.removeAt(soma);
          calcs.removeAt(soma - 1);
          calcs.insert(soma - 1, num.toString());
          continue;
        } else {
          return null;
        }
      }

      if (soma == -1 && subtracao != -1) {
        if (calcs[subtracao + 1] != '') {
          num = double.parse(calcs[subtracao - 1]) - double.parse(calcs[subtracao + 1]);
          calcs.removeAt(subtracao + 1);
          calcs.removeAt(subtracao);
          calcs.removeAt(subtracao - 1);
          calcs.insert(subtracao - 1, num.toString());
          continue;
        } else {
          return null;
        }
      }

      if (soma != -1 && subtracao != -1) {
        if (soma < subtracao) {
          if (calcs[soma + 1] != '') {
            num = double.parse(calcs[soma - 1]) + double.parse(calcs[soma + 1]);
            calcs.removeAt(soma + 1);
            calcs.removeAt(soma);
            calcs.removeAt(soma - 1);
            calcs.insert(soma - 1, num.toString());
            continue;
          } else {
            return null;
          }
        } else if (_expressao[subtracao + 1] != '') {
          num = double.parse(calcs[subtracao - 1]) - double.parse(calcs[subtracao + 1]);
          calcs.removeAt(subtracao + 1);
          calcs.removeAt(subtracao);
          calcs.removeAt(subtracao - 1);
          calcs.insert(subtracao - 1, num.toString());
          continue;
        } else {
          return null;
        }
      }

    }

    return num;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              _display,
              style: const TextStyle(fontSize: 65),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              _resultadoString,
              style: const TextStyle(fontSize: 15),
            ),
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
              GestureDetector(
                onTap: () => _keyboard('<<'),
                child: const Text(
                  'BACKSPACE',
                  style: TextStyle(fontSize: 25),
                ),
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
                onTap: () => _keyboard('='),
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
