import 'package:flutter/material.dart';

class BillingHistoryScreen extends StatelessWidget {
  final List<Map<String, String>> billingData = [
    {
      'plan': 'Pro Plan',
      'card': '**** **** **** 9087',
      'servicePeriod': '10/07/2024 - 10/08/2024',
      'datePaid': '10/07/2024',
      'subtotal': '\$16.99',
      'vat': '\$2.99',
      'total': '\$17.99',
    },
    {
      'plan': 'Pro Plan',
      'card': '**** **** **** 9087',
      'servicePeriod': '10/07/2024 - 10/08/2024',
      'datePaid': '10/07/2024',
      'subtotal': '\$16.99',
      'vat': '\$2.99',
      'total': '\$17.99',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Your Billing History',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: billingData.length,
          itemBuilder: (context, index) {
            final data = billingData[index];
            return _buildBillingCard(data);
          },
        ),
      ),
    );
  }

  Widget _buildBillingCard(Map<String, String> data) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderRow(data['plan']!, data['total']!),
          SizedBox(height: 10),
          _buildRowWithIcon(Icons.credit_card, data['card']!),
          SizedBox(height: 10),
          _buildInfoRow('Service Period', data['servicePeriod']!),
          SizedBox(height: 5),
          _buildInfoRow('Date Paid', data['datePaid']!),
          SizedBox(height: 5),
          _buildInfoRow('Subtotal', '${data['subtotal']} (${data['vat']} VAT)'),
          SizedBox(height: 5),
          _buildInfoRow('Total', data['total']!),
        ],
      ),
    );
  }

  Widget _buildHeaderRow(String plan, String total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          plan,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          total,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildRowWithIcon(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange, size: 20),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
