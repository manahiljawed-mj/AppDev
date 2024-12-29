import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NotificationsAndSystemsScreen extends StatefulWidget {
  const NotificationsAndSystemsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsAndSystemsScreen> createState() => _NotificationsAndSystemsScreenState();
}

class _NotificationsAndSystemsScreenState extends State<NotificationsAndSystemsScreen> {
  // State variables for toggles
  bool pushNotifications = true;
  bool hapticsFeedback = true;
  bool faceId = true;
  bool followUpQuestions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications and Systems',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Push Notifications Toggle
            _buildToggleRow(
              'Allow Push Notifications',
              pushNotifications,
                  (value) => setState(() => pushNotifications = value),
            ),

            // Haptics Feedback Toggle
            _buildToggleRow(
              'Haptics Feedback',
              hapticsFeedback,
                  (value) => setState(() => hapticsFeedback = value),
            ),

            // Face ID Toggle
            _buildToggleRow(
              'Face ID',
              faceId,
                  (value) => setState(() => faceId = value),
            ),

            // Follow Up Questions Toggle
            _buildToggleRow(
              'Follow Up Questions',
              followUpQuestions,
                  (value) => setState(() => followUpQuestions = value),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey[900]!,
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.white,
          currentIndex: 2, // Notifications tab selected
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleRow(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}