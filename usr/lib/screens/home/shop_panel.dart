import 'package:flutter/material.dart';

class ShopPanel extends StatefulWidget {
  final int initialTab;
  const ShopPanel({super.key, this.initialTab = 0});

  @override
  State<ShopPanel> createState() => _ShopPanelState();
}

class _ShopPanelState extends State<ShopPanel> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: widget.initialTab);
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
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.amber,
              labelColor: Colors.amber,
              unselectedLabelColor: Colors.white54,
              tabs: const [
                Tab(text: 'NORMAL SHOP'),
                Tab(text: 'LUCK ROYALE'),
                Tab(text: 'TOP-UP'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildNormalShop(),
                  _buildLuckRoyale(),
                  _buildTopUp(),
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
          const Text('STORE & ROYALE', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          Row(
            children: [
              _buildCurrencyBadge(Icons.monetization_on, '25000', Colors.amber),
              const SizedBox(width: 8),
              _buildCurrencyBadge(Icons.diamond, '90', Colors.lightBlueAccent),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCurrencyBadge(IconData icon, String amount, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 4),
          Text(amount, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildNormalShop() {
    final categories = ['Bundles', 'Guns', 'Emotes', 'Vehicles', 'Backpacks', 'Loot Boxes', 'Skateboards', 'Parachutes', 'Skywings'];
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categories[index], style: const TextStyle(color: Colors.white70, fontSize: 12)),
                onTap: () {},
              );
            },
          ),
        ),
        const VerticalDivider(color: Colors.white24, width: 1),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              return _buildShopItem('Item ${index + 1}', '500');
            },
          ),
        )
      ],
    );
  }

  Widget _buildLuckRoyale() {
    return Row(
      children: [
         SizedBox(
          width: 120,
          child: ListView(
            children: [
              ListTile(title: const Text('Diamond Royale', style: TextStyle(color: Colors.lightBlueAccent, fontSize: 12)), onTap: (){}),
              ListTile(title: const Text('Weapon Royale', style: TextStyle(color: Colors.purpleAccent, fontSize: 12)), onTap: (){}),
              ListTile(title: const Text('Gold Royale', style: TextStyle(color: Colors.amber, fontSize: 12)), onTap: (){}),
              ListTile(title: const Text('Incubator', style: TextStyle(color: Colors.redAccent, fontSize: 12)), onTap: (){}),
            ],
          ),
        ),
        const VerticalDivider(color: Colors.white24, width: 1),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.casino, size: 100, color: Colors.amber),
                const SizedBox(height: 16),
                const Text('GRAND PRIZE: MYTHIC BUNDLE', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                      child: const Text('SPIN 1x (60)'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                      child: const Text('SPIN 10+1 (600)'),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTopUp() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('TOP-UP CRYSTALS', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildTopUpItem('15 Crystals', 'Rs 20'),
            _buildTopUpItem('25 Crystals', 'Rs 50'),
            _buildTopUpItem('90 Crystals', 'Rs 100'),
            _buildTopUpItem('390 Crystals', 'Rs 500'),
            _buildTopUpItem('890 Crystals', 'Rs 1000'),
          ],
        ),
        const SizedBox(height: 32),
        const Text('MEMBERSHIPS', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildMembershipCard('WEEKLY', '600 Crystals', 'Rs 300', Colors.blue)),
            const SizedBox(width: 16),
            Expanded(child: _buildMembershipCard('MONTHLY', '2500 Crystals', 'Rs 750', Colors.purple)),
          ],
        )
      ],
    );
  }

  Widget _buildShopItem(String name, String price) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(Icons.image, size: 64, color: Colors.white24),
          const Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            color: Colors.black87,
            child: Column(
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontSize: 12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.diamond, color: Colors.lightBlueAccent, size: 12),
                    const SizedBox(width: 4),
                    Text(price, style: const TextStyle(color: Colors.lightBlueAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTopUpItem(String crystals, String price) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.lightBlueAccent.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          const Icon(Icons.diamond, color: Colors.lightBlueAccent, size: 32),
          const SizedBox(height: 8),
          Text(crystals, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
            child: Text(price),
          )
        ],
      ),
    );
  }

  Widget _buildMembershipCard(String title, String crystals, String price, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color.withOpacity(0.2), Colors.black45]),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(crystals, style: const TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white),
            child: Text(price),
          )
        ],
      ),
    );
  }
}
