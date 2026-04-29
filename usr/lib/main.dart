import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/splash/logo_screen.dart';
import 'screens/splash/loading_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/admin/admin_home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Force landscape mode for game
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  // Hide status bar for immersive mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  
  runApp(const EZBattleRoleApp());
}

class EZBattleRoleApp extends StatelessWidget {
  const EZBattleRoleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EZ Battle Role',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        fontFamily: 'Roboto', // Using standard font, can be replaced with custom gaming font
        colorScheme: const ColorScheme.dark(
          primary: Colors.amber,
          secondary: Colors.redAccent,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LogoScreen(),
        '/loading': (context) => const LoadingScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/admin': (context) => const AdminHomeScreen(),
      },
    );
  }
}
