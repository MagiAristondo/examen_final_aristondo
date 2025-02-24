import 'dart:convert';

class Persona {
    String id;
    String nom;
    String descripcio;
    String foto;
    String edat;
    String hobby;

    Persona({
        required this.id,
        required this.nom,
        required this.descripcio,
        required this.foto,
        required this.edat,
        required this.hobby,
    });

    factory Persona.fromJson(String str) => Persona.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Persona.fromMap(Map<String, dynamic> json) => Persona(
        id: json["id"],
        nom: json["nom"],
        descripcio: json["descripcio"],
        foto: json["foto"],
        edat: json["edat"],
        hobby: json["hobby"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nom": nom,
        "descripcio": descripcio,
        "foto": foto,
        "edat": edat,
        "hobby": hobby,
    };
}
