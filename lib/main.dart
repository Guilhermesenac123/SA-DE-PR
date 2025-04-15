import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:navegacao/informa%C3%A7oes.dart';
import 'package:navegacao/postagem.dart';

// import 'package:navegacao/informa%C3%A7oes.dart';


class Aplicativo extends StatelessWidget {
  final String nomeUsuario;

  Aplicativo({required this.nomeUsuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Olá, $nomeUsuario',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
          ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DropShadowImage(
              offset: Offset(10, 10),
              scale: 1.3,
              blurRadius: 10,
              borderRadius: 20,
              
              image: Image.asset('assets/imagens/IMG.png', width: 450,),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Ações", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Mostrar mais", style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _botaoAcao(Icons.shield, "Vacinas"),
                  _botaoAcao(Icons.document_scanner, "Exames"),
                  _botaoAcao(Icons.medical_services, "Medicamentos"),
                  _botaoAcao(Icons.contacts, "Contatos"),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Conteúdo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            _blocoConteudo("VACINAÇÃO", "Vacinas previnem doenças graves e protegem a comunidade. Mantenha seu calendário de vacinação em dia."),
            _blocoConteudo("EXAMES DE ROTINA", "Exames como hemograma ajudam a detectar problemas de saúde cedo. Consulte seu médico regularmente."),
            _blocoConteudo("CHECK-UPS ANUAIS", "Check-ups anuais avaliam o estado geral de saúde e identificam riscos."),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.blue,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CadastrarPostagem(username: nomeUsuario)),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VerPostagens()),
            );
          }
          else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VerPostagens()),
            );
          }
          else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>VerPostagens()),
            );
          }else if (index == 5) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VerPostagens()),
            );
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
          BottomNavigationBarItem(icon: Icon(Icons.add_a_photo), label: "Aplicações"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "SOS"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Conteúdo"),
        ],
      ),
    );
  }

  Widget _botaoAcao(IconData icone, String texto) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icone, size: 30, color: Colors.blue),
          SizedBox(height: 5),
          Text(texto, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _blocoConteudo(String titulo, String texto) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titulo, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(texto, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}










