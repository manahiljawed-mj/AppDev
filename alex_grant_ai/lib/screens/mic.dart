import 'package:flutter/material.dart';

class MicScreen extends StatelessWidget {
  const MicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to previous screen
          },
        ),
        title: const Text(
          'Voice Call',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile Image
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Sample profile image
            ),
            const SizedBox(height: 20),

            // // Username or Profile name
            // const Text(
            //   'John Doe', // Sample name
            //   style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
            // ),
            // const SizedBox(height: 20),
            //
            // // Call Status Text
            // const Text(
            //   'On Call',
            //   style: TextStyle(color: Colors.white, fontSize: 18),
            // ),
            const SizedBox(height: 40),

            // Control buttons (Pause, Voice, Hang up)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Pause Button
                _buildControlButton(Icons.pause, Colors.white, () {
                  print("Pause button pressed");
                }),
                const SizedBox(width: 40),

                // Voice Button
                _buildControlButton(Icons.volume_up, Colors.white, () {
                  print("Voice button pressed");
                }),
                const SizedBox(width: 40),

                // Hang Up Button
                _buildControlButton(Icons.call_end, Colors.red, () {
                  print("Hang up button pressed");
                  Navigator.pop(context); // Go back to the chat screen
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton(IconData icon, Color color, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: color, size: 40),
      onPressed: onPressed,
    );
  }
}