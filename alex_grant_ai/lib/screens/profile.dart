import 'dart:convert';
import 'package:alex_grant_ai/screens/login.dart';
import 'package:alex_grant_ai/screens/subscriptionMenu.dart';
import 'package:alex_grant_ai/screens/termsOfService.dart';
import 'package:alex_grant_ai/screens/viewSubscription.dart';
import 'package:http/http.dart' as http;
import 'package:alex_grant_ai/screens/env.dart';
import 'package:flutter/material.dart';
import 'currentChangePinScreen.dart';
import 'editprofile.dart';
import 'language.dart';
import 'notification_setting.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Alex Grant Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        children: [
          // Profile Card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Stack(
                  children: [

                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                      child: Image.asset(
                        "images/user_chat_logo.png", // Use your custom image here
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B5CF6),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(
                        userName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        userEmail,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      color: Color(0xFF8B5CF6),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Settings Items
          _buildSettingItem(
            icon: Icons.language,
            title: 'Language Preference',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LanguagePreferenceScreen()),
              );
            },
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.notifications_none,
            title: 'Notifications and Systems',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsAndSystemsScreen()),
              );
            },
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.shield_outlined,
            title: 'Security',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CurrentChangePinScreen()),
              );
            },
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.credit_card,
            title: 'Subscription',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageSubscriptionScreen()),
              );
            },
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TermsOfServiceScreen()),
              );
            },
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.delete_outline,
            title: 'Delete Account',
            onTap: () async {
              showDeleteAccountPopup(
                context
              );

            },

          ),
          _buildDivider(),

          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.logout,
                    color: Color(0xFF8B5CF6),
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: Color(0xFF8B5CF6),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFF222222),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF8B5CF6),
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          currentIndex: 3,
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


  void showDeleteAccountPopup(BuildContext context) {
    Future<bool> deleteApi() async {
      const String apiUrl = "http://localhost:5000/user/delete-user";

      try {
        final response = await http.get(
          Uri.parse(apiUrl),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $userToken", // Pass the token here
          },
        );

        // Handle response
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          print(responseData["message"]); // Log success message
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text(responseData["message"])),
          // );
          resetVar();//for reset all
          return true; // Indicate success
        } else {
          final errorData = jsonDecode(response.body);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text(errorData["message"])),
          // );
          return false; // Indicate failure
        }
      } catch (e) {
        print('Error during user deletion: $e');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text("An error occurred while deleting the user")),
        // );
        return false; // Indicate failure
      }
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          backgroundColor: Colors.black,
          title: const Text(
            'Delete Your Account',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Deleting your Alex account will permanently remove all your data, including chats, documents, and preferences.\n\nThis action cannot be undone.',
                style: TextStyle(color: Colors.white70, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () async {
                  // Close the popup before calling the API
                  Navigator.of(context).pop();

                  // Call the delete API and handle the result
                  bool isDeleted = await deleteApi();
                  if (isDeleted) {
                    // Show a success message or navigate the user
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Account deleted successfully")),
                    );

                    Navigator.pop(context); // Go back to the previous screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  } else {
                    // Show an error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to delete account")),
                    );
                  }
                },
                child: const Text(
                  'Delete Account',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Color(0xFF222222),
      height: 1,
      thickness: 1,
    );
  }



}