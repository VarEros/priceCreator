import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final _textController = TextEditingController();
  double salePrice = 0;
  bool isRefriged = false;
  String pricePrint = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de precios'),
          backgroundColor: Colors.cyan,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 350, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: _textController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), 
                  hintText: 'Precio de compra'
                ),
              ),
              FractionallySizedBox(
                widthFactor: 1,
                child: MaterialButton(
                  
                  onPressed: () 
                  {
                    try {
                      salePrice = getSalePrice();
                      setState(() {
                        pricePrint = salePrice.toString();
                      });
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: "ingresa un numero.",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        webPosition: 'center',
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                      );
                    }
                  },
                  color: Colors.lightBlue,
                  child: const Text('Calcular', style: TextStyle(color: Colors.white)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Es refrigerado?',
                      style:  TextStyle(fontSize: 16.0),
                    ),
                    Switch(
                      // This bool value toggles the switch.
                      value: isRefriged,
                      activeColor: Colors.red,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          isRefriged = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Text(pricePrint),
            ],
          ),
        )
      ),
    );
  }

  double getSalePrice() {
    final purchasePrice = double.parse(_textController.text);
    if(isRefriged) {
      return purchasePrice * 1.25;
    }
    return purchasePrice * 1.20;
  }
}