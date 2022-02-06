import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itrainning/home.dart';
import 'package:itrainning/login.dart';
import 'package:itrainning/model/userModel.dart';
//import 'package:itrainning/service/userService.dart';
import 'package:http/http.dart' as http;

class AddEditUser extends StatefulWidget {
  @override
  _AddEditUserState createState() => _AddEditUserState();
}

class _AddEditUserState extends State<AddEditUser> {
  TextEditingController cpf = TextEditingController();
  TextEditingController data_nascimento = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController idade = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController senha = TextEditingController();
  bool loading = false;

  add(UserModel userModel) async {
    await addUser(userModel).then((success) {
      Fluttertoast.showToast(
        msg: "Salvo com sucesso!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pop(context);
    });
  }

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
                  //--------------------
                  TextFormField(
                    //autofocus: true,
                    controller: nome,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Nome",
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
                    controller: cpf,
                    inputFormatters: [
                      // obrigatório
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                    //autofocus: true,

                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "CPF",
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
                      labelText: "Data de nascimento",
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
                      labelText: "Idade",
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
                      labelText: "Email",
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
                      labelText: "Senha",
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
                                "Salvar",
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
                            loading = true;
                            if (nome.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "campo Nome esta vazio!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              UserModel userModel = UserModel(
                                  cpf: cpf.text,
                                  data_nascimento: data_nascimento.text,
                                  email: email.text,
                                  idade: idade.text,
                                  nome: nome.text,
                                  senha: senha.text);

                              add(userModel);
                            }
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

  addUser(UserModel userModel) async {
    final response = await http.post(
        Uri.parse('https://eu-pt.host/flutter/add.php'),
        body: userModel.toJsonAdd());
    if (response.statusCode == 200) {
      //String res = response.body;
      print("Resposta do verifica: " + response.body);
      Navigator.pop(context);
      loading = false;
    } else {
      print("Resposta do verifica: " + response.body);
      Navigator.pop(context);
      loading = false;
    }
    return "Error";
  }
}
