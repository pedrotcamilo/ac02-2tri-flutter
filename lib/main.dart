import 'package:flutter/material.dart';
import 'widgets/opcoes.dart';
import 'calcularTotal.dart';
import 'determinarCategoria.dart';

void main() {
  runApp(
      MaterialApp(debugShowCheckedModeBanner: false, home: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String carroSelecionado = "Economico";
  String categoria = "Nenhuma";
  bool seguroCompleto = false;
  bool gps = false;
  bool motoristaAdicional = false;
  int qntDias = 1;

  void alterarCarroSelecionado(String novo) {
    setState(() {
      carroSelecionado = novo;
    });
  }

  void alterarSeguroCompleto(bool novo) {
    setState(() {
      seguroCompleto = novo;
    });
  }

  void alterarGPS(bool novo) {
    setState(() {
      gps = novo;
    });
  }

  void alterarMotoristaAdicional(bool novo) {
    setState(() {
      motoristaAdicional = novo;
    });
  }

  void alterarQntDias(int novo) {
    if (novo <= 1) {
      setState(() {
        qntDias = 1;
      });
    } else {
      setState(() {
        qntDias = novo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Super Locadora de Carros",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          children: [
            tituloOpcao("Tipo de Veículo"),
            SegmentedButton<String>(
              expandedInsets: EdgeInsets.all(5),
              segments: const [
                ButtonSegment(value: "Economico", label: Text("Econômico")),
                ButtonSegment(value: "SUV", label: Text("SUV")),
                ButtonSegment(value: "Luxo", label: Text("Luxo")),
              ],
              selected: {carroSelecionado},
              onSelectionChanged: (p0) {
                alterarCarroSelecionado(p0.first);
              },
            ),
            SizedBox(height: 30),
            tituloOpcao("Configurações de Veículo"),
            Row(
              children: [
                Checkbox(
                  value: seguroCompleto,
                  onChanged: (valor) {
                    alterarSeguroCompleto(valor!);
                  },
                ),
                Text("Seguro completo?"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: gps,
                  onChanged: (valor) {
                    alterarGPS(valor!);
                  },
                ),
                Text("GPS embutido?"),
              ],
            ),
            Row(
              children: [
                Switch(
                  value: motoristaAdicional,
                  onChanged: (valor) {
                    alterarMotoristaAdicional(valor);
                  },
                ),
                Text("Motorista Adicional?"),
              ],
            ),
            SizedBox(height: 30),
            tituloOpcao("Permanência"),
            Row(
              children: [
                Slider(
                  min: 0,
                  max: 30,
                  value: qntDias.toDouble(),
                  onChanged: (valor) {
                    alterarQntDias(valor.toInt());
                  },
                ),
                Text("$qntDias dias"),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                ElevatedButton(
                  child: const Text("Finalizar Reserva"),
                  onPressed: () {
                    var (valorBruto, desconto, valorFinal) = calcularValorTotal(
                      carroSelecionado,
                      seguroCompleto,
                      gps,
                      motoristaAdicional,
                      qntDias,
                    );

                    String textoConfirmacao =
                        """
Gostaria de finalizar a sua reserva?

Veículo escolhido: $carroSelecionado
Quantidade de Dias: $qntDias
Seguro: ${seguroCompleto ? "Sim" : "Não"}
GPS: ${gps ? "Sim" : "Não"}
Motorista Adicional: ${motoristaAdicional ? "Sim" : "Não"}

Valor Bruto: R\$$valorBruto
Desconto: ${100 - (desconto * 100)}%
Valor Final: R\$$valorFinal
                      """;

                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Atenção"),
                        content: Text(textoConfirmacao),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: const Text("Cancelar"),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                categoria = determinarCategoria(valorBruto);
                              });
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Reserva realizada com sucesso! ;)")));
                            },
                            child: const Text("Confirmar Reserva"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 50),
            tituloOpcao("Sua categoria: $categoria"),
          ],
        ),
      ),
    );
  }
}