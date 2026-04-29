import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.redAccent.withOpacity(0.2),
        title: const Text('ADMIN DASHBOARD', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, letterSpacing: 2)),
        iconTheme: const IconThemeData(color: Colors.redAccent),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => Navigator.pop(context),
            tooltip: 'Exit Admin',
          )
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: Colors.black45,
            child: ListView(
              children: [
                _buildDrawerItem(Icons.block, 'Ban Management'),
                _buildDrawerItem(Icons.restore, 'Unban Account'),
                _buildDrawerItem(Icons.delete_forever, 'Delete Account'),
                _buildDrawerItem(Icons.mail, 'Send Mail / Gift'),
                _buildDrawerItem(Icons.verified, 'V Badge Management'),
                _buildDrawerItem(Icons.confirmation_num, 'Send Room Tickets'),
                _buildDrawerItem(Icons.emoji_events, 'Tournament Setup'),
                _buildDrawerItem(Icons.update, 'Player Stats Update'),
                _buildDrawerItem(Icons.warning, 'Server Notices'),
              ],
            ),
          ),
          const VerticalDivider(color: Colors.white12, width: 1),
          // Main Content Area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('QUICK ACTIONS', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    
                    // Search & Ban / Unban / Delete
                    _buildAdminSection(
                      'ACCOUNT MANAGEMENT',
                      Column(
                        children: [
                          _buildSearchField('Enter Player UID'),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _buildActionBtn('BAN ACCOUNT', Colors.red, Icons.block),
                              const SizedBox(width: 16),
                              _buildActionBtn('UNBAN ACCOUNT', Colors.green, Icons.check_circle),
                              const SizedBox(width: 16),
                              _buildActionBtn('DELETE ACCOUNT', Colors.deepOrange, Icons.delete),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Mail, Gifts, V Badge
                    _buildAdminSection(
                      'PLAYER REWARDS & STATUS',
                      Column(
                        children: [
                          _buildSearchField('Enter Player UID (Optional: Global if empty)'),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _buildActionBtn('SEND MAIL/GIFT', Colors.blue, Icons.card_giftcard),
                              const SizedBox(width: 16),
                              _buildActionBtn('GRANT V BADGE', Colors.amber, Icons.verified),
                              const SizedBox(width: 16),
                              _buildActionBtn('SEND CUSTOM TICKET', Colors.purple, Icons.confirmation_num),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Server & System
                    _buildAdminSection(
                      'SYSTEM OPERATIONS',
                      Column(
                        children: [
                          TextField(
                            style: const TextStyle(color: Colors.white),
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Enter Server Maintenance Notice / Broadcast Message...',
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.black26,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _buildActionBtn('BROADCAST NOTICE', Colors.lightBlue, Icons.campaign),
                              const SizedBox(width: 16),
                              _buildActionBtn('TRIGGER SERVER DOWN', Colors.redAccent, Icons.power_settings_new),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white70)),
      hoverColor: Colors.redAccent.withOpacity(0.1),
      onTap: () {},
    );
  }

  Widget _buildAdminSection(String title, Widget content) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const Divider(color: Colors.white12, height: 32),
          content,
        ],
      ),
    );
  }

  Widget _buildSearchField(String hint) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: const Icon(Icons.search, color: Colors.white54),
        filled: true,
        fillColor: Colors.black26,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildActionBtn(String label, Color color, IconData icon) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
