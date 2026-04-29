import 'package:flutter/material.dart';
import 'dart:ui';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onLoginPressed(String method) {
    // Navigate to home after selection
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background - Premium AAA game look, soft lighting, depth, motion blur
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1542751371-adc38448a05e?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80',
              fit: BoxFit.cover,
            ),
          ),
          // Blur effect and vignette
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                    radius: 1.2,
                  ),
                ),
              ),
            ),
          ),
          
          // UI Content
          SafeArea(
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Title or Logo could go here
                      const Text(
                        'EZ BATTLE ROLE',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 4,
                          shadows: [
                            Shadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, 4)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 60),
                      
                      const Text(
                        'CREATE YOUR ACCOUNT TO CONTINUE',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Login Buttons Area
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLoginButton(
                            title: 'GUEST',
                            subtitle: 'Quick Access',
                            icon: Icons.person_outline,
                            color: Colors.white24,
                            onTap: () => _onLoginPressed('guest'),
                          ),
                          const SizedBox(width: 20),
                          _buildLoginButton(
                            title: 'FACEBOOK',
                            subtitle: 'Social Login',
                            icon: Icons.facebook,
                            color: const Color(0xFF1877F2).withOpacity(0.8),
                            onTap: () => _onLoginPressed('facebook'),
                          ),
                          const SizedBox(width: 20),
                          _buildLoginButton(
                            title: 'GOOGLE',
                            subtitle: 'Clean & Minimal',
                            icon: Icons.g_mobiledata_rounded,
                            color: Colors.redAccent.withOpacity(0.8),
                            onTap: () => _onLoginPressed('google'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        hoverColor: Colors.white10,
        splashColor: Colors.white24,
        child: Container(
          width: 180,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white24, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 32),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
