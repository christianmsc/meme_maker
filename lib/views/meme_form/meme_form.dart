import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../components/nav_bar_back.dart';

class MemeForm extends StatefulWidget {
  const MemeForm({Key? key}) : super(key: key);

  @override
  State<MemeForm> createState() => _MemeFormState();
}

class _MemeFormState extends State<MemeForm> {
  final String title = 'Criar Meme';

  String upperText = '';

  String bottomText = '';

  String? urlImage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Scaffold(
            appBar: NavBarBack(title: title).build(context),
            body: Form(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 180,
                      height: 180,
                      child: SvgPicture.asset('assets/images/placeholder.svg')),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: urlImage,
                    icon: const Icon(Icons.arrow_downward, color: Colors.black54),
                    elevation: 16,
                    focusColor: Colors.red,
                    hint: const Text('Selecione uma imagem...'),
                    style: const TextStyle(color: Colors.black54),
                    underline: Container(
                      height: 2,
                      color: Colors.black38,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        urlImage = newValue!;
                      });
                    },
                    items: <String>['One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  TextField(
                      decoration: const InputDecoration(
                          alignLabelWithHint: true, labelText: 'Frase de Cima'),
                      onChanged: (text) {
                        upperText = text;
                      }),
                  TextField(
                      decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'Frase de Baixo'),
                      onChanged: (text) {
                        bottomText = text;
                      }),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: ElevatedButton(
                      onPressed: () {
                        //checar se os campos foram preenchidos
                        if (urlImage == null) {
                          Fluttertoast.showToast(
                              msg: "Escolha pelo menos uma imagem",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                        else {
                           Fluttertoast.showToast(
                              msg: "Meme criado!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: const Text('Criar'),
                    ),
                  )
                ],
              ),
            ))));
  }
}
