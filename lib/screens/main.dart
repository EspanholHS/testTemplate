import 'package:flutter/material.dart';

// Se o arquivo do router estiver em lib/router.dart, use esta linha ↓ (troque o caminho do pacote):
// import 'package:fluttercreate/router.dart'; // ✳️ ALTERE AQUI se mover o router para lib/router.dart

// Se o router estiver dentro de lib/screens/router.dart (como no seu projeto atual), mantenha esta:
import 'package:fluttercreate/screens/router.dart'; // ✳️ ALTERE AQUI se mudar a pasta/nome do router

void main() {
  runApp(const MyApp()); // (geralmente não precisa mudar)
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'favorite_team_app', // ✳️ ALTERE AQUI: nome do app (o PDF usa esse título)
      // Dica: se quiser Material 3 e uma cor base, pode usar:
      // theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo), // ✳️ ALTERE AQUI (cor/tema)
      theme: ThemeData(primarySwatch: Colors.blue), // ✳️ ALTERE AQUI: cor do tema (se preferir manter Material 2)

      initialRoute: Routes.home, // ✳️ ALTERE AQUI caso sua rota inicial não seja '/', ex.: Routes.home == '/home'
      onGenerateRoute: Routes.generateRoute, // (mantenha) usa o interpretador central de rotas

      debugShowCheckedModeBanner: false, // ✳️ ALTERE AQUI se o professor quiser o banner de debug visível (true)
    );
  }
}
