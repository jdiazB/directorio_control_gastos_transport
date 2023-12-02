import 'package:hive/hive.dart';
import 'package:untitled9_control_gastos/model/modelgastotruck.dart';
import 'package:untitled9_control_gastos/model/modeltruck.dart';

class CamionAdapter extends TypeAdapter<Camion> {
  @override
  final typeId = 0;

  @override
  Camion read(BinaryReader reader) {
    return Camion(
      id: reader.readString(),
      nombre: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Camion camion) {
    writer.writeString(camion.id);
    writer.writeString(camion.nombre);
  }
}

class TrabajadorAdapter extends TypeAdapter<Trabajador> {
  @override
  final typeId = 1;

  @override
  Trabajador read(BinaryReader reader) {
    return Trabajador(
      id: reader.readString(),
      nombre: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Trabajador trabajador) {
    writer.writeString(trabajador.id);
    writer.writeString(trabajador.nombre);
  }
}

class GastoAdapter extends TypeAdapter<Gasto> {
  @override
  final typeId = 2;

  @override
  Gasto read(BinaryReader reader) {
    return Gasto(
      id: reader.readString(),
      fecha: DateTime.parse(reader.readString()),
      tipo: reader.readString(),
      monto: reader.readDouble(),
      camionId: reader.readString(),
      trabajadorId: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Gasto gasto) {
    writer.writeString(gasto.id);
    writer.writeString(gasto.fecha.toIso8601String());
    writer.writeString(gasto.tipo);
    writer.writeDouble(gasto.monto);
    writer.writeString(gasto.camionId);
    writer.writeString(gasto.trabajadorId);
  }
}

