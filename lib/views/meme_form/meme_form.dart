import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meme_maker/controllers/meme_controller.dart';
import 'package:meme_maker/models/meme_model.dart';
import 'package:meme_maker/shared/config.dart';

class MemeForm extends StatefulWidget {
  final MemeController memeController;
  MemeModel? meme;

  MemeForm(this.memeController, this.meme, {Key? key}) : super(key: key);

  @override
  State<MemeForm> createState() => _MemeFormState();
}

class _MemeFormState extends State<MemeForm> {
  String upperText = '';
  String bottomText = '';
  String? imageName;

  _checkMemeForEdit() {
    if (widget.meme != null) {
      upperText = widget.meme!.upperText;
      bottomText = widget.meme!.bottomText;
      imageName = widget.meme!.image;
    }
  }

  _setMeme() {
    if (imageName == null) {
      return SvgPicture.asset('assets/images/placeholder.svg');
    } else {
      final bottomTextModified =
          bottomText.isNotEmpty ? bottomText.replaceAll(' ', '+') : '';
      final uppperTextModified =
          upperText.isNotEmpty ? upperText.replaceAll(' ', '+') : '';
      return Image(
          image: NetworkImage(Config.basePublicUrl +
              'meme?meme=$imageName&top=$uppperTextModified&bottom=$bottomTextModified'));
    }
  }

   @override
  void initState() {
    super.initState();
    _checkMemeForEdit();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 180, height: 180, child: _setMeme()),
          DropdownButton<String>(
            isExpanded: true,
            value: imageName,
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
                imageName = newValue!;
              });
            },
            items: widget.memeController.images
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Focus(
              child: TextFormField(
                  initialValue: upperText,
                  decoration: const InputDecoration(
                      alignLabelWithHint: true, labelText: 'Frase de Cima'),
                  onChanged: (text) {
                    upperText = text;
                  }),
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  setState(() {
                    _setMeme();
                  });
                }
              }),
          Focus(
              child: TextFormField(
                  initialValue: bottomText,
                  decoration: const InputDecoration(
                      alignLabelWithHint: true, labelText: 'Frase de Baixo'),
                  onChanged: (text) {
                    bottomText = text;
                  }),
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  setState(() {
                    _setMeme();
                  });
                }
              }),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              onPressed: () async {
                //checar se os campos foram preenchidos
                if (imageName == null) {
                  Fluttertoast.showToast(
                      msg: "Escolha pelo menos uma imagem",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  try {
                    if(widget.meme != null){
                      widget.meme?.upperText = upperText;
                      widget.meme?.bottomText = bottomText;
                      widget.meme?.image = imageName.toString();
                      await widget.memeController.update(widget.meme!);
                    }
                    else {
                    await widget.memeController.create(MemeModel(
                        null, imageName.toString(), upperText, bottomText));
                    }
                    Fluttertoast.showToast(
                        msg: widget.meme != null ? "Meme editado!" : "Meme criado!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.pop(context);
                  } catch (e) {
                    Fluttertoast.showToast(
                        msg: "Algo deu errado =(",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                }
              },
              child: Text(widget.meme != null ? 'Editar' : 'Criar'),
            ),
          )
        ],
      ),
    ));
  }
}
