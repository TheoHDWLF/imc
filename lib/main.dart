import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Calculadora de IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _cPeso = TextEditingController();
  final _cAltura = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _resultIMC = '';

  void _calIMC() {
    double altura = int.parse(this._cAltura.text) / 100;
    double quadrado = altura * altura;
    double imc = double.parse(
        (int.parse(this._cPeso.text) / quadrado).toStringAsFixed(1));

    setState(() {
      if (imc < 18.5) {
        this._resultIMC = "Abaixo do peso $imc";
      } else if (imc <= 24.9) {
        this._resultIMC = "Peso ideal $imc";
      } else if (imc <= 29.9) {
        this._resultIMC = "Levemente acima do Peso $imc";
      } else if (imc <= 34.9) {
        this._resultIMC = "Obesidade grau I $imc";
      } else if (imc <= 39.9) {
        this._resultIMC = "Obesidade grau II $imc";
      } else {
        this._resultIMC = "Obesidade grau III $imc";
      }
    });
  }

  void _refresh() {
    setState(() {
      this._resultIMC = '';
      this._cPeso.clear();
      this._cAltura.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _refresh();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Icon(
            Icons.person_outlined,
            color: Colors.green,
            size: 100.0,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso(kg)",
                  ),
                  controller: _cPeso,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Informe o Peso";
                    }

                    if (int.parse(value) < 0) {
                      return "Peso inválido";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura(cm)",
                  ),
                  controller: _cAltura,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Informe o Altura";
                    }

                    if (int.parse(value) < 50) {
                      return "Altura inválida";
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 400.0,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calIMC();
                      }
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(
                    _resultIMC,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
