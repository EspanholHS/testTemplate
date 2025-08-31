import 'package:flutter/material.dart'; 
import 'package:fluttercreate/data/team_repository.dart';
import 'package:fluttercreate/data/user_settings_repository.dart';
import 'package:fluttercreate/model/team.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  // Cria a instancia do repositorio
  final userSettingsRepository = UserSettingsRepository(); // (PDF)
  // Cria a instancia do repositorio
  final teamsRepository = TeamsRepository(); // (PDF)

  // ▼▼▼ Itens do slide "mova para fora do build" ▼▼▼
  late Future<List<Team>> _teamsFuture;        // armazena a chamada do repositório (PDF)
  List<Team> _allTeams = [];                   // todos os times carregados do JSON (PDF)
  List<Team> _filteredTeams = [];              // times filtrados para exibir (PDF)
  // ▲▲▲

  @override
  void initState() {
    super.initState();
    _teamsFuture = teamsRepository.load();     // (PDF) carrega o future uma vez
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escolha seu time')), // ✳️ ALTERE AQUI: título da tela de seleção
      body: FutureBuilder<List<Team>>(
        future: _teamsFuture, // (PDF) usa a variável _teamsFuture aqui
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar times: ${snapshot.error}'), // ✳️ ALTERE AQUI: mensagem de erro
            );
          }
          final teams = snapshot.data ?? [];
          if (teams.isEmpty) {
            return const Center(child: Text('Nenhum time encontrado.')); // ✳️ ALTERE AQUI: mensagem quando a lista está vazia
          }

          // ▼▼▼ Itens do slide "inicializa listas se ainda não preenchidas" ▼▼▼
          if (_allTeams.isEmpty) {             // só copia uma vez após o carregamento
            _allTeams = teams;                 // recebe a lista completa
            _filteredTeams = teams;            // começa exibindo tudo
          }
          // ▲▲▲

          // ▼▼▼ Slides: Wrap with widget (Expanded) → Wrap with Column + campo de busca ▼▼▼
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Buscar time',                 // ✳️ ALTERE AQUI: texto do label da busca
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _filteredTeams = _allTeams
                          .where((team) =>
                              team.name.toLowerCase().contains(value.toLowerCase())) // filtro por nome
                          .toList();
                    });
                  },
                ),
              ),
              Expanded( // precisa do Expanded para a ListView ocupar o resto da tela
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: _filteredTeams.length, // (PDF) usa a lista filtrada
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final t = _filteredTeams[index]; // (PDF) item filtrado
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () async {
                          await userSettingsRepository.setTeam(t); // salva o favorito
                          if (context.mounted) Navigator.pop(context); // volta para a Home
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Image.asset(
                                t.logo,               // ✳️ ALTERE AQUI se o JSON usar outra chave/caminho para imagem
                                width: 56,
                                height: 56,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  t.name,             // ✳️ ALTERE AQUI se o JSON usar outro campo para o nome
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Icon(Icons.chevron_right),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
          // ▲▲▲
        },
      ),
    );
  }
}
