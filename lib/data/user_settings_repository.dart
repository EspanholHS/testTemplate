import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/team.dart';

class UserSettingsRepository {
  static const _key =
      'favorite_team'; // chave única no SharedPreferences  // ✳️ ALTERE AQUI se quiser outra chave

  Future<Team?> getTeam() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_key); // busca o JSON salvo
    if (jsonStr == null) return null; // sem favorito salvo
    try {
      final map = jsonDecode(jsonStr) as Map<String, dynamic>;
      return Team.fromJson(map); // reconstrói o Team
    } catch (_) {
      return null; // se quebrar o parse, retorna null (estado inicial)
    }
  }

  Future<void> setTeam(Team team) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      jsonEncode(team.toJson()),
    ); // salva o objeto como JSON
  }

  Future<void> clearTeam() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key); // apaga o favorito
  }

  static const _keyShowIntro = 'show_intro';
 Future<bool> getShowIntro() async {
   final prefs = await 
SharedPreferences.getInstance();
   return prefs.getBool(_keyShowIntro) ?? true;
 }
 Future<void> setShowIntro(bool value) async {
   final prefs = await 
SharedPreferences.getInstance();
   await prefs.setBool(_key, value);
 
  }

}
