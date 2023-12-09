class Camion {
  int? id;
  String camion;

  Camion({ this.id, required this.camion});

  factory Camion.deMapAModel(Map<String, dynamic> mapa) => Camion(
      camion: mapa["camion"],
    id: mapa["id"]

  );
}

class Trabajador {
  int?  id;
  String trabajador;

  Trabajador({ this.id, required this.trabajador});
  factory Trabajador.deMapAModel(Map<String, dynamic> mapa) => Trabajador(
      id: mapa["id"],
    trabajador: mapa["trabajador"]

  );
}