
class UserModel{
  int id;
  String nome;
  String email;
  DateTime dataNascimento;
  String cpf;
  String cep;
  String endereco;
  String numero;
  String senha;

  UserModel({this.nome, this.email, this.dataNascimento, this.cpf,
  this.cep, this.endereco, this.numero, this.senha});

  UserModel.fromMap(Map map){
    this.id = map['id'];
    this.nome = map['nome'];
    this.email = map['email'];
    this.dataNascimento = DateTime.parse(map['data_nascimento']);
    this.cpf = map['cpf'];
    this.cep = map['cep'];
    this.endereco = map['endereco'];
    this.numero = map['numero'];
    this.senha = map['senha'];
  }

  toMap(){
    return{
      'id': null,
      'nome': this.nome,
      'email': this.email,
      'data_nascimento': this.dataNascimento.toString(),
      'cpf': this.cpf.replaceAll('.', '').replaceAll('-', ''),
      'cep': this.cep.replaceAll('-', ''),
      'endereco': this.endereco,
      'numero': this.numero,
      'senha': this.senha
    };
  }
}