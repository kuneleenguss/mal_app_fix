import 'dart:io';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OpenMalApi {
//int mal_id, url, image_url, title, type, source, int episodes, status, rating, synopsis, int year, genres name
  final _url = "api.jikan.moe";
  
    Uri getUri (String queue) {
    //doesn't work on phone
    // final request = Uri.https(
    //   _url, 
    //   "/v4/anime", 
    //   {"q": queue}
    //   );
    final request = Uri.parse("https://$_url/v4/anime?q=$queue");
    return request;
  }
 }