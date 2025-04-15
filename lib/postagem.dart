import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CadastrarPostagem extends StatefulWidget {
  final String username;
  CadastrarPostagem({required this.username});

  @override
  CadastrarPostagemEstado createState() => CadastrarPostagemEstado();
}

class CadastrarPostagemEstado extends State<CadastrarPostagem> {
  @override
  Widget build(BuildContext context) {
    final tituloControle = TextEditingController();
    final conteudoControle = TextEditingController();
    final imagemControle = TextEditingController();

    Future<void> cadastrarPostagem() async {
      final titulo = tituloControle.text;
      final conteudo = conteudoControle.text;
      final imagem = imagemControle.text;

      if (titulo.isNotEmpty && conteudo.isNotEmpty) {
        final url = Uri.parse("https://saudepr-efd3d-default-rtdb.firebaseio.com/Postagem.json");
        final resposta = await http.post(
          url,
          body: jsonEncode({
            'titulo': titulo,
            'conteudo': conteudo,
            'imagem': imagem,
            'autor': widget.username,
          }),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastre seu post!'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Alinhamento ao centro
          children: [
            TextField(
              controller: tituloControle,
              decoration: InputDecoration(labelText: 'Título da Postagem'),
              textAlign: TextAlign.center, // Texto ao centro
            ),
            SizedBox(height: 16),
            TextField(
              controller: conteudoControle,
              decoration: InputDecoration(labelText: 'Conteúdo da Postagem'),
              maxLines: 4,
              textAlign: TextAlign.center, // Texto ao centro
            ),
            SizedBox(height: 16),
            TextField(
              controller: imagemControle,
              decoration: InputDecoration(labelText: 'Link da imagem'),
              textAlign: TextAlign.center, // Texto ao centro
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: cadastrarPostagem, child: Text("Postar")),
          ],
        ),
      ),
    );
  }
}

class VerPostagens extends StatelessWidget {
  Future<List<Map<String, dynamic>>> buscarPostagem() async {
    final url = Uri.parse('https://saudepr-efd3d-default-rtdb.firebaseio.com/Postagem.json');
    final resposta = await http.get(url);
    final Map<String, dynamic> dados = jsonDecode(resposta.body);
    final List<Map<String, dynamic>> posts = [];
    dados.forEach((key, valor) {
      posts.add({
        'titulo': valor['titulo'],
        'conteudo': valor['conteudo'],
        'autor': valor['autor'],
        'imagem': valor['imagem'],
      });
    });
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ver postagem!"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: buscarPostagem(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar postagens!"));
          }
          if (snapshot.data!.isEmpty) {
            return Center(child: Text("Sem postagens para exibir!"));
          }
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Alinhamento ao centro
                  children: [
                    post['imagem'] == null || post['imagem'].isEmpty
                        ? SizedBox()
                        : Image.network(post['imagem'], width: 400),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center, // Alinhamento ao centro
                        children: [
                          Text(
                            post['titulo'],
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center, // Texto ao centro
                          ),
                          Text(
                            post['conteudo'],
                            textAlign: TextAlign.center, // Texto ao centro
                          ),
                          SizedBox(height: 16),
                          Icon(Icons.person_pin, color: Colors.blueGrey),
                          Text(
                            "Autor: " + post['autor'],
                            style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                            textAlign: TextAlign.center, // Texto ao centro
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
