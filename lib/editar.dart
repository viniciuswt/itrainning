import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itrainning/cadastro.dart';
import 'package:itrainning/model/userModel.dart';
import 'package:itrainning/service/userService.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class editarEditUser extends StatefulWidget {
  //String Sid;
  String Scpf;
  String Snome;
  String Sdata_nascimento;
  String Sidade;
  String Semail;
  String Ssenha;
  //String Semail;
  //late String Snome;

  editarEditUser(
      { //required this.Sid,
      required this.Scpf,
      required this.Snome,
      required this.Sdata_nascimento,
      required this.Sidade,
      required this.Semail,
      required this.Ssenha});

  bool loading = false;

  @override
  _AddEditUserState createState() => _AddEditUserState();
}

class _AddEditUserState extends State<editarEditUser> {
  TextEditingController cpf = TextEditingController();
  TextEditingController data_nascimento = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController idade = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //print(scpf);
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            //--------------------
            TextFormField(
              enabled: false,
              controller: cpf,

              inputFormatters: [
                // obrigatório
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter(),
              ],

              //autofocus: true,

              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "${widget.Scpf}",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            //--------------------
            TextFormField(
              //autofocus: true,
              controller: nome,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "${widget.Snome}",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            //-------------------------
            TextFormField(
              controller: data_nascimento,
              inputFormatters: [
                // obrigatório
                FilteringTextInputFormatter.digitsOnly,
                DataInputFormatter(),
              ],
              //autofocus: true,

              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "${widget.Sdata_nascimento}",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            //-------------------------
            TextFormField(
              controller: idade,
              //autofocus: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "${widget.Sidade}",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            //-------------------------
            TextFormField(
              controller: email,
              // autofocus: true,

              keyboardType: TextInputType.emailAddress,

              decoration: InputDecoration(
                labelText: "${widget.Semail}",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //-------------
            TextFormField(
              controller: senha,
              //autofocus: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "${widget.Ssenha}",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            //-------------------------
            Container(
              height: 40,
              alignment: Alignment.centerRight,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Color.fromRGBO(70, 130, 180, 30),
                    Color.fromRGBO(70, 130, 180, 80),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: SizedBox.expand(
                child: RaisedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Salvar Alteração",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          child: SizedBox(
                            child: Image.asset("assets/login.png"),
                            height: 28,
                            width: 28,
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      String Enome;
                      String EdataNascimento;
                      String Eidade;
                      String Eemail;
                      String Esenha;

                      if (nome.text.isEmpty) {
                        Enome = "${widget.Snome}";
                      } else {
                        Enome = nome.text;
                      }
                      if (data_nascimento.text.isEmpty) {
                        EdataNascimento = "${widget.Sdata_nascimento}";
                      } else {
                        EdataNascimento = data_nascimento.text;
                      }
                      if (idade.text.isEmpty) {
                        Eidade = "${widget.Sidade}";
                      } else {
                        Eidade = idade.text;
                      }
                      if (email.text.isEmpty) {
                        Eemail = "${widget.Semail}";
                      } else {
                        Eemail = email.text;
                      }
                      if (senha.text.isEmpty) {
                        Esenha = "${widget.Ssenha}";
                      } else {
                        Esenha = senha.text;
                      }
                      //print("${widget.Snome}");
                      editar("${widget.Scpf}", Enome, EdataNascimento, Eidade,
                          Eemail, Esenha);
                    }),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  editar(cpf, nome, dataNascimento, idade, email, senha) async {
    setState(() {
      // loading = true;
    });
    print("Carregando...");

    Map data = {
      'cpf': cpf,
      'nome': nome,
      'data_nascimento': dataNascimento,
      'idade': idade,
      'email': email,
      'senha': senha,
    };
    print(data.toString());
    final response =
        await http.post(Uri.parse("https://eu-pt.host/flutter/modifica.php"),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: data,
            encoding: Encoding.getByName("utf-8"));
    print("dados sys " + data.toString());
    print(response.statusCode);
    Fluttertoast.showToast(
        msg: "Dados alterados com sucesso!!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pop(context);
  }
}
