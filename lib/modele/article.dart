class Article {
  
  int id;
  String nom;
  int item;
  String description;
  String image;

  Article();

  void fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nom = map['nom'];
    this.item = map['item'];
    this.description = map['description'];
    this.image = map['image'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nom': this.nom,
      'item': this.item,
      'description': this.description,
      'image': this.image,
    };

    if (id != null) {
      map['id'] = this.id;
    }
    return map;

  }

}