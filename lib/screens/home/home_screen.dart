import 'package:flutter/material.dart';
import 'package:fluttercreate/data/user_settings_repository.dart';
import 'package:fluttercreate/model/team.dart';
import 'package:fluttercreate/screens/router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Cria a instancia do repositorio
  final userSettingsRepository = UserSettingsRepository(); // (mantém assim)

  // Cria a instancia do repositorio
  Future<Team?>? _future; // mantém o Future do favorito

  @override
  void initState() {
    super.initState();
    _reload(); // recarrega o favorito ao abrir
  }

  void _reload() {
    _future = userSettingsRepository.getTeam(); // busca o favorito salvo
  }

  Future<void> _goSelect() async {
    await Navigator.pushNamed(context, Routes.select); // ✳️ ALTERE AQUI se a rota mudar
    setState(_reload); // força rebuild para refletir a escolha
  }

  Future<void> _removeFavorite() async {
    await userSettingsRepository.clearTeam(); // remove favorito
    setState(_reload); // volta ao estado inicial
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Time Favorito'), // ✳️ ALTERE AQUI (título da AppBar)
        actions: [
          IconButton(
            tooltip: 'Trocar time', // ✳️ ALTERE AQUI (texto do tooltip)
            icon: const Icon(Icons.swap_horiz),
            onPressed: _goSelect,
          ),
        ],
      ),
      body: FutureBuilder<Team?>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final team = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Card(
                    elevation: 2,
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: _goSelect, // tocar na imagem abre a seleção
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              team == null
                                  ? 'assets/images/generico.png' // ✳️ ALTERE AQUI (placeholder)
                                  : team.logo,                    // imagem do time salvo
                              width: 160,
                              height: 160,
                              fit: BoxFit.contain,
                            ),
                          ),
                          if (team != null)
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: _removeFavorite, // apaga o favorito
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    team == null
                        ? 'Você ainda não escolheu seu time favorito.\nClique na imagem acima.' // mensagem sem favorito
                        : team.name, // nome do time salvo
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
