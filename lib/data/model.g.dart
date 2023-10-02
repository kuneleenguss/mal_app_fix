// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimeAdapter extends TypeAdapter<Anime> {
  @override
  final int typeId = 1;

  @override
  Anime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Anime(
      malId: fields[0] as int?,
      url: fields[1] as String?,
      smallImageUrl: fields[2] as String?,
      imageUrl: fields[3] as String?,
      title: fields[4] as String?,
      type: fields[5] as String?,
      source: fields[6] as String?,
      episodes: fields[7] as int?,
      status: fields[8] as String?,
      rating: fields[9] as String?,
      synopsis: fields[10] as String?,
      year: fields[11] as int?,
      ifYearNull: fields[12] as int?,
      genresName: (fields[13] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Anime obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.malId)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.smallImageUrl)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.source)
      ..writeByte(7)
      ..write(obj.episodes)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.rating)
      ..writeByte(10)
      ..write(obj.synopsis)
      ..writeByte(11)
      ..write(obj.year)
      ..writeByte(12)
      ..write(obj.ifYearNull)
      ..writeByte(13)
      ..write(obj.genresName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
