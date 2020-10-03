import 'package:http/http.dart' as http;

class ApiCep{

  Future consulta(String cep)async{
    final urlBase = 'https://viacep.com.br/ws/$cep/json/';
    String andress;
    try{
      http.Response andress =  await http.get(urlBase);  
      return andress.body;
    }catch(e){
      print(e.toString());
    }
  }
}