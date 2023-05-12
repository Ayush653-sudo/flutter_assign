import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

// Define a class to represent the trek data
class TrekData {
  final String bannerTitle;
  final List<String> bannerImages;
  final double rating;
  final String description;
  final List<String> details;
  final List<Map<String, dynamic>> popularTreks;

  TrekData({
    required this.bannerTitle,
    required this.bannerImages,
    required this.rating,
    required this.description,
    required this.details,
    required this.popularTreks,
  });

  factory TrekData.fromJson(Map<String, dynamic> json) {
    return TrekData(
      bannerTitle: json['bannerTitle'],
      bannerImages: List<String>.from(json['bannerImages']),
      rating: json['rating'].toDouble(),
      description: json['description'],
      details: List<String>.from(json['details']),
      popularTreks: List<Map<String, dynamic>>.from(json['popularTreks']),
    );
  }
}

// Define a function to load the JSON file
Future<String> _loadTrekDataAsset() async {
  String jsonString = await rootBundle.loadString('assets/data.json');
  // print(jsonString);
  return jsonString;
} //11647535

Future<TrekData> loadTrekData() async {
  String jsonString = await _loadTrekDataAsset();
  final jsonResponse = json.decode(jsonString);
  return TrekData.fromJson(jsonResponse);
}

// Future<String> _loadTrekDataAsset() async {
//   return await rootBundle.loadString('assets/data.json');
// }

// // Define a function to parse the JSON file and return the trek data
// Future<TrekData> loadTrekData() async {
//   String jsonString = await _loadTrekDataAsset();
//   final jsonResponse = json.decode(jsonString);
//   return TrekData.fromJson(jsonResponse);
// }
