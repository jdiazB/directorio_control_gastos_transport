class Gasto {
  String id;
  DateTime fecha;
  String tipo; // Ejemplo: 'Materia Prima', 'Petroleo', 'Peaje', 'Salario', 'Otros'
  double monto;
  String camionId;
  String trabajadorId;

  Gasto({required this.id, required this.fecha, required this.tipo, required this.monto, required this.camionId, required this.trabajadorId});
}