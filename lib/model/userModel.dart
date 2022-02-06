class UserModel {
  String cpf;
  String data_nascimento;
  String email;
  String idade;
  String nome;
  String senha;

  UserModel({
    required this.cpf,
    required this.data_nascimento,
    required this.email,
    required this.idade,
    required this.nome,
    required this.senha,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      cpf: json['cpf'] as String,
      data_nascimento: json['data_nascimento'] as String,
      email: json['email'] as String,
      idade: json['idade'] as String,
      nome: json['nome'] as String,
      senha: json['senha'] as String,
    );
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "cpf": cpf,
      "data_nascimento": data_nascimento,
      "email": email,
      "idade": idade,
      "nome": nome,
      "senha": senha,
    };
  }

  toJsonVerifica() {}
}

class VerificaModel {
  String cpf;

  VerificaModel({
    required this.cpf,
  });

  factory VerificaModel.fromJson(Map<String, dynamic> json) {
    return VerificaModel(
      cpf: json['cpf'] as String,
    );
  }

  Map<String, dynamic> toJsonVerifica() {
    return {
      "cpf": cpf,
    };
  }
}
