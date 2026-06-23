(double, double, double) calcularValorTotal(
  String veiculoEscolhido,
  bool seguroCompleto,
  bool gpsIncluso,
  bool motoristaAdicional,
  int qntDias,
) {
  double incrementosDiarios = 0;
  double taxaFixa = 0;

  double valorDiario = 0;
  double valorFinal = 0;
  double valorBruto = 0;
  double desconto = 1;

  switch (veiculoEscolhido) {
    case "Economico":
      incrementosDiarios += 120;
      break;

    case "SUV":
      incrementosDiarios += 180;
      break;

    case "Luxo":
      incrementosDiarios += 300;
      break;
  }

  if (seguroCompleto) {
    incrementosDiarios += 40;
  }

  if (gpsIncluso) {
    incrementosDiarios += 15;
  }

  if (motoristaAdicional) {
    taxaFixa += 100;
  }

  if (qntDias >= 7) {
    desconto -= 0.05;
  } else if (qntDias >= 15) {
    desconto -= 0.1;
  }

  valorDiario = incrementosDiarios * qntDias;
  valorFinal = valorDiario + taxaFixa;
  valorBruto = valorFinal;
  valorFinal *= desconto;

  return (valorBruto, desconto, valorFinal);
}
