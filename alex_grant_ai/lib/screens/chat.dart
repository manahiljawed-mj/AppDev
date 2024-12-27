import 'package:flutter/material.dart';
import 'mic.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isPromptSent = false; // Track if the prompt is sent

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Header section with menu and title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                    onPressed: () {},
                  ),
                  const Text(
                    'Chat Section',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Show action cards only if the prompt has not been sent
              if (!_isPromptSent)
                Expanded(
                  child: ListView(
                    children: [
                      _buildActionCard('Turn your ideas into stunning visuals!'),
                      _buildActionCard('Unlock creativity with articles that inspire!'),
                      _buildActionCard('Craft engaging stories tailored to captivate.'),
                      _buildActionCard('Share your idea with articles designed.'),
                      _buildActionCard('Transform thoughts into compelling narratives.'),
                      _buildActionCard('Generate impactful content for your ideas.'),
                    ],
                  ),
                ),

              // Text prompt area with icons inside
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
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
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Mic Icon
                                IconButton(
                                  icon: const Icon(Icons.mic, color: Colors.white),
                                  onPressed: () {
                                    // Navigate to the MicScreen when mic is pressed
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const MicScreen()),
                                    );
                                  },
                                ),
                                // Attachment Icon
                                IconButton(
                                  icon: const Icon(Icons.attach_file, color: Colors.white),
                                  onPressed: () {
                                    // Handle file attachment action
                                    print('Attachment activated');
                                  },
                                ),
                                // Camera (Scan) Icon
                                IconButton(
                                  icon: const Icon(Icons.camera_alt, color: Colors.white),
                                  onPressed: () {
                                    // Handle scan action
                                    print('Scan activated');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          // Handle sending action
                          print('Prompt Sent: ${_controller.text}');
                          _controller.clear();

                          // Hide suggested prompts after the first prompt
                          setState(() {
                            _isPromptSent = true;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),

              // Bottom navigation bar
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavBarIcon(Icons.home, 'Home', isActive: true),
                  _buildNavBarIcon(Icons.history, 'History'),
                  _buildNavBarIcon(Icons.notifications, 'Notifications'),
                  _buildNavBarIcon(Icons.person, 'Profile'),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget _buildNavBarIcon(IconData icon, String label, {bool isActive = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? const Color(0xFF5E216D) : Colors.grey, size: 28),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF5E216D) : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
