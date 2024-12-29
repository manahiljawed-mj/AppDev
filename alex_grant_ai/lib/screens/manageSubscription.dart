import 'package:flutter/material.dart';
import 'viewSubscription.dart'; // Import the file containing SubscriptionScreen
import 'subscriptionHistoryScreen.dart';

class ManageSubscriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Manage Subscription',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          _buildOptionTile(context, 'View Subscription', SubscriptionScreen()),
          SizedBox(height: 16),
          _buildOptionTile(
              context, 'Manage Subscription', SubscriptionScreen()),
          SizedBox(height: 16),
          _buildOptionTile(
              context, 'Subscription History', BillingHistoryScreen()),
          SizedBox(height: 16),
          _buildOptionTile(context, 'Manage Debit Card', SubscriptionScreen()),
        ],
      ),
    );
  }

  Widget _buildOptionTile(BuildContext context, String title, Widget? screen) {
    return GestureDetector(
      onTap: () {
        if (screen != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: title == 'View Subscription'
                ? Color(0xFF9A4DFF)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: ManageSubscriptionScreen(),
      debugShowCheckedModeBanner: false,
    ));
