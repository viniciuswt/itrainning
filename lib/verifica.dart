import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:itrainning/cadastro.dart';
import 'package:itrainning/editar.dart';
import 'package:itrainning/home.dart';
import 'package:itrainning/model/userModel.dart';
import 'package:itrainning/service/userService.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VerificaPage extends StatefulWidget {
  bool loading = true;
  @override
  _VerificaPageState createState() => _VerificaPageState();
}

class _VerificaPageState extends State<VerificaPage> {
  final _formKey = GlobalKey<FormState>();
  late int id;
  late String cpf;
  late String nome;
  late String data_nascimento;
  late String idade;
  late String email;
  late String senha;

  bool loading = false;

  TextEditingController _cpf = new TextEditingController();
  TextEditingController _nome = new TextEditingController();
  TextEditingController _data_nascimento = new TextEditingController();
  TextEditingController _idade = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _senha = new TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar"),
        automaticallyImplyLeading: false,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  //-------------------------
                  TextFormField(
                      controller: _cpf,
                      inputFormatters: [
                        // obrigatório
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter(),
                      ],
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "CPF",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                      onSaved: (val) {
                        cpf = val!;
                      }),
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
                                "Proximo",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          onPressed: () {
                            if (_cpf.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "campo cpf esta vazio!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              return;
                            }

                            verifica(_cpf.text);
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

  verifica(cpf) async {
    setState(() {
      loading = true;
    });
    print("Carregando...");

    Map data = {
      'cpf': cpf,
    };
    print(data.toString());
    final response =
        await http.post(Uri.parse("https://eu-pt.host/flutter/busca.php"),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: data,
            encoding: Encoding.getByName("utf-8"));
    print("dados sys " + data.toString());
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {});
      Map<String, dynamic> resposne = jsonDecode(response.body);
      //print(resposne);
      if (!resposne['error']) {
        Map<String, dynamic> user = resposne['data'];
        String scpf = user['cpf'];

        savePref(user['cpf'], user['nome'], user['data_nascimento'],
            user['idade'], user['email'], user['senha']);
        print(user);
        String msg = resposne['message'];

        //  Navigator.pushReplacementNamed(context, "/home");
        if (_cpf.text == scpf) {
          //String id = user['id'];
          String cpf = user['cpf'];
          String nome = user['nome'];
          String dataNascimento = user['data_nascimento'];
          String idade = user['idade'];
          String email = user['email'];
          String senha = user['senha'];

          Timer(
            Duration(seconds: 3),
            () {
              loading = false;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => editarEditUser(
                    // Sid: id,
                    Scpf: cpf,
                    Snome: nome,
                    Sdata_nascimento: dataNascimento,
                    Sidade: idade,
                    Semail: email,
                    Ssenha: senha,

                    //Snome: nome,
                  ),
                ),
              );
            },
          );
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddEditUser(),
          ),
        );
      }
    }
  }
}

savePref(String cpf, String nome, String dataNascimento, String idade,
    String email, String senha) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  //preferences.setString("id", id);
  preferences.setString("cpf", cpf);
  preferences.setString("nome", nome);
  preferences.setString("data_nascimento", dataNascimento);
  preferences.setString("idade", idade);
  preferences.setString("email", email);
  preferences.setString("senha", senha);
}
