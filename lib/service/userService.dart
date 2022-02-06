import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itrainning/model/userModel.dart';

class UserService {
  addUser(UserModel userModel) async {
    final response = await http.post(
        Uri.parse('https://eu-pt.host/flutter/add.php'),
        body: userModel.toJsonAdd());
    if (response.statusCode == 200) {
      String res = response.body;
      print("Resposta do verifica: " + res);
      if (res.isEmpty) {
        print("Resposta do verifica: ");
      } else {
        print("Resposta do verifica: " + res);
        return "Error";
      }
    }

    verificaUser(VerificaModel verificaModel) async {
      final response = await http.post(
          Uri.parse('https://eu-pt.host/flutter/verifica.php'),
          body: verificaModel.toJsonVerifica());
      if (response.statusCode == 200) {
        String res = response.body;
        print("Resposta do verifica: " + res);
        if (res.isEmpty) {
          print("Resposta do verifica: ");
        } else {
          print("Resposta do verifica: " + res);
          return "Error";
        }
      }
    }
  }

  List<UserModel> userFromJson(String jsonString) {
    final data = jsonDecode(jsonString);
    return List<UserModel>.from(data.map((item) => UserModel.fromJson(item)));
  }
}

/*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );*/
