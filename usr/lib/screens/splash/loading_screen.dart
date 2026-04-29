import 'package:flutter/material.dart';
import 'dart:async';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _fadeController;
  int _loadingPhase = 1;
  String _loadingText = "Loading";
  late Timer _dotTimer;
  int _dotCount = 0;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // Animated dots for "Loading..."
    _dotTimer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      if (!mounted) return;
      setState(() {
        _dotCount = (_dotCount + 1) % 4;
        _loadingText = "Loading${'.' * _dotCount}";
      });
    });

    _startLoadingSequence();
  }

  void _startLoadingSequence() async {
    // Fade in screen
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    // Phase 1 loading
    _progressController.forward();
    await Future.delayed(const Duration(milliseconds: 2600));

    if (!mounted) return;

    // Pause slightly between phases
    setState(() {
      _loadingPhase = 2;
    });
    
    // Slight pause
    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;

    // Reset progress and restart for Phase 2
    _progressController.reset();
    _progressController.duration = const Duration(milliseconds: 3000);
    _progressController.forward();
    
    await Future.delayed(const Duration(milliseconds: 3200));

    if (!mounted) return;

    // Transition to Login
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    _progressController.dispose();
    _fadeController.dispose();
    _dotTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FadeTransition(
        opacity: _fadeController,
        child: Stack(
          children: [
            // Dark cinematic background
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF0F0F0F),
                      Color(0xFF000000),
                    ],
                  ),
                ),
              ),
            ),
            // Particles or subtle background effect could be added here
            
            // Loading UI in center
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated spinner or icon
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _loadingPhase == 1 ? Colors.amber : Colors.redAccent,
                      ),
                      strokeWidth: 3,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Loading text
                  SizedBox(
                    width: 120, // fixed width so text doesn't jump
                    child: Text(
                      _loadingText,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Progress bar
                  SizedBox(
                    width: 300,
                    height: 4,
                    child: AnimatedBuilder(
                      animation: _progressController,
                      builder: (context, child) {
                        return LinearProgressIndicator(
                          value: _progressController.value,
                          backgroundColor: Colors.white12,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _loadingPhase == 1 ? Colors.amber : Colors.redAccent,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
