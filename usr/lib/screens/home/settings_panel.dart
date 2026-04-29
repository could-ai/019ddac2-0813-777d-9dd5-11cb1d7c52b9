import 'package:flutter/material.dart';

import 'admin_dashboard.dart';

class SettingsPanel extends StatefulWidget {
  const SettingsPanel({super.key});

  @override
  State<SettingsPanel> createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showAdminLogin() {
    String password = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          title: const Text('ADMIN ACCESS', style: TextStyle(color: Colors.redAccent)),
          content: TextField(
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Enter Admin Password',
              hintStyle: TextStyle(color: Colors.white54),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
            ),
            onChanged: (val) => password = val,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL', style: TextStyle(color: Colors.white54)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                if (password == 'ez1234') { // Dummy password
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminDashboard()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid Password')));
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text('LOGIN'),
            ),
          ],
        );
      },
    );
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
              isScrollable: true,
              indicatorColor: Colors.amber,
              labelColor: Colors.amber,
              unselectedLabelColor: Colors.white54,
              tabs: const [
                Tab(text: 'BASIC'),
                Tab(text: 'SENSITIVITY'),
                Tab(text: 'CONTROLS'),
                Tab(text: 'AUTO PICKUP'),
                Tab(text: 'DISPLAY'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildBasicTab(),
                  _buildSensitivityTab(),
                  _buildControlsTab(),
                  _buildAutoPickupTab(),
                  _buildDisplayTab(),
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
          const Text('SETTINGS', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          Row(
            children: [
              TextButton.icon(
                icon: const Icon(Icons.admin_panel_settings, color: Colors.redAccent),
                label: const Text('ADMIN', style: TextStyle(color: Colors.redAccent)),
                onPressed: _showAdminLogin,
              ),
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

  Widget _buildBasicTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text('ACCOUNT', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Link Account', style: TextStyle(color: Colors.white)),
          subtitle: const Text('Protect your game data', style: TextStyle(color: Colors.white54)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(icon: const Icon(Icons.facebook, color: Colors.blue), onPressed: () {}),
              IconButton(icon: const Icon(Icons.g_mobiledata, color: Colors.redAccent, size: 36), onPressed: () {}),
            ],
          ),
        ),
        const Divider(color: Colors.white12),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent.withOpacity(0.2), foregroundColor: Colors.redAccent),
          child: const Text('LOGOUT'),
        )
      ],
    );
  }

  Widget _buildSensitivityTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSlider('General', 85),
        _buildSlider('Red Dot', 90),
        _buildSlider('2x Scope', 75),
        _buildSlider('4x Scope', 65),
        _buildSlider('AWM Scope', 50),
        _buildSlider('Free Look', 100),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
            child: const Text('RESET'),
          ),
        )
      ],
    );
  }

  Widget _buildSlider(String label, double val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(color: Colors.white))),
          Expanded(
            child: Slider(
              value: val,
              min: 0,
              max: 100,
              activeColor: Colors.amber,
              inactiveColor: Colors.white24,
              onChanged: (v) {},
            ),
          ),
          SizedBox(width: 40, child: Text('${val.toInt()}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildControlsTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text('CUSTOM HUD', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildHudPreset('2 FINGER', true),
            _buildHudPreset('3 FINGER', false),
            _buildHudPreset('4 FINGER', false),
          ],
        ),
        const SizedBox(height: 32),
        Center(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit),
            label: const Text('CUSTOMIZE HUD'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildHudPreset(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.amber.withOpacity(0.2) : Colors.black45,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isSelected ? Colors.amber : Colors.white12),
      ),
      child: Text(label, style: TextStyle(color: isSelected ? Colors.amber : Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildAutoPickupTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSwitch('Weapons', true),
        _buildSwitch('Armor and Backpacks', true),
        _buildSwitch('Medkits', true),
        _buildSwitch('Ammo', true),
        _buildSwitch('Attachments', true),
        _buildSwitch('Grenades', false),
        _buildSwitch('Special Items', true),
        _buildSwitch('Event Items', true),
      ],
    );
  }

  Widget _buildSwitch(String label, bool val) {
    return ListTile(
      title: Text(label, style: const TextStyle(color: Colors.white)),
      trailing: Switch(
        value: val,
        onChanged: (v) {},
        activeColor: Colors.amber,
      ),
    );
  }

  Widget _buildDisplayTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text('GRAPHICS', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildOptionBtn('Smooth', false),
            const SizedBox(width: 8),
            _buildOptionBtn('Standard', false),
            const SizedBox(width: 8),
            _buildOptionBtn('Ultra', true),
            const SizedBox(width: 8),
            _buildOptionBtn('Max', false),
          ],
        ),
        const SizedBox(height: 32),
        const Text('HIGH RES', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildOptionBtn('Normal', false),
            const SizedBox(width: 8),
            _buildOptionBtn('High', true),
          ],
        ),
        const SizedBox(height: 32),
        const Text('FPS', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildOptionBtn('Normal', false),
            const SizedBox(width: 8),
            _buildOptionBtn('High', true),
            const SizedBox(width: 8),
            _buildOptionBtn('Max', false),
          ],
        ),
      ],
    );
  }

  Widget _buildOptionBtn(String label, bool isSelected) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber.withOpacity(0.2) : Colors.black45,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? Colors.amber : Colors.white12),
        ),
        child: Text(label, style: TextStyle(color: isSelected ? Colors.amber : Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
