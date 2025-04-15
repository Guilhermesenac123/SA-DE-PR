import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Pacientes {
  String id;
  String nome;
  String email;
  String telefone;
  String endereco;
  String cidade;
  String idade;
  String genero;
  String tiposanguineo;
 

  Pacientes(this.id,this.nome, this.email, this.telefone, this.endereco, this.cidade, this.idade, this.genero, this.tiposanguineo, );
}

class Cadastro extends StatefulWidget {
  final List<Pacientes> pessoas;
  const Cadastro({super.key, required this.pessoas});

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final nomeControle = TextEditingController();
  final emailControle = TextEditingController();
  final telefoneControle = TextEditingController();
  final enderecoControle = TextEditingController();
  final cidadeControle = TextEditingController();
  final idadeControle = TextEditingController();
  final generoControle = TextEditingController();
  final tiposanguineoControle = TextEditingController();


  //Criando metodo de cadastro//

  Future<void> cadastrarPessoa(Pacientes pessoa) async {
    final url = Uri.parse("https://saudepr-efd3d-default-rtdb.firebaseio.com/Pacientes.json");
    final resposta = await http.post( url, body: jsonEncode({
      "nome": pessoa.nome,
      "email": pessoa.email,
      "telefone": pessoa.endereco,
      "cidade": pessoa.cidade,
      "idade": pessoa.idade,
      "genero": pessoa.genero,
      "tipo sanguineo": pessoa.tiposanguineo,
       
      }));
  }
  
  
  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Pessoas"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Cadastro de Contato",
              style: TextStyle(fontSize: 30),
            ),
            TextField(
                controller: nomeControle,
                decoration: InputDecoration(labelText: 'Nome')),
            TextField(
                controller: emailControle,
                decoration: InputDecoration(labelText: 'Email')),
            TextField(
                controller: telefoneControle,
                decoration: InputDecoration(labelText: 'Telefone')),
            TextField(
                controller: enderecoControle,
                decoration: InputDecoration(labelText: 'Endereço')),
            TextField(
                controller: cidadeControle,
                decoration: InputDecoration(labelText: 'Cidade')),
            TextField(
                controller: idadeControle,
                decoration: InputDecoration(labelText: 'Idade')),
            TextField(
                controller: generoControle,
                decoration: InputDecoration(labelText: 'Genero')),
            TextField(
                controller: tiposanguineoControle,
                decoration: InputDecoration(labelText: 'Tipo Sanguineo')),






            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  
                  Pacientes pessoaNova = Pacientes(
                    "",
                    nomeControle.text,
                    emailControle.text,
                    telefoneControle.text,
                    enderecoControle.text,
                    cidadeControle.text,
                    idadeControle.text,
                    generoControle.text,
                    tiposanguineoControle.text,
                  );
                //  widget.pessoas.add(pessoaNova);
                  cadastrarPessoa(pessoaNova);

                  
                  nomeControle.clear();
                    emailControle.clear();
                    telefoneControle.clear();
                    enderecoControle.clear();
                    cidadeControle.clear();
                    idadeControle.clear();
                    generoControle.clear();
                    tiposanguineoControle.clear();
                });
              },
              child: Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
