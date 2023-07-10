import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pricecreator/price_view.dart';
import 'package:pricecreator/utils/user_simple_preferences.dart';

import 'menu_item.dart';
import 'menu_items.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage()
    );
  }
}


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final _textController = TextEditingController();
  double salePrice = 0;
  bool isRefriged = false;
  String pricePrint = '';
  
  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
    value: item,
    child: Text(item.text)
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de precios'),
        backgroundColor: Colors.cyan,
        actions: [
          PopupMenuButton<MenuItem>(
            itemBuilder: (context) => [
              ...MenuItems.itemsFirst.map(buildItem).toList()
            ],
            onSelected: (item) => onSelected(context, item),
          )
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  // Fluttertoast.showToast(
                  //   msg: "ingresa un numero.",
                  //   toastLength: Toast.LENGTH_LONG,
                  //   gravity: ToastGravity.BOTTOM,
                  //   webPosition: 'center',
                  //   timeInSecForIosWeb: 3,
                  //   backgroundColor: Colors.red,
                  //   textColor: Colors.white,
                  //   fontSize: 16.0
                  // );
                }
              },
              color: Colors.lightBlue,
              child: const Text('Calcular', style: TextStyle(color: Colors.white)),
            ),
          ),
          Text(pricePrint),
        ],
      )
    );
  }
  double getSalePrice() {
    final gananciasRefri = UserSimplePreferences.getGananciasRefri() ?? 1.25;
    final gananciasNoRefri = UserSimplePreferences.getGananciasNoRefri() ?? 1.20;
    final purchasePrice = double.parse(_textController.text);
    if(isRefriged) {
      return purchasePrice * gananciasRefri;
    }
    return purchasePrice * gananciasNoRefri;
  }
  
  onSelected(BuildContext context, MenuItem item) {
    switch(item) {
      case MenuItems.itemSettings:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const PriceView())
        );
      break;
    }
  }
}