import 'package:flutter/material.dart';
import 'package:fluttercreate/data/user_settings_repository.dart';
import 'package:fluttercreate/screens/router.dart';
import 'package:lottie/lottie.dart'; // ✳️ ALTERE AQUI: certifique-se de adicionar `lottie: ^2.x` no pubspec.yaml

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigate(); // inicia o fluxo de navegação após exibir o splash
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/lottie/splash.json', // ✳️ ALTERE AQUI: caminho do JSON da animação
          width: 200,                   // ✳️ ALTERE AQUI: largura da animação
          height: 200,                  // ✳️ ALTERE AQUI: altura da animação
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  final userSettingsRepository = UserSettingsRepository(); // mantém a instância do repositório

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2)); // ✳️ ALTERE AQUI: duração do splash
    final showIntro = await userSettingsRepository.getShowIntro(); // lê o flag salvo
    if (!mounted) return;
    if (showIntro) {
      Navigator.pushReplacementNamed(context, Routes.intro); // ✳️ ALTERE AQUI: rota da tela de introdução
    } else {
      Navigator.pushReplacementNamed(context, Routes.home);  // ✳️ ALTERE AQUI: rota da Home
    }
  }
}
