import 'dart:convert'; // necessário para jsonDecode
import 'package:flutter/services.dart' show rootBundle; // necessário para rootBundle
import 'package:fluttercreate/model/team.dart';

class TeamsRepository {
  final String assetPath;
  TeamsRepository({this.assetPath = 'assets/data/teams.json'}); // ✳️ ALTERE AQUI se mudar o caminho do JSON no assets

  Future<List<Team>> load() async {
    final jsonStr = await rootBundle.loadString(assetPath); // lê o arquivo do assets
    final list = jsonDecode(jsonStr) as List; // decodifica para List dinâmica
    return list
        .map((e) => Team.fromJson(Map<String, dynamic>.from(e))) // mapeia para Team
        .toList();
  }
}
