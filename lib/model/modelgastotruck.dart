class OilExpensive {
  int? id;
  String fecha;
  String tipo; // Ejemplo: 'Materia Prima', 'Petroleo', 'Peaje', 'Salario', 'Otros'
  double monto;
  String camionId;
  String trabajadorId;

  OilExpensive({this.id, required this.fecha, required this.tipo, required this.monto, required this.camionId, required this.trabajadorId});

  factory OilExpensive.deMapAModel(Map<String, dynamic> mapa) => OilExpensive(
    id: mapa["id"],
    fecha: mapa["fecha"],
    tipo: mapa["tipo"],
    monto: mapa["monto"],
    camionId: mapa["camionId"],
    trabajadorId: mapa["trabajadorId"]
  );
}