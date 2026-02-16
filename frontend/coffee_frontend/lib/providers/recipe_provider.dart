import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/database_helper.dart';

class RecipeProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> _recipes = [];

  List<Map<String, dynamic>> get recipes => _recipes;

  Future<void> fetchRecipes() async {
    try {
      final response = await _apiService.getRecipes();
      _recipes = List<Map<String, dynamic>>.from(response.data);
      // Update local cache
      for (var recipe in _recipes) {
        await _dbHelper.insertRecipe(recipe);
      }
    } catch (e) {
      // Load from cache if offline
      _recipes = await _dbHelper.getRecipes();
    }
    notifyListeners();
  }

  Future<bool> createRecipe(Map<String, dynamic> data) async {
    try {
      await _apiService.createRecipe(data);
      await fetchRecipes();
      return true;
    } catch (e) {
      // Save locally to sync later if needed
      await _dbHelper.insertRecipe(data);
      _recipes.add(data);
      notifyListeners();
      return true; // Return true as it's saved locally
    }
  }
}
