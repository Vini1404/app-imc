// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: CalcImc(),
    debugShowCheckedModeBanner: false,
  ));
}

class CalcImc extends StatefulWidget {
  const CalcImc({super.key});

  @override
  State<CalcImc> createState() => _CalcImcState();
}

class _CalcImcState extends State<CalcImc> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String info = "";
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      //print(imc);
      if (imc < 18.5) {
        info = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.5 && imc <= 24.9) {
        info = "Peso normal(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 25.0 && imc <= 29.9) {
        info = "Sobrepeso(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 30.0 && imc <= 34.9) {
        info = "Obesidade grau 1 (${imc.toStringAsPrecision(3)})";
      } else {
        info = "Obesidade grau 2 (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  void resetCampos() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      info = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 63, 161, 6),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: resetCampos,
                icon: FaIcon(
                  FontAwesomeIcons.spinner,
                  color: Colors.white,
                )),
            Padding(
              padding: EdgeInsets.only(right: 20.0, top: 12.5),
            )
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Calculadora IMC"),
            ],
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(left: 200.0, top: 12.5)),
                  Text('INFORME SEUS DADOS',
                      style: TextStyle(
                          color: Color.fromARGB(255, 63, 161, 6),
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 25),
                  /*Icon(Icons.abc_sharp,
          size: 120,
          color: Color.fromARGB(255, 63, 161, 6)),*/
                  FaIcon(
                    FontAwesomeIcons.userCircle,
                    size: 80,
                    color: Color.fromARGB(255, 63, 161, 6),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: FaIcon(
                          FontAwesomeIcons.weight,
                          size: 30,
                          color: Color.fromARGB(255, 63, 161, 6),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                        labelText: "Peso (Kg)",
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25),
                    controller: pesoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira seu Peso';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 75),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: FaIcon(
                          FontAwesomeIcons.rulerVertical,
                          size: 30,
                          color: Color.fromARGB(255, 63, 161, 6),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                        labelText: "Altura (Cm)",
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25),
                    controller: alturaController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira sua Altura';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 80),
                  ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          calcular();
                        }
                      },
                      child: Text('Calcular'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 63, 161, 6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 35),
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    info,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 63, 161, 6),
                      fontSize: 30,
                    ),
                  )
                ],
              ),
            )));
  }
}
