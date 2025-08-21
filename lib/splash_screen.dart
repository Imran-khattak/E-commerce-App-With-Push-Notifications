import 'package:flutter/material.dart';
import 'package:notifications/constants/theme.dart';
import 'package:notifications/datass/repo/auth_repositories.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize authentication provider after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthenticationProvider>(context, listen: false).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.maincolor,
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.white.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}
