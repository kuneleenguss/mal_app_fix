import 'dart:core';
import 'package:hive/hive.dart';

part 'model.g.dart'; 

@HiveType(typeId: 1)
class Anime {
  @HiveField(0)
  final int? malId;
  @HiveField(1)
  final String? url;
  @HiveField(2)
  final String? smallImageUrl;
  @HiveField(3)
  final String? imageUrl;
  @HiveField(4)
  final String? title;
  @HiveField(5)
  final String? type;
  @HiveField(6)
  final String? source;
  @HiveField(7)
  final int? episodes;
  @HiveField(8)
  final String? status;
  @HiveField(9)
  final String? rating;
  @HiveField(10)
  final String? synopsis;
  @HiveField(11)
  final int? year;
  @HiveField(12)
  final int? ifYearNull;
  @HiveField(13)
  final List<String>? genresName;

  const Anime({
      required this.malId,
      required this.url,
      required this.smallImageUrl,
      required this.imageUrl,
      required this.title,
      required this.type,
      required this.source,
      required this.episodes,
      required this.status,
      required this.rating,
      required this.synopsis,
      required this.year,
      required this.ifYearNull,
      required this.genresName
      });

  
  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      malId: json["mal_id"], 
      url: json["url"], 
      smallImageUrl: json["images"]["jpg"]["small_image_url"], 
      imageUrl: json["images"]["jpg"]["image_url"], 
      title: json["title"], 
      type: json["type"], 
      source: json["source"], 
      episodes: json["episodes"], 
      status: json["status"], 
      rating: json["rating"], 
      synopsis: json["synopsis"], 
      year: json["year"], 
      ifYearNull: json["aired"]["prop"]["from"]["year"],
      genresName: List.generate(json["genres"].length, (index) => json["genres"][index]["name"])
    );
  }
}