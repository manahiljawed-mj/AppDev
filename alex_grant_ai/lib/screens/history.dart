import 'package:flutter/material.dart';

import 'notification.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.help_outline, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),

              // Profile Section
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    child: Image.asset(
                      "images/user_chat_logo.png", // Use your custom image here
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Adelia Larsson',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'adelia.larsson@mail.com',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),

              // History Sections
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    _buildHistorySection(
                      'Today',
                      [
                        'Group Collaboration Insights',
                        'Cloud Monitoring Summary',
                        'Single-Tenant Control Plane...',
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildHistorySection(
                      'Yesterday',
                      [
                        'Shopping List Update',
                        'Alex Grant Brand Guidelines',
                        'AI for Study Research',
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildHistorySection(
                      'Last Week',
                      [
                        'Group Collaboration Insights',
                        'Cloud Monitoring Summary',
                        'Single-Tenant Control Plane...',
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade900,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavButton(Icons.home, "Home", 'home', context),
            _buildNavButton(Icons.history, "History", 'history', context),
            _buildNavButton(Icons.notifications, "Notifications", 'notifications', context),
            _buildNavButton(Icons.person, "Profile", 'profile', context),
          ],
        ),
      ),
    );
  }

  // Navigation button for bottom bar
  Widget _buildNavButton(IconData icon, String label, String value, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (value == 'history') {
          // Navigate to HistoryScreen when the History button is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HistoryScreen()),
          );
        }

        else if (value == 'notifications') {
          // Navigate to HistoryScreen when the History button is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationsScreen()),
          );
        }

      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // History section widget
  Widget _buildHistorySection(String title, List<String> items) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  item,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )).toList(),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: const Text(
              'See More',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
