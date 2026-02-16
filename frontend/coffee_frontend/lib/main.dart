import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/recipe_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

// import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // OneSignal.shared.setAppId("YOUR_ONESIGNAL_APP_ID");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
      ],
      child: const CoffeeApp(),
    ),
  );
}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee App',
      theme: AppTheme.darkTheme,
      home: Consumer<AuthProvider>(
        builder: (ctx, auth, _) {
          return auth.isAuthenticated ? const HomeScreen() : const LoginScreen();
        },
      ),
    );
  }
}
