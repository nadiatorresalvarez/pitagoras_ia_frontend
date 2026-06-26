import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'screens/auth/login_page.dart';

void main() {
  runApp(const PitagorasIA());
}

class PitagorasIA extends StatelessWidget {
  const PitagorasIA({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pitágoras IA',

      theme: AppTheme.lightTheme,

      home: const LoginPage(),
    );
  }
}