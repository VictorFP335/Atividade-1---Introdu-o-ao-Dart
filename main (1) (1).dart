//biblioteca de Math para o Dart com calculos mais complexos
import 'dart:math';

// IA me ajudou a organizar o código para execução com um main
void main() {
  print("Atividade 1 - Introdução ao Dart");
  // Chamando cada exercício em sequência
  exercicio1();
  exercicio2();
  exercicio3();
  exercicio4();
}


// EXERCÍCIO 1
void exercicio1() {

  // Lista gerada pelo Gemini para os valores da função
  List<double> precosFechamento = [
    150.2, // Dia 1
    153.5, // Dia 2
    148.0, // Dia 3
    155.1, // Dia 4
    149.3, // Dia 5
    152.7, // Dia 6
    156.0, // Dia 7
    147.5, // Dia 8
    154.2, // Dia 9
    151.8  // Dia 10
  ];

  //Listas imprimidas em formato array
  print("\n//EXERCÍCIO 1");
  print("Lista de preços de fechamento:");
  print(precosFechamento);

  //  Você pode acessar elementos individuais da lista
  print("\nPrimeiro preço: ${precosFechamento[0].toStringAsFixed(2)}"); // Índice 0-inicio da lista
  print("Último preço: ${precosFechamento[precosFechamento.length - 1].toStringAsFixed(2)}"); // Último elemento
  print("Número total de preços na lista: ${precosFechamento.length}");

  //  Utilizamos o método .reduce() para somar todos os valores da lista
  double somaTotal = precosFechamento.reduce((value, element) => value + element);
  print("\nSoma total dos preços: ${somaTotal.toStringAsFixed(2)}");

  // Calculo para Média Aritmética dividindo a soma pelo total de elementos
  double mediaAritmetica = somaTotal / precosFechamento.length;
  print("Média Aritmética dos preços: ${mediaAritmetica.toStringAsFixed(2)}");

  // Desafio Extra: Use o método .sort() para ordenar a lista
  //feito com Gemini IA para realizar o backup da minha lista
  List<double> precosOrdenados = List<double>.from(precosFechamento);
  precosOrdenados.sort();

  //função feita min - max
  double valorMinimo = precosOrdenados.first;
  double valorMaximo = precosOrdenados.last;
  double amplitude = valorMaximo - valorMinimo;

  //prints do metodo que consiste em .sort
  print("\nAnálise de Extremos:");
  print("Valor Mínimo: ${valorMinimo.toStringAsFixed(2)}");
  print("Valor Máximo: ${valorMaximo.toStringAsFixed(2)}");
  print("Amplitude (Máximo - Mínimo): ${amplitude.toStringAsFixed(2)}");
}



// EXERCÍCIO 2
void exercicio2() {

  // Lista com dados "sujos" sugeridos pelo exercicio
  List<String> rawData = [" 25.5", "26.0 ", " null ", "24.8", " ", "30.2"]; // IA sugeriu

  print("\n// EXERCÍCIO 2");
  print("Dados originais: $rawData");

  // Pipeline de transformação de dados
  List<double> cleanedData = rawData
      // Limpeza: Remove espaços em branco
      .map((String s) => s.trim()) //.map()
      // Exclui entradas "null" ou vazias
      .where((String s) => s.isNotEmpty && s.toLowerCase() != "null")
      //Conversão: Transforma Strings em números (double)
      .map((String s) => double.parse(s))
      // Converte o Iterable resultante para uma List<double>
      .toList();

  //print dos dados limpos
  print("Dados limpos e transformados: $cleanedData");

  // teste simples de verificação de tipo
  if (cleanedData.isNotEmpty) {
    print("Tipo do primeiro elemento: ${cleanedData.first.runtimeType}");
  }
}



