import 'dart:io';

import 'package:alex_grant_ai/screens/profile.dart';
import 'package:alex_grant_ai/screens/voice.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'mic.dart';
import 'history.dart';
import 'notification.dart'; // Import the HistoryScreen class

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  // File upload related
  File? _selectedFile;
  final ImagePicker _picker = ImagePicker();
  final List<Map<String, String>> _messages = [
    {
      'sender': 'agent',
      'text': 'What topic would you like to be generated for you today?'
    }
  ];

  // Variable to track which button is selected
  String _selectedButton = '';

  // List of action cards to be displayed initially
  final List<String> actionCards = [
    'Turn your ideas into stunning visuals!',
    'Unlock creativity with articles that inspire!',
    'Craft engaging stories tailored to captivate.',
    'Share your idea with articles designed.',
    'Transform thoughts into compelling narratives.',
    'Generate impactful content for your ideas.'
  ];

  // Boolean to track if user has entered a prompt or not
  bool _hasEnteredPrompt = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Action cards section (shown initially and hidden after user enters a prompt)
            if (!_hasEnteredPrompt)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  children: actionCards.map((cardText) {
                    return _buildActionCard(cardText);
                  }).toList(),
                ),
              ),

            // Chat messages
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUser = message['sender'] == 'user';
                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isUser
                            ? Colors.purple.shade900
                            : Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: isUser
                            ? Border.all(color: Colors.purple, width: 2)
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (!isUser)
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.grey,
                                  child: Image.asset(
                                    "images/chat_logo_robot.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              if (!isUser) const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  message['text']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              if (isUser) const SizedBox(width: 12),
                              if (isUser)
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.purple.shade400,
                                  child: Image.asset(
                                    "images/user_chat_logo.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            ],
                          ),
                          // Add Share, Copy, Reload Buttons for both User and Agent Messages
                          if (isUser)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.share,
                                      color: Colors.white54, size: 20),
                                  onPressed: showTopMessage,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.copy,
                                      color: Colors.white54, size: 20),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.refresh,
                                      color: Colors.white54, size: 20),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          if (!isUser)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.share,
                                      color: Colors.white54, size: 20),
                                  onPressed: showTopMessage,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.copy,
                                      color: Colors.white54, size: 20),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.refresh,
                                      color: Colors.white54, size: 20),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Input field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: Colors.white),
                    onPressed: _showFileUploadDialog,
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.qr_code_scanner, color: Colors.white),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter your prompt...',
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 20),
                      ),
                      onSubmitted: (value) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.mic, color: Colors.white),
                    onPressed: () {
                      // Navigate to MicScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VoiceCallScreen()),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),

            // Bottom navigation with click effect
            Container(
              color: Colors.grey.shade900,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavButton(Icons.home, "Home", 'home'),
                  _buildNavButton(Icons.history, "History", 'history'),
                  _buildNavButton(
                      Icons.notifications, "Notifications", 'notifications'),
                  _buildNavButton(Icons.person, "Profile", 'profile'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show file upload dialog
  void _showFileUploadDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.grey[900],
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[700]!,
                      width: 2,
                      // style: BorderStyle.dashed,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.picture_as_pdf,
                        size: 48,
                        color: Colors.red[400],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Drag your image here or',
                        style: TextStyle(color: Colors.white70),
                      ),
                      TextButton(
                        onPressed: _pickFile,
                        child: const Text(
                          'browse',
                          style: TextStyle(color: Colors.purple),
                        ),
                      ),
                      const Text(
                        'supports: JPG, PNG',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showTopMessage() {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0,
        left: 0,
        right: 0,
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green, // Background color
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      "Link Copied",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // Insert overlay entry
    overlay?.insert(overlayEntry);

    // Remove it after a duration
    Future.delayed(Duration(seconds: 3)).then((_) {
      overlayEntry.remove();
    });
  }

  // Pick file using image picker
  Future<void> _pickFile() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedFile = File(image.path);
        });
        // Handle the selected file (e.g., upload it or display it)
        Navigator.pop(context); // Close dialog after selection
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  // Action card widget
  Widget _buildActionCard(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.bolt, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Send message function
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({'sender': 'user', 'text': _controller.text});
        _messages.add({
          'sender': 'agent',
          'text':
              'This is a dummy response to your prompt: "${_controller.text}"',
        });
        _controller.clear();
        _hasEnteredPrompt =
            true; // Disable cards after the first prompt is entered
      });
    }
  }

  // Navigation button for bottom bar
  Widget _buildNavButton(IconData icon, String label, String value) {
    return GestureDetector(
      onTap: () {
        if (value == 'history') {
          // Navigate to HistoryScreen when the History button is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HistoryScreen()),
          );
        } else if (value == 'notifications') {
          // Navigate to HistoryScreen when the History button is tapped
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const NotificationsScreen()),
          );
        } else if (value == 'profile') {
          // Navigate to HistoryScreen when the History button is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsScreen()),
          );
        } else {
          setState(() {
            _selectedButton = value;
          });
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedButton == value ? Colors.purple : Colors.white,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: _selectedButton == value ? Colors.purple : Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
