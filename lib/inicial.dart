import 'package:flutter/material.dart';

class Aplicativo extends StatelessWidget {
  final String nomeUsuario;

  Aplicativo({required this.nomeUsuario});

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, $nomeUsuario'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/imagens/IMG.png",
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Center(child: Text("Erro ao carregar imagem")),
                );
              },
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int count = (larguraTela ~/ 100).clamp(2, 4);
                  return GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: count,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      _botaoAcao(Icons.shield, "Vacinas"),
                      _botaoAcao(Icons.document_scanner, "Exames"),
                      _botaoAcao(Icons.medical_services, "Medicamentos"),
                      _botaoAcao(Icons.contacts, "Contatos"),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 30),
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
          BottomNavigationBarItem(icon: Icon(Icons.vaccines), label: "Aplicações"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "SOS"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Conteúdo"),
        ],
      ),
    );
  }

  Widget _botaoAcao(IconData icone, String texto) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, size: 36, color: Colors.blue),
            SizedBox(height: 8),
            Text(
              texto,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
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

