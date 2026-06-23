String determinarCategoria(double valor) {
  String categoria = "";

  if (valor <= 1000) {
    categoria = "Bronze";
  } else if (valor >= 1001 && valor <= 3000) {
    categoria = "Prata";
  } else if (valor >= 3001 && valor <= 5000) {
    categoria = "Ouro";
  } else if (valor > 5000) {
    categoria = "Platinum";
  }

  return "Cliente $categoria";
}
