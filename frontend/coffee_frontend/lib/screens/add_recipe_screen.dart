import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../widgets/coffee_dropdown.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  String? _selectedBean;
  String? _selectedMethod;
  String? _selectedGrindSize;
  final _tempController = TextEditingController();
  final _coffeeWeightController = TextEditingController();
  final _waterWeightController = TextEditingController();
  final _tdsController = TextEditingController();
  final _eyController = TextEditingController();
  bool _isProMode = false;

  final List<String> _methods = ['V60', 'Aeropress', 'French Press', 'Chemex', 'Espresso', 'Moka Pot'];
  final List<String> _grindSizes = ['Fine', 'Medium-Fine', 'Medium', 'Medium-Coarse', 'Coarse'];
  final List<String> _beans = ['Ethiopia Yirgacheffe', 'Colombia Huila', 'Brazil Mogiana', 'Guatemala Antigua'];

  Future<void> _saveRecipe() async {
    final recipeData = {
      'bean': _selectedBean,
      'method': _selectedMethod,
      'grind_size': _selectedGrindSize,
      'water_temp': double.tryParse(_tempController.text),
      'coffee_weight': double.tryParse(_coffeeWeightController.text),
      'water_weight': double.tryParse(_waterWeightController.text),
      'tds': _isProMode ? double.tryParse(_tdsController.text) : null,
      'extraction_yield': _isProMode ? double.tryParse(_eyController.text) : null,
    };

    final success = await Provider.of<RecipeProvider>(context, listen: false).createRecipe(recipeData);
    if (success) {
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Recipe')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CoffeeDropdown<String>(
              label: 'Coffee Bean',
              items: _beans,
              selectedItem: _selectedBean,
              onChanged: (val) => setState(() => _selectedBean = val),
            ),
            CoffeeDropdown<String>(
              label: 'Brew Method',
              items: _methods,
              selectedItem: _selectedMethod,
              onChanged: (val) => setState(() => _selectedMethod = val),
            ),
            CoffeeDropdown<String>(
              label: 'Grind Size',
              items: _grindSizes,
              selectedItem: _selectedGrindSize,
              onChanged: (val) => setState(() => _selectedGrindSize = val),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tempController,
                    decoration: const InputDecoration(labelText: 'Water Temp (°C)'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _coffeeWeightController,
                    decoration: const InputDecoration(labelText: 'Coffee (g)'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _waterWeightController,
              decoration: const InputDecoration(labelText: 'Total Water (g)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Pro Mode'),
              subtitle: const Text('Log TDS and Extraction Yield'),
              value: _isProMode,
              onChanged: (val) => setState(() => _isProMode = val),
              activeColor: const Color(0xFF8D6E63),
            ),
            if (_isProMode) ...[
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _tdsController,
                      decoration: const InputDecoration(labelText: 'TDS (%)'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _eyController,
                      decoration: const InputDecoration(labelText: 'Ext. Yield (%)'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 32),
            const Text('Recipe Steps', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {}, // TODO: Add step
              icon: const Icon(Icons.add),
              label: const Text('Add Step'),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: _saveRecipe,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Create Recipe'),
            ),
          ],
        ),
      ),
    );
  }
}
