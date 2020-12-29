import 'package:flutter/material.dart';

void main () {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String _infoText = 'Informe seus dados!';

  void _calculate () {
    setState(() {
      double peso = double.parse(weightController.text);
      double altura = double.parse(heightController.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 17){
        _infoText = 'Muito abaixo do peso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 17 && imc < 18.5 ){
        _infoText = 'Abaixo do peso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 18.5 && imc < 25){
        _infoText = 'Peso ideal (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 25 && imc < 30){
        _infoText = 'Acima do peso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 30 && imc < 35){
        _infoText = 'Obesidade (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 35 && imc < 40) {
        _infoText = 'Obesidade severa (${imc.toStringAsPrecision(3)})';
      } else {
        _infoText = 'Obesidade mórbida (${imc.toStringAsPrecision(3)})';
      }
      });
  }

  void _resetfields (){
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados!';
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      //BARRA DE CIMA
      appBar: AppBar(
        title: Text('Calculadora do IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions:<Widget> [
          IconButton(icon: Icon(Icons.refresh), 
          onPressed: _resetfields),
        ],
      ),
      
      //COLUNA, ALINHAMENTO DAS BORDAS
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget> [
          
          //ÍCONE
          Icon(Icons.person_outline, size: 120.0, color: Colors.green,),
          
          // CAMPO RECEPTOR DOS VALORES
          TextFormField(
            keyboardType: TextInputType.number, 
            decoration: InputDecoration(
              labelText: 'Peso (kg)', 
              labelStyle: TextStyle(color: Colors.green)),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 25.0),
            controller: weightController,
            validator: (value) {
              if(value.isEmpty){
                return 'Insira seu peso!';
              }
            },
            ),
            
          // CAMPO RECEPTOR DOS VALORES
          TextFormField(
            keyboardType: TextInputType.number, 
            decoration: InputDecoration(
              labelText: 'Altura (cm)', 
              labelStyle: TextStyle(color: Colors.green)),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 25.0),
            controller: heightController,
            validator: (value) {
              if(value.isEmpty){
                return 'Insira sua altura!';
              }
            },
            ),
            
            // BOTÃO CALCULAR
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
              height: 50.0,
              child: RaisedButton(
              onPressed: () {
                if(_formKey.currentState.validate()){
                  _calculate();
              }},
              child:Text('Calcular', 
              style: TextStyle(color: Colors.white, fontSize: 25.0)),
              color: Colors.green,
            )),
            ),
            
            // TEXTO ABAIXO
            Text(_infoText, 
              textAlign: TextAlign.center, 
              style: TextStyle(color: Colors.green, fontSize: 25.0),)
        ],
      )), 
      )
    );
  }
}
