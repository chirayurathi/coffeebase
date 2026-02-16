import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'COFFEE',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
                letterSpacing: 4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('Login', style: TextStyle(fontSize: 18)),
                  ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {}, // TODO: Sign Up
              child: const Text('Don\'t have an account? Sign Up', style: TextStyle(color: AppTheme.accentColor)),
            ),
            const SizedBox(height: 32),
            OutlinedButton.icon(
              onPressed: _isLoading ? null : _loginWithGoogle,
              icon: const Icon(Icons.login),
              label: const Text('Continue with Google'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);
    final success = await Provider.of<AuthProvider>(context, listen: false)
        .login(_emailController.text, _passwordController.text);
    setState(() => _isLoading = false);
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Failed')),
      );
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() => _isLoading = true);
    final success = await Provider.of<AuthProvider>(context, listen: false).signInWithGoogle();
    setState(() => _isLoading = false);
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google Login Failed')),
      );
    }
  }
}
