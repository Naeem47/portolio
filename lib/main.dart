import 'package:flutter/material.dart';
import 'theme.dart';
import 'portfolio_page.dart';

void main(){
WidgetsFlutterBinding.ensureInitialized();
 runApp(const PortfolioApp());
} 
// =>

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naeem Iqbal — Flutter Engineer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accent,
          surface: AppColors.surface,
        ),
        splashColor: AppColors.accent.withOpacity(0.08),
        highlightColor: Colors.transparent,
      ),
      home: const PortfolioPage(),
    );
  }
}