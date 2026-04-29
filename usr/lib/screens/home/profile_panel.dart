import 'package:flutter/material.dart';

class ProfilePanel extends StatefulWidget {
  const ProfilePanel({super.key});

  @override
  State<ProfilePanel> createState() => _ProfilePanelState();
}

class _ProfilePanelState extends State<ProfilePanel> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          children: [
            _buildHeader(context),
            _buildPlayerInfo(),
            TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.amber,
              labelColor: Colors.amber,
              unselectedLabelColor: Colors.white54,
              tabs: const [
                Tab(text: 'GALLERY'),
                Tab(text: 'HISTORY'),
                Tab(text: 'WEAPON'),
                Tab(text: 'ALBUM'),
                Tab(text: 'REPLAY'),
                Tab(text: 'VIDEOS & PHOTOS'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildGalleryTab(),
                  const Center(child: Text('Match History')),
                  const Center(child: Text('Weapon Stats')),
                  const Center(child: Text('Player Album')),
                  const Center(child: Text('Match Replays')),
                  const Center(child: Text('My Videos & Photos')),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('PLAYER PROFILE', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('PlayerOne', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(4)),
                      child: const Text('Lv. 42', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text('UID: 1234567890', style: TextStyle(color: Colors.white54)),
                const SizedBox(height: 8),
                // EXP Bar
                Row(
                  children: [
                    const Text('EXP ', style: TextStyle(color: Colors.white54, fontSize: 12)),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.7,
                        backgroundColor: Colors.white12,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                      ),
                    ),
                    const Text(' 7000/10000', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Rank Display
          Column(
            children: [
              Image.network('https://cdn-icons-png.flaticon.com/512/5610/5610944.png', width: 40, height: 40, color: Colors.purpleAccent),
              const Text('Neonfall 2', style: TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(width: 16),
          // Like Button
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.thumb_up, color: Colors.white),
                onPressed: () {},
              ),
              const Text('1,245', style: TextStyle(color: Colors.white54)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildGalleryTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildStatCard('SOLO', '98', '450', '2.5', '45%'),
        const SizedBox(height: 16),
        _buildStatCard('DUO', '156', '890', '3.1', '50%'),
        const SizedBox(height: 16),
        _buildStatCard('SQUAD', '342', '1500', '4.2', '60%'),
      ],
    );
  }

  Widget _buildStatCard(String mode, String wins, String elims, String kd, String headshot) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$mode STATS', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16)),
          const Divider(color: Colors.white12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _statItem('WINS', wins),
              _statItem('ELIMINATIONS', elims),
              _statItem('K/D RATIO', kd),
              _statItem('HEADSHOT %', headshot),
            ],
          )
        ],
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 10)),
      ],
    );
  }
}
