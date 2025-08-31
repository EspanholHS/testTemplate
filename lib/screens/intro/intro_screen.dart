import 'package:flutter/material.dart';
import 'package:fluttercreate/data/user_settings_repository.dart';
import 'package:fluttercreate/screens/router.dart';
import 'package:lottie/lottie.dart'; // ✳️ ALTERE AQUI: confirme `lottie` no pubspec e o caminho do asset

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final userSettingsRepository = UserSettingsRepository(); // mantém o repo
  final PageController _pageController = PageController();  // controlador das páginas
  int _currentPage = 0;                                     // índice atual
  bool _dontShowAgain = false;                              // checkbox “não mostrar”

  // Slides da intro (título/subtítulo/arquivo lottie)
  final List<Map<String, String>> _pages = [
    {
      'title': 'Bem-vindo ao App', // ✳️ ALTERE AQUI: título do slide 1
      'subtitle':
          'Aqui você vai acompanhar tudo sobre o seu time favorito.', // ✳️ ALTERE AQUI
      'lottie': 'assets/lottie/intro1.json', // ✳️ ALTERE AQUI: caminho do lottie
    },
    {
      'title': 'Escolha seu Time', // ✳️ ALTERE AQUI
      'subtitle':
          'Selecione seu clube do coração para personalizar a experiência.', // ✳️ ALTERE AQUI
      'lottie': 'assets/lottie/intro2.json', // ✳️ ALTERE AQUI
    },
    {
      'title': 'Torcida Conectada', // ✳️ ALTERE AQUI
      'subtitle':
          'Fique por dentro das novidades e compartilhe sua paixão!', // ✳️ ALTERE AQUI
      'lottie': 'assets/lottie/intro3.json', // ✳️ ALTERE AQUI
    },
  ];

  @override
  void dispose() {
    _pageController.dispose(); // libera o controller
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _finishIntro();
    }
  }

  void _onBack() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _finishIntro() async {
    await userSettingsRepository.setShowIntro(!_dontShowAgain); // salva flag
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, Routes.home); // vai para Home
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _pages.length - 1; // última página?

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Conteúdo da intro (carrossel de páginas)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Lottie.asset(
                            page['lottie']!,         // ✳️ ALTERE AQUI: arquivo lottie do slide
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          page['title']!,            // título do slide
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          page['subtitle']!,         // subtítulo do slide
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Checkbox exibido apenas na última página
            Visibility(
              visible: isLastPage,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: _dontShowAgain,
                      onChanged: (val) {
                        setState(() => _dontShowAgain = val ?? false);
                      },
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text('Não mostrar essa introdução novamente.'), // ✳️ ALTERE AQUI
                    ),
                  ],
                ),
              ),
            ),

            // Botões de navegação (Voltar / Avançar/Concluir)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    TextButton(
                      onPressed: _onBack,
                      child: const Text('Voltar'), // ✳️ ALTERE AQUI
                    )
                  else
                    const SizedBox(width: 80), // espaço para alinhar com o botão da direita
                  TextButton(
                    onPressed: _onNext,
                    child: Text(isLastPage ? 'Concluir' : 'Avançar'), // ✳️ ALTERE AQUI
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
