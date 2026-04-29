import 'package:flutter/material.dart';

import 'profile_panel.dart';
import 'shop_panel.dart';
import 'modes_panel.dart';
import 'settings_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Simulating 3D character with an image for the lobby
  final String _lobbyBackground = 'https://images.unsplash.com/photo-1542751371-adc38448a05e?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80';

  void _showPanel(Widget panel) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Panel',
      barrierColor: Colors.black87,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(child: panel);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          )),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 3D Background / Character showcase
          Positioned.fill(
            child: Image.network(
              _lobbyBackground,
              fit: BoxFit.cover,
            ),
          ),
          // Character Placeholder (Center)
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 300,
              height: 500,
              // Using a placeholder icon for the 3D character
              child: Icon(Icons.person, size: 300, color: Colors.white.withOpacity(0.8)),
            ),
          ),
          
          // UI Layer
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTopBar(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLeftMenu(),
                      _buildRightMenu(),
                    ],
                  ),
                ),
                _buildBottomBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black.withOpacity(0.8), Colors.transparent],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile Mini
          GestureDetector(
            onTap: () => _showPanel(const ProfilePanel()),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('PlayerOne', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('Lv. 42', style: TextStyle(color: Colors.amber[300], fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          
          // Currencies
          Row(
            children: [
              _buildCurrencyItem(Icons.monetization_on, '25000', Colors.amber),
              const SizedBox(width: 12),
              _buildCurrencyItem(Icons.diamond, '90', Colors.lightBlueAccent),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () => _showPanel(const SettingsPanel()),
              ),
              IconButton(
                icon: const Icon(Icons.mail, color: Colors.white),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCurrencyItem(IconData icon, String amount, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(amount, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(width: 4),
          const Icon(Icons.add_box, color: Colors.white70, size: 16),
        ],
      ),
    );
  }

  Widget _buildLeftMenu() {
    return Container(
      width: 80,
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSideButton(Icons.store, 'SHOP', () => _showPanel(const ShopPanel())),
          _buildSideButton(Icons.casino, 'LUCK\nROYALE', () => _showPanel(const ShopPanel(initialTab: 1))),
          _buildSideButton(Icons.calendar_today, 'DAILY', () {}),
          _buildSideButton(Icons.newspaper, 'NEWS', () {}),
        ],
      ),
    );
  }

  Widget _buildRightMenu() {
    return Container(
      width: 150,
      padding: const EdgeInsets.only(right: 16, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildSideButton(Icons.people, 'FRIENDS', () {}),
          _buildSideButton(Icons.shield, 'GUILD', () {}),
          const SizedBox(height: 20),
          // Mode Selector
          GestureDetector(
            onTap: () => _showPanel(const ModesPanel()),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.blue[900]?.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.lightBlueAccent),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.map, color: Colors.white),
                  SizedBox(width: 8),
                  Text('BR - RANKED', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Start Button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              minimumSize: const Size(120, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('START', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          )
        ],
      ),
    );
  }

  Widget _buildSideButton(IconData icon, String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white24),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black, blurRadius: 2)],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black.withOpacity(0.8), Colors.transparent],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBottomButton(Icons.backpack, 'VAULT'),
          _buildBottomButton(Icons.hardware, 'ARMORY'),
          _buildBottomButton(Icons.person_add, 'CHARACTER'),
          _buildBottomButton(Icons.science, 'LAB'),
          _buildBottomButton(Icons.sports_esports, 'ESPORTS'),
        ],
      ),
    );
  }

  Widget _buildBottomButton(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white70, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
