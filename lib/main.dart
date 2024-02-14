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
  double? _resultado; //armazena resultado da exprecao e PODE RECEBER NULO
  String _resultadoString = ''; // Armazena o resultado da expressao matematica em forma de string
  int i = 0; // Indice usado para navegar na lista _expressao

  // Esta funcao trabalha com as entradas do teclado da calculadora
  void _keyboard(String input) {
    List<String> splited = []; //Lista auxiliar para tratamento de strings
    /*
    neste Switch ele recebe a entrada do teclado da calculadora e identifica oque deve ser feito.
    Exemplo: ele trata o display da calculadora para evitar casos de entrada do tipo "000000" ou "0...." que do ponto de vista
    matematico nao fazem sentido mantendo apenas o padrao "1+1" ou "2/0.5"
    */ 
    switch (input) {
      case '.':
        // Responsavel por evitar casos do tipo "0.....1" aceitando apenas padroes como "0.5" "1.2" "0.00003456" e etc
        setState(() {
          if (_expressao[i].contains('.')) return;
          if (_expressao[i].compareTo('') == 0) {
            _expressao[i] += '0';
          }
          _expressao[i] += '.';
        });
        break;
      // Limpa tanto a tela quanto a lista responsavel por armazenar a expressao matematica inserida tambem reseta o indice "i" usado 
      // Na navegacao da lista
      case 'C':
        setState(() {
          _expressao = [''];
          _resultado = null;
          i = 0;
        });
        break;
      // Responsavel por apagar o ultimo digito inserido da expressao  
      case '<<':
        if (_expressao[i] == '') {
          if (i != 0) {
            _expressao.removeLast();
            _expressao.removeLast();
            i -= 2;
          }
        } else {
          _expressao[i] = _expressao[i].substring(0, _expressao[i].length - 1);
        }
        break;
      // Envia o resultado calculado para a expressao   
      case '=':
        if (_resultado != null) {
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
      // Recebe a entrada de operadores matematicos e os insere na expressao fazendo as alteracoes nescessarias na string  
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
      // Default eh responsavel por receber todas as entradas numericas de 0-9 para construcao da expressao
      default:
        setState(() {
          _expressao[i] += input;
          if (!_expressao[i].contains('.')) {
            int num = int.parse(_expressao[i]);
            _expressao[i] = num.toString();
          }
        });
    }

    // Trata a string a ser exibida no display da calculadora removendo os espacos em branco, os "[]" e as "," atraves de uma Regex 
    _display = _expressao.toString();
    _display = _display.replaceAll(RegExp(r'[\[\],\s]'), '');
    _resultado = _calcular(_expressao);

    /*
    Atualiza o display da calculadora responsavel por mostrar a expressao inserida e tambem o resultado que eh calculado em tempo real
    Trata a string para evitar casos de saida como "4.0" permitindo virgulas apenas em casos nescessarios como "2.5"
    Tambem evita que um valor nulo seja mostrado como resultado apenas limpando a string responsavel por essa visualizacao
    */
    setState(() {
      if (_resultado == null) {
        _resultadoString = '';
      } else {
        _resultadoString = _resultado.toString();
        List<String> splited = _resultadoString.split('.');
        if (double.parse(splited.last) == 0) {
          _resultadoString = splited.first;
        }
      }
    });
  }

  /**
   * Funcao responsavel por calcular efetivamente a expressao matematica inserida retornando nulo para quando isso nao for possivel
   * Recebe uma string do tipo "12+5*2" e separa suas operacoes calculando uma por uma respeitando as regras matematicas por exemplo:
   * Calcular multiplicacao ou divisao antes de somas e subtracoes na ordem em que forem inseridas
   * A lista de string "calcs" que esta como parametro recebe uma lista de strings com a expressao matematica no padrao: ['12','+','8']
   * e eh usada para ir separando e calculando os valores ate nao sobrar nada sem ser calculado
   * 
   *////
  double? _calcular(List<String> calcs) {
    double num = 0;
    calcs = List<String>.from(calcs); //copia todos os valores da lista de expressoes para que esta possa ser editada sem que hajam alteracoes na original
    // Encontram as posicoes dos primeiros operadores matematicos inseridos para calculos
    int multiplicacao = calcs.indexOf('x');
    int divisao = calcs.indexOf('/');
    int soma = calcs.indexOf('+');
    int subtracao = calcs.indexOf('-');

    // Retorna nulo caso nao sejam encontrados nenhum operador matematico
    if (soma == -1 && subtracao == -1 && multiplicacao == -1 && divisao == -1) {
      return null;
    }

    // Repete o loop ate que nao hajam mais operadores matematicos na lista representando que esta toda foi calculada
    while (calcs.contains('x') || calcs.contains('/') || calcs.contains('+') || calcs.contains('-')) {
      // Atualiza posicao dos primeiros operadores matematicos
      multiplicacao = calcs.indexOf('x');
      divisao = calcs.indexOf('/');
      soma = calcs.indexOf('+');
      subtracao = calcs.indexOf('-');

      // A partir daqui sao feitas varias verificacoes para encontrar a ordem correta dos calculos encontrados
      // e tambem as modificacoes nescessarias na lista calcs para termino do calculo
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
          if (calcs[divisao + 1] != '' && double.parse(calcs[divisao + 1]) != 0) {
            num = double.parse(calcs[multiplicacao - 1]) *double.parse(calcs[multiplicacao + 1]);
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
                child: Image.asset(
                  'assets/images/buttons/backspace.png',
                  width: 37,
                ),
              ),
              Text(
                '%',
                style: TextStyle(fontSize: 25),
              ),
              GestureDetector(
                onTap: () => _keyboard('/'),
                child: Image.asset(
                  'assets/images/buttons/divisao.png',
                  width: 30,
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
