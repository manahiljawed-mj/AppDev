import 'package:flutter/material.dart';
import 'viewSubscription.dart'; // Import the SubscriptionScreen

class PricingScreen extends StatefulWidget {
  @override
  _PricingScreenState createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  String? selectedPlan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Pricing',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Unlock All Features.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Users can only access these features after which they make payments.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(height: 20),
            _buildFeaturesList(),
            SizedBox(height: 20),
            _buildTrialToggle(),
            SizedBox(height: 20),
            _buildSubscriptionOptions(),
            SizedBox(height: 30),
            _buildSubscribeButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      'Sync history across new chats.',
      'Prioritize Support.',
      'Upload URLs, docs, and manage chats.',
      'Unlimited chats with Alex',
      'Unlimited AI Image Generation',
    ];

    return Column(
      children: features
          .map((feature) => Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.purple, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildTrialToggle() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '7 days Free Trial Enabled',
            style: TextStyle(color: Colors.white),
          ),
          Switch(
            value: true,
            onChanged: (value) {},
            activeColor: Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionOptions() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedPlan = 'Yearly Plan';
            });
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: selectedPlan == 'Yearly Plan'
                  ? Colors.purple.withOpacity(0.2)
                  : Colors.grey[850],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Yearly',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  '\$6.99 USD / MO',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedPlan = 'Monthly Plan';
            });
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: selectedPlan == 'Monthly Plan'
                  ? Colors.purple.withOpacity(0.2)
                  : Colors.grey[850],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Monthly',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  '\$12.99 USD / MO',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubscribeButton() {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              if (selectedPlan != null) {
                _showConfirmationDialog(context, selectedPlan!);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please select a plan before subscribing!'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              child: Text(
                'Subscribe',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Subscription auto-renews until canceled',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String planName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Congratulations on upgrading to the $planName!',
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SubscriptionScreen(selectedPlan: planName),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                child: Text('Done', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
