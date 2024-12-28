import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
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
          'View Subscription',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPlanSection(),
            SizedBox(height: 20),
            _buildFeaturesSection(),
            SizedBox(height: 20),
            _buildPaymentInfoSection(),
            SizedBox(height: 20),
            _buildAddCardButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Yearly Plan',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text('Manage'),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection() {
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

  Widget _buildPaymentInfoSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Information',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Next Payment Date', style: TextStyle(color: Colors.grey)),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View History',
                  style: TextStyle(color: Colors.purple),
                ),
              ),
            ],
          ),
          Text(
            '10th October 2024',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Payment Fee', style: TextStyle(color: Colors.grey)),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Remove Card',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
          Text(
            '\$12.99',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Payment Mode', style: TextStyle(color: Colors.grey)),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.purple),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Image.asset(
                'images/card.png',
                width: 40,
                height: 40,
              ),
              SizedBox(width: 10),
              Text(
                '**** **** **** 9087',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddCardButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          child: Text(
            'Add New Card',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
