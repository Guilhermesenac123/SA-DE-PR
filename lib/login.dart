import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:navegacao/main.dart';

void main() {
  runApp(Preconfiguracao());
}

class Preconfiguracao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  LoginEstado createState() => LoginEstado();
}

class LoginEstado extends State<Login> {
  final emailControle = TextEditingController();
  final senhaControle = TextEditingController();
  bool estaCarregando = false;
  String mensagemErro = '';
  bool ocultado = true;

  Future<void> logar() async {
    // Inicia animação de carregamento
    setState(() {
      estaCarregando = true;
      mensagemErro = '';
    });
    validarCampos();

    final url = Uri.parse('https://saudepr-efd3d-default-rtdb.firebaseio.com/Pacientes%20.json');
    final resposta = await http.get(url);

    // Se a resposta for bem-sucedida (status code 200)
    if (resposta.statusCode == 200) {
      final Map<String, dynamic>? dados = jsonDecode(resposta.body);

      if (dados != null) {
        bool usuarioValido = false;
        String nomeUsuario = ''; 

        // Percorre todos os usuários e verifica se o e-mail e a senha são válidos
        dados.forEach((key, valor) {
          if (valor['email'] == emailControle.text && valor['senha'] == senhaControle.text) {
            usuarioValido = true;
            nomeUsuario = valor['nome'];
          }
        });

        // Se o usuário for válido, redireciona para o próximo screen
        if (usuarioValido == true) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Aplicativo(nomeUsuario: nomeUsuario,)));
        } else {
          // Se o e-mail ou senha estiverem errados
          setState(() {
            mensagemErro = 'E-mail ou senha invalidos';
          });
        }
      }
    } else {
      // Caso ocorra erro de conexão com a API
      setState(() {
        mensagemErro = 'Erro de conexão';
      });
    }

    // Finaliza o estado de carregamento
    setState(() {
      estaCarregando = false;
    });
  }

  void validarCampos() {
    setState(() {
      mensagemErro = '';
      if (emailControle.text.isEmpty || senhaControle.text.isEmpty) {
        mensagemErro = 'Por favor, preencha todos os campos.';
      } else {
        estaCarregando = true;
        // Adicione aqui a lógica de autenticação
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Login'),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/imagens/Logo.png", width: 250),
            SizedBox(height: 5),
            Text(
              'SAÚDE PR',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailControle,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
                prefixIconColor: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: senhaControle,
              obscureText: ocultado,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                prefixIconColor: Colors.blue,
                suffixIcon: IconButton(
                  icon: Icon(ocultado ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      ocultado = !ocultado;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            // Exibe a mensagem de erro (caso haja)
            Text(
              mensagemErro,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 30),
            estaCarregando
                ? CircularProgressIndicator()
                : ElevatedButton(onPressed: logar, child: Text('Entrar')),
            SizedBox(height: 30),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Cadastro()));
                },
                child: Text('Não tem uma conta? Cadastre-se')),
          ],
        ),
      ),
    );
  }
}

class Cadastro extends StatefulWidget {
  @override
  State<Cadastro> createState() => CadastroEstado();
}

class CadastroEstado extends State<Cadastro> {
  final nomeControle = TextEditingController();
  final emailControle = TextEditingController();
  final senhaControle = TextEditingController();
  String mensagemErro = ''; // Removido o 'final' para permitir alterações
  bool estaCarregando = false;
  bool ocultado = true;

  Future<void> validarCampos() async {
    setState(() {
      mensagemErro = '';
    });

    if (nomeControle.text.isEmpty || emailControle.text.isEmpty || senhaControle.text.isEmpty) {
      setState(() {
        mensagemErro = 'Por favor, prencha todos os campos.';
      });
      return; 
    }

    final nome = nomeControle.text;
    final email = emailControle.text;
    final senha = senhaControle.text;
    final url = Uri.parse("https://saudepr-efd3d-default-rtdb.firebaseio.com/Pacientes%20.json"); 

    setState(() {
      estaCarregando = true;
    });

    try {
      final resposta = await http.post(
        url,
        body: jsonEncode({'nome': nome, 'email': email, 'senha': senha}),
        headers: {'Content-Type': 'application/json'},
      );

      if (resposta.statusCode == 200) {
        setState(() {
          mensagemErro = 'Cadastro realizado com sucesso!';
        });
        Navigator.pop(context); // Volta para a tela de login após cadastro
      } else {
        setState(() {
          mensagemErro = 'Erro ao cadastrar. Tente novamente.';
        });
      }
    } catch (e) {
      setState(() {
        mensagemErro = 'Erro de conexão: $e';
      });
    } finally {
      setState(() {
        estaCarregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de novo usuário'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_add, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            TextField(
              controller: nomeControle,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
                prefixIconColor: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailControle,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
                prefixIconColor: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: senhaControle,
              obscureText: ocultado,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                prefixIconColor: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            Text(
              mensagemErro,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 30),
            estaCarregando
                ? CircularProgressIndicator()
                : ElevatedButton(onPressed: validarCampos, child: Text('Cadastrar')),
          ],
        ),
      ),
    );
  }
}
