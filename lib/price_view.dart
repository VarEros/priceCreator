import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:pricecreator/utils/user_simple_preferences.dart';

class PriceView extends StatefulWidget {
  const PriceView({super.key});

  @override
  State<PriceView> createState() => _PriceViewState();
}

class _PriceViewState extends State<PriceView> {
  final _txtConNoRefri = TextEditingController();
  final _txtConRefri = TextEditingController();

  @override
  void initState() {
    _txtConNoRefri.text = '1.20';
    _txtConNoRefri.text = '1.25';
    if(UserSimplePreferences.getGananciasNoRefri().toString() != 'null') {
      _txtConNoRefri.text = UserSimplePreferences.getGananciasNoRefri().toString();
    }
    if(UserSimplePreferences.getGananciasRefri().toString() != 'null') {
      _txtConRefri.text = UserSimplePreferences.getGananciasRefri().toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajuste de ganacias'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ganancia refrigerado'),
                TextField(
                  controller: _txtConRefri,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
                  ],
                  decoration: const InputDecoration(hintText: 'Ej: 1.20'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ganancia no refrigerado'),
                TextField(
                  
                  controller: _txtConNoRefri,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
                  ],
                  decoration: const InputDecoration(hintText: 'Ej: 1.25'),
                ),
              ],
            ),
            const Spacer(),
            MaterialButton(
              onPressed: () async {
                try{
                if(_txtConRefri.text == '' || _txtConNoRefri.text == ''){
                  return;
                }
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Se ha guardado correctamente.")));
                await UserSimplePreferences.setGanancias(
                    double.parse(_txtConRefri.text),
                    double.parse(_txtConNoRefri.text));
                    // Fluttertoast.showToast(
                    //   msg: "se ha guardado correctamente.",
                    //   toastLength: Toast.LENGTH_LONG,
                    //   gravity: ToastGravity.BOTTOM,
                    //   webPosition: 'center',
                    //   timeInSecForIosWeb: 3,
                    //   backgroundColor: Colors.red,
                    //   textColor: Colors.white,
                    //   fontSize: 16.0
                    // );
                    
                }catch(e){
                    // Fluttertoast.showToast(
                    //   msg: "ha ocurrido un error al guardar.",
                    //   toastLength: Toast.LENGTH_LONG,
                    //   gravity: ToastGravity.BOTTOM,
                    //   webPosition: 'center',
                    //   timeInSecForIosWeb: 3,
                    //   backgroundColor: Colors.red,
                    //   textColor: Colors.white,
                    //   fontSize: 16.0
                    // );
                    ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Ha ocurrido un error al guardar.")));
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
