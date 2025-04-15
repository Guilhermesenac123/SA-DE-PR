import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:navegacao/Detalhes.dart';
import 'package:navegacao/Tela1.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class TabelaPai extends StatefulWidget {
  @override
  Tabela createState() => Tabela();
}

class Tabela extends State<TabelaPai> {
  final List<Pacientes> pacientess = [];

  Future<void> excluir(String id) async {
    final url = Uri.parse(
        "https://saudepr-efd3d-default-rtdb.firebaseio.com/pacientes/$id.json");
    final resposta = await http.delete(url);

    if (resposta.statusCode == 200) {
      setState(() {
        pacientess.clear();
        buscarPacientes();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    buscarPacientes();
  }

  Future<void> buscarPacientes() async {
    final url = Uri.parse(
        "https://saudepr-efd3d-default-rtdb.firebaseio.com/Pacientes.json");
    final resposta = await http.get(url);
    print(resposta.body);
    final Map<String, dynamic>? dados = jsonDecode(resposta.body);
    if (dados != null) {
      dados.forEach((id, dadosPacientes) {
        setState(() {
          Pacientes pacientesNova = Pacientes(
              id,
              dadosPacientes["nome"] ?? '',
              dadosPacientes["email"] ?? '',
              dadosPacientes["telefone"] ?? '',
              dadosPacientes["endereco"] ?? '',
              dadosPacientes["cidade"] ?? '',
              dadosPacientes["idade"]??'',
              dadosPacientes["genero"]??'',
              dadosPacientes["tipo sanguineo"]??''
              
              );
          pacientess.add(pacientesNova);
        });
      });
    }
    ;
  }

  Future<void> abrirWhats(String telefone) async {
    final url = Uri.parse('https://wa.me/$telefone');
    if (!await launchUrl(url)) {
      throw Exception('Não pode iniciar $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Contatos"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: pacientess.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.person),
              title: Text(pacientess[index].nome),
              subtitle: Text(
                 "Email: " + pacientess[index].email
                 ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () => abrirWhats(pacientess[index].telefone),
                      icon: Icon(
                        Icons.message,
                        color: Colors.green,
                      )),
                  IconButton(
                      onPressed: () => excluir(pacientess[index].id),
                      icon: Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                      )),
                ],
              ),
              //Quando clicar no item da lista (onTap)
                onTap: (){
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => Detalhes(pacientes:pacientess[index],)));
               },
            );
          },
        ),
      ),
    );
  }
}
