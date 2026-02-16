import 'package:flutter/material.dart';
import 'add_recipe_screen.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOption(
              context,
              icon: Icons.coffee,
              title: 'New Recipe',
              subtitle: 'Log your brewing details',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddRecipeScreen())),
            ),
            const SizedBox(height: 24),
            _buildOption(
              context,
              icon: Icons.camera_alt,
              title: 'New Post',
              subtitle: 'Share a photo or reel',
              onTap: () => _showAddPostDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddPostDialog(BuildContext context) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 16, right: 16, top: 16),
        decoration: const BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('New Post', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Write a caption...'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              child: const Text('Post'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, {required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          children: [
            Icon(icon, size: 48, color: const Color(0xFF8D6E63)),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(subtitle, style: const TextStyle(color: Colors.white54)),
          ],
        ),
      ),
    );
  }
}
