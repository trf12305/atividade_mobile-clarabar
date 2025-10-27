class Propriedade {
  late String image;
  late String nome;

  Propriedade({
    required this.image,
    required this.nome,
  });

  Propriedade.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['image'] = this.image;
    data['nome'] = this.nome;
    return data;
  }
}