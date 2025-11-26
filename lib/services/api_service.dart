import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../models/category.dart';
import '../models/meal.dart';
import '../models/meal_detail.dart';

class ApiService {
  static const String baseUrl = "https://www.themealdb.com/api/json/v1/1";
  
  Future<List<Category>> loadCategories() async{
    final response = await http.get(Uri.parse("$baseUrl/categories.php"));
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      return (data['categories'] as List).map((e) => Category.fromJson(e)).toList();
    }
    else{
      throw Exception("Failed loading categories");
    }
  }

  Future<List<Meal>> loadMealByCategory (String category) async{
    final response = await http.get(Uri.parse("$baseUrl/filter.php?c=$category"));
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      return (data['meals'] as List).map((e) => Meal.fromJson(e)).toList();
    }
    else{
      throw Exception("Failed loading meals");
    }
  }

  Future<MealDetail> fetchMealDetail (String id) async{
    final response = await http.get(Uri.parse("$baseUrl/lookup.php?i=$id"));
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      return MealDetail.fromJson(data['meals'][0]);
    }
    else{
      throw Exception("Failed loading details");
    }
  }
  Future<void> openYoutube(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch $url");
    }
  }

  Future<MealDetail> loadRandomMeal() async {
    final response = await http.get(Uri.parse("$baseUrl/random.php"));
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      return MealDetail.fromJson(data['meals'][0]);
    }
    else{
      throw Exception("Failed loading details");
    }
  }
}

