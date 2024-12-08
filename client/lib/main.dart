import 'package:client/core/theme/theme.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zefenic',
      theme: AppTheme.darkThemeMode,
      locale:
          const Locale('en', 'US'), // Set the default locale to English (US)
      supportedLocales: const [
        Locale('en', 'US'), // English (US)
        Locale('am',
            'ET'), // Amharic (Ethiopia) - Add any other languages you support
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: const SignupPage(),
    );
  }
}
