// Modelo igual ao do PDF (id, name, logo). Troque os nomes do JSON se mudar o tema.
class Team {
  final int id; // id do item
  final String
  name; // nome do item (ex.: "Palmeiras")  // ✳️ ALTERE AQUI se mudar a chave do JSON
  final String
  logo; // caminho da imagem em assets      // ✳️ ALTERE AQUI se mudar a chave do JSON

  const Team({required this.id, required this.name, required this.logo});

  factory Team.fromJson(Map<String, dynamic> j) => Team(
    id: j['id'],
    name: j['name'],
    logo: j['logo'],
  ); // ✳️ ALTERE AQUI se seu JSON tiver outras chaves

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'logo': logo,
  }; // ✳️ ALTERE AQUI se mudar as chaves
}
