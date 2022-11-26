import 'dart:convert';


import 'package:http/http.dart' as http;

import '../model/food_model.dart';

abstract class FoodRepository {
  Future<List<Recipe>> getFoods();
}

class FoodRepositoryImpl extends FoodRepository {
  @override
  Future<List<Recipe>> getFoods() async {
    final response = await http
        .get(Uri.parse('https://forkify-api.herokuapp.com/api/search?q=pizza#'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("viveks${response.body}");
      List<Recipe> recipes = Food.fromJson(data).recipes;
      return recipes;
    } else {

      throw Exception('Failed to load');
    }
  }
}