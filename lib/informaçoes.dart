// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class CadastrarPostagem extends StatefulWidget {
//   final String username;
//   CadastrarPostagem({required this.username});

//   @override
//   CadastrarPostagemEstado createState() => CadastrarPostagemEstado();
// }

// class CadastrarPostagemEstado extends State<CadastrarPostagem> {
//   final tituloControle = TextEditingController();
//   final conteudoControle = TextEditingController();
//   final imagemControle = TextEditingController();

//   @override
//   void dispose() {
//     tituloControle.dispose();
//     conteudoControle.dispose();
//     imagemControle.dispose();
//     super.dispose();
//   }

//   Future<void> cadastrarPostagem() async {
//     final titulo = tituloControle.text;
//     final conteudo = conteudoControle.text;
//     final imagem = imagemControle.text;

//     if (titulo.isNotEmpty && conteudo.isNotEmpty) {
//       final url = Uri.parse("https://duoware-5d706-default-rtdb.firebaseio.com/postagem.json");
//       await http.post(
//         url,
//         body: jsonEncode({
//           'titulo': titulo,
//           'conteudo': conteudo,
//           'imagem': imagem,
//           'autor': widget.username,
//         }),
//       );

//       tituloControle.clear();
//       conteudoControle.clear();
//       imagemControle.clear();

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Postagem criada com sucesso!')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cadastre seu post'),
//         backgroundColor: const Color.fromARGB(255, 160, 5, 231),
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: tituloControle,
//               decoration: InputDecoration(labelText: 'Título da postagem'),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: conteudoControle,
//               decoration: InputDecoration(labelText: 'Conteúdo da postagem'),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: imagemControle,
//               decoration: InputDecoration(labelText: 'Link da imagem'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: cadastrarPostagem,
//               child: Text("Postar"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MinhasPostagens extends StatefulWidget {
//   final String username;
//   MinhasPostagens({required this.username});

//   @override
//   MinhasPostagensEstado createState() => MinhasPostagensEstado();
// }

// class MinhasPostagensEstado extends State<MinhasPostagens> {
//   Future<void> deletar(String id) async {
//     final url = Uri.parse("https://saudepr-efd3d-default-rtdb.firebaseio.com/Pacientes%20.json");
//     await http.delete(url);
//   }

//   Future<List<Map<String, dynamic>>> buscarPostagens() async {
//     final url = Uri.parse('https://saudepr-efd3d-default-rtdb.firebaseio.com/Pacientes%20.json');
//     final resposta = await http.get(url);
//     final Map<String, dynamic> dados = jsonDecode(resposta.body);

//     final List<Map<String, dynamic>> posts = [];
//     dados.forEach((key, valor) {
//       if (valor['autor'] == widget.username) {
//         posts.add({
//           'id': key,
//           'titulo': valor['titulo'],
//           'conteudo': valor['conteudo'],
//           'autor': valor['autor'],
//           'imagem': valor['imagem'],
//         });
//       }
//     });

//     return posts;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Minhas postagens"),
//         backgroundColor: const Color.fromARGB(255, 145, 11, 223),
//         foregroundColor: Colors.white,
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: buscarPostagens(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text("Erro ao carregar postagens"));
//           }
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text("Sem postagens para exibir"));
//           }

//           final posts = snapshot.data!;
//           return ListView.builder(
//             itemCount: posts.length,
//             itemBuilder: (context, index) {
//               final post = posts[index];
//               return Card(
//                 elevation: 5,
//                 margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                 child: Column(
//                   children: [
//                     post['imagem'] == null || post['imagem'].isEmpty
//                         ? SizedBox()
//                         : Image.network(post['imagem'], width: 400),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(post['titulo'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                           SizedBox(height: 8),
//                           Text(post['conteudo']),
//                           SizedBox(height: 16),
//                           Row(
//                             children: [
//                               Icon(Icons.person_pin, color: Colors.blue),
//                               SizedBox(width: 8),
//                               Text("Autor: ${post['autor']}", style: TextStyle(fontSize: 14, color: Colors.blue)),
//                             ],
//                           ),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 await deletar(post['id']);
//                                 setState(() {}); // Atualiza a tela
//                               },
//                               child: Icon(Icons.delete, color: Colors.red),
//                               style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }