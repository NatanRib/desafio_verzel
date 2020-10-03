
class AddressModel{
  String cep;
  String logradouro;
  String complemento;
  String numero;
  String bairro;
  String cidade;
  String estado; 

  AddressModel.fromJson(Map json){
    this.cep = json['cep'];
    this.logradouro = json['logradouro'];
    this.complemento = json['complemento'];
    this.numero = json['numero'];
    this.bairro = json['bairro'];
    this.cidade = json['localidade'];
    this.estado = json['uf'];
  }
}