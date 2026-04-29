import 'package:flutter/material.dart';
import 'dart:async';

class LogoScreen extends StatefulWidget {
  const LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _startSequence();
  }

  void _startSequence() async {
    // 1 second delay before logo appears
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    
    _controller.forward();
    
    // Logo stays visible for 3-5 seconds after appearing
    await Future.delayed(const Duration(milliseconds: 2500 + 3500));
    
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/loading');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark cinematic background
      body: Stack(
        children: [
          // Subtle particle/gradient effect placeholder
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color(0xFF1A1A1A),
                    Colors.black,
                  ],
                  radius: 1.5,
                ),
              ),
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Placeholder for game logo, using stylized text for now
                        Text(
                          'EZ BATTLE ROLE',
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 8,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.amber.withOpacity(0.5),
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                              ),
                              Shadow(
                                color: Colors.redAccent.withOpacity(0.3),
                                blurRadius: 40,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'STUDIOS',
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 10,
                            color: Colors.white54,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
