import 'package:meu_app_testes/classes/viacep.dart';
import 'package:meu_app_testes/meu_app_testes.dart' as app;
import 'package:test/test.dart';

void main() {
  test('Calcula o valor do produto com desconto sem porcentagem', () {
    expect(app.calucularDesconto(1000, 150, false), equals(850));
  });

  test(
      'Calcula o valor do produto com desconto sem porcentagem, passando valor do produto zerado',
      () {
    expect(() => app.calucularDesconto(0, 150, false),
        throwsA(TypeMatcher<ArgumentError>()));
  });

  test('Calcula o valor do produto com desconto por porcentagem', () {
    expect(app.calucularDesconto(1000, 15, true), equals(850));
  });

  test(
      'Calcula o valor do produto com desconto com porcentagem, passando valor do produto zerado ',
      () {
    expect(() => app.calucularDesconto(1000, 0, true),
        throwsA(TypeMatcher<ArgumentError>()));
  });

  group("Calcula o valor do produto com desconto:", () {
    var valuesToTest = {
      {'valor': 1000, 'desconto': 150, 'percentual': false}: 850,
      {'valor': 1000, 'desconto': 15, 'percentual': true}: 850,
    };
    valuesToTest.forEach((values, expected) {
      test('$values: $expected', () {
        expect(
            app.calucularDesconto(
                double.parse(values["valor"].toString()),
                double.parse(values["desconto"].toString()),
                values["percentual"] == true),
            equals(expected));
      });
    });
  });

  group("Calcula o valor do produto informando valores zerados, deve gerar erro", () {
    var valuesToTest = {
      {'valor': 0, 'desconto': 150, 'percentual': false},
      {'valor': 1000, 'desconto': 0, 'percentual': true},
    };
    for (var values in valuesToTest) {
      test('Entrada: $values', () {
        expect(
            () => app.calucularDesconto(
                double.parse(values["valor"].toString()),
                double.parse(values["desconto"].toString()),
                values["percentual"] == true),
            throwsA(TypeMatcher<ArgumentError>()));
      });
    }
  });
  
  test('Testar conversão para uppercase', () {
    expect(app.convertToUpper("gabriel"), equals("GABRIEL"));
  });

  test('Testar conversão para uppercase teste 2', () {
    expect(app.convertToUpper("gabriel"), equalsIgnoringCase("gabriel"));
  });

  test('Valor maior que 50', () {
    expect(app.retornaValor(50), greaterThanOrEqualTo(50));
  });

  test('Começa com', () {
    expect(app.convertToUpper("gabriel"), startsWith("G"));
  });

  test('Valor diferente', () {
    expect(app.retornaValor(50), isNot(equals(48)));
  });
  
  test('Retornar CEP', () async{
    ViaCEP viacep = ViaCEP();
    var body = await viacep.retornarCEP("01001000");
    expect(body["bairro"], equals("Sé"));
    expect(body["logradouro"], equals("Praça da Sé"));
  });
}