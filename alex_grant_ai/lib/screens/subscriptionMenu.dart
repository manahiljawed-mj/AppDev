import 'package:alex_grant_ai/screens/viewSubscription.dart';
import 'package:flutter/material.dart';

import 'addCard.dart';
import 'billingHistory.dart';
import 'manageSubscription.dart';

class ManageSubscriptionScreen extends StatelessWidget {
  const ManageSubscriptionScreen({Key? key}) : super(key: key);

  Widget _buildListItem({
    required String title,
    required VoidCallback onTap,
    bool isPurple = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isPurple ? const Color(0xFF8E44AD).withOpacity(0.2) : const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: isPurple ? const Color(0xFF8E44AD) : Colors.white,
            fontSize: 16,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isPurple ? const Color(0xFF8E44AD) : Colors.white,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        onTap: onTap,
      ),
    );
  }

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
          'Manage Subscription',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _buildListItem(
                title: 'View Subscription',
                onTap: () {
                  // Handle view subscription
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewSubscriptionScreen()),
                  );
                },
                isPurple: true,
              ),
              _buildListItem(
                title: 'Manage Subscription',
                onTap: () {
                  // Handle manage subscription
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewSubscriptionScreen()),
                  );
                },
              ),
              _buildListItem(
                title: 'Subscription History',
                onTap: () {
                  // Handle subscription history
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BillingHistoryScreen()),
                  );
                },
              ),
              _buildListItem(
                title: 'Manage Debit Card',
                onTap: () {
                  // Handle manage debit card
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddCardScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}