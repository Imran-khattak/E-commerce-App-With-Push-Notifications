import 'package:flutter/material.dart';
import 'package:notifications/constants/theme.dart';
import 'package:notifications/provider/login_controller.dart';
import 'package:notifications/views/signup_screen.dart';
import 'package:notifications/widgets/popus/popups.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.maincolor,
      // backgroundColor: const Color(0xFF2C3E50), // Dark blue-gray background
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth > 600 ? 40.0 : 24.0,
                  vertical: 20.0,
                ),
                child: Column(
                  children: [
                    // Header Section
                    _buildHeader(constraints),

                    const SizedBox(height: 40),

                    // Signup Form
                    _buildSignupForm(constraints),
                    const SizedBox(height: 24),

                    // Social Signup Buttons
                    _buildSocialSignupButtons(constraints),

                    const SizedBox(height: 20), // Added consistent spacing
                    // Bottom Section
                    _buildBottomSection(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BoxConstraints constraints) {
    return Column(
      children: [
        // Profile Avatar (similar to your app's profile picture)
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF34495E),
            border: Border.all(
              color: const Color(0xFF1ABC9C), // Teal accent color
              width: 3,
            ),
          ),
          child: const Icon(
            Icons.person_add,
            color: Color(0xFF1ABC9C),
            size: 40,
          ),
        ),

        const SizedBox(height: 24),

        // Title
        Text(
          'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontSize: constraints.maxWidth > 600 ? 32 : 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        // Subtitle
        Text(
          'Join us and explore amazing products',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: constraints.maxWidth > 600 ? 18 : 16,
          ),
        ),
      ],
    );
  }

  Widget _buildSignupForm(BoxConstraints constraints) {
    return Consumer<LoginController>(
      builder: (context, controller, child) {
        return Form(
          key: controller.formKey,
          child: Column(
            children: [
              // Email Field
              _buildTextField(
                controller: controller.emailController,
                label: 'Email Address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Password Field
              _buildTextField(
                controller: controller.passwordController,
                label: 'Password',
                icon: Icons.lock_outline,
                obscureText: controller.isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: const Color(0xFF1ABC9C),
                  ),
                  onPressed: () => controller.togglePassword(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),

              // Terms and Conditions Checkbox
              Row(
                children: [
                  Checkbox(
                    side: BorderSide(
                      color: Colors.white.withValues(
                        alpha: 0.6,
                      ), // Sets the border color
                    ),
                    value: controller.isRememberme,
                    onChanged: (value) => controller.toggleAgreeTerm(),
                    activeColor: const Color(0xFF1ABC9C),
                    checkColor: Colors.white,
                  ),
                  Expanded(
                    child: Text(
                      'Remember Me',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Signup Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: controller.isRememberme
                      ? () => controller.signInWithEmailandPassword(context)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1ABC9C),
                    disabledBackgroundColor: const Color(
                      0xFF1ABC9C,
                    ).withValues(alpha: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: constraints.maxWidth > 600 ? 18 : 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Divider with OR text
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.white.withValues(alpha: 0.3),
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.white.withValues(alpha: 0.3),
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      cursorColor: Colors.white, // Set the desired cursor color
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
        prefixIcon: Icon(icon, color: const Color(0xFF1ABC9C)),
        suffixIcon: suffixIcon,
        filled: true,

        fillColor: Utils.maincolor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1ABC9C), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }

  Widget _buildSocialSignupButtons(BoxConstraints constraints) {
    return Consumer<LoginController>(
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: () => controller.googleSignIn(context),
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Utils.maincolor,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/google-icon.png', height: 30),
                SizedBox(width: 10),
                const Text(
                  'Continue with Google',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomSection() {
    return Column(
      children: [
        // Login Link
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14,
              ),
            ),
            TextButton(
              onPressed: _navigateToLogin,
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Color(0xFF1ABC9C),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _handleGoogleSignup() {
    TLoaders.errorSnackBar(
      context: context,
      title: "Oh Snap!",
      message: 'Google signup not implemented yet',
    );
  }

  void _navigateToLogin() {
    // Navigate to login screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
  }
}