// EXERCÍCIO 3
void exercicio3() {

  // Exemplo de lista limpa
  List<double> cleanedData = [24.8, 25.5, 26.0, 30.2];

  print("\n// EXERCÍCIO 3");
  print('Dados originais: $cleanedData');

  if (cleanedData.isEmpty) {
    print('A lista de dados está vazia. Não é possível normalizar.');
    return;
  }

  // Encontrar min e max usando .reduce()
  double minVal = cleanedData.reduce((a, b) => a < b ? a : b);
  double maxVal = cleanedData.reduce((a, b) => a > b ? a : b);

  print('Valor Mínimo (min): $minVal');
  print('Valor Máximo (max): $maxVal');

  //Normalização usando .map()
  List<double> normalizedData = cleanedData.map((x) {

    // Evita divisão por zero se todos os valores forem iguais
    if (maxVal == minVal) {
      return 0.5;
    }

    // Fórmula Min-Max
    return (x - minVal) / (maxVal - minVal);

  }).toList();

  print('Dados normalizados (0-1): $normalizedData');
}



// EXERCÍCIO 4

/// Parâmetros:
/// - [reais]: Uma lista de valores reais observados.
/// - [preditos]: Uma lista de valores preditos pelo modelo.
///
/// Lança [ArgumentError] se as listas tiverem comprimentos diferentes.
/// Retorna 0.0 se as listas estiverem vazias.
double calcularMSE(List<double> reais, List<double> preditos) {

  //Validação de entrada
  if (reais.length != preditos.length) {
    throw ArgumentError(
        'As listas "reais" e "preditos" devem ter o mesmo comprimento para calcular o MSE.');
  }

  if (reais.isEmpty) {
    return 0.0;
  }

  //Calcular erros quadrados
  Iterable<double> errosQuadrados = Iterable.generate(reais.length, (index) {

    final double diferenca = reais[index] - preditos[index];

    // pow() retorna num, convertemos para double
    return pow(diferenca, 2).toDouble();

  });

  //Somar erros quadrados
  final double somaDosErrosQuadrados =
      errosQuadrados.fold(0.0, (somaAtual, erro) => somaAtual + erro);

  //Calcular média
  final double mse = somaDosErrosQuadrados / reais.length;

  return mse;
}

void exercicio4() {

  print("\n// EXERCÍCIO 4");

  //Previsões perfeitas
  List<double> reais1 = [10.0, 20.0, 30.0];
  List<double> preditos1 = [10.0, 20.0, 30.0];
  double mse1 = calcularMSE(reais1, preditos1);

  print('Exemplo 1 (Perfeito): Reais=$reais1, Preditos=$preditos1');
  print('MSE: ${mse1.toStringAsFixed(4)}\n');

  // Pequenos erros
  List<double> reais2 = [100.0, 150.0, 200.0, 250.0];
  List<double> preditos2 = [101.0, 151.0, 201.0, 251.0];

  double mse2 = calcularMSE(reais2, preditos2);

  print('Exemplo 2 (Pequenos Erros): Reais=$reais2, Preditos=$preditos2');
  print('MSE: ${mse2.toStringAsFixed(4)}\n');

  //Erros maiores
  List<double> reais3 = [5.0, 10.0, 15.0];
  List<double> preditos3 = [4.0, 12.0, 13.0];

  double mse3 = calcularMSE(reais3, preditos3);

  print('Exemplo 3 (Erros Variados): Reais=$reais3, Preditos=$preditos3');
  print('MSE: ${mse3.toStringAsFixed(4)}\n');

  //Listas vazias
  List<double> reais4 = [];
  List<double> preditos4 = [];

  double mse4 = calcularMSE(reais4, preditos4);

  print('Exemplo 4 (Listas Vazias): Reais=$reais4, Preditos=$preditos4');
  print('MSE: ${mse4.toStringAsFixed(4)}\n');

  //Erro de tamanho diferente
  List<double> reais5 = [1.0, 2.0];
  List<double> preditos5 = [1.0, 2.0, 3.0];

  print('Exemplo 5 (Listas com Comprimentos Diferentes):');

  try {
    calcularMSE(reais5, preditos5);
  } catch (e) {
    print('Erro capturado: $e\n');
  }
}
