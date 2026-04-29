import 'package:flutter/material.dart';

class ModesPanel extends StatelessWidget {
  const ModesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A).withOpacity(0.95),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Row(
                children: [
                  _buildModeList(),
                  const VerticalDivider(color: Colors.white24, width: 1),
                  _buildMapSelection(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('SELECT MODE', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildModeList() {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          _buildModeItem('BATTLE ROYALE', 'Ranked & Casual', Icons.map, Colors.amber, true),
          _buildModeItem('CLASH SQUAD', '4v4 Tactical', Icons.group, Colors.blueAccent, false),
          _buildModeItem('LOVING ISLAND', '4K 3D Social Hub', Icons.favorite, Colors.pinkAccent, false),
          _buildModeItem('CUSTOM ROOM', 'Create your rules', Icons.settings, Colors.purpleAccent, false),
          _buildModeItem('TRAINING', 'Bot Practice & All Guns', Icons.sports_score, Colors.greenAccent, false),
        ],
      ),
    );
  }

  Widget _buildModeItem(String title, String subtitle, IconData icon, Color color, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isSelected ? color.withOpacity(0.2) : Colors.black45,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isSelected ? color : Colors.white12),
      ),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 10)),
        onTap: () {},
      ),
    );
  }

  Widget _buildMapSelection(BuildContext context) {
    // Prompt mentions 8 maps
    final maps = ['Bermuda', 'Purgatory', 'Kalahari', 'Alpine', 'NeXTerra', 'Nova', 'Cyber City', 'Desert Ruins'];
    
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('SELECT MAP', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: maps.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: index == 0 ? Colors.amber : Colors.white12),
                      image: const DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1580136608260-4eb11f4b24fe?auto=format&fit=crop&q=80&w=400'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                      ),
                    ),
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(12),
                    child: Text(maps[index], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                ),
                child: const Text('CONFIRM', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
