import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class LanguagePreferenceScreen extends StatefulWidget {
  const LanguagePreferenceScreen({Key? key}) : super(key: key);

  @override
  _LanguagePreferenceScreenState createState() =>
      _LanguagePreferenceScreenState();
}

class _LanguagePreferenceScreenState extends State<LanguagePreferenceScreen> {
  Country? _selectedCountry; // Variable to store the selected country

  @override
  void initState() {
    super.initState();
    // Automatically trigger the country picker when the screen is initialized
    Future.delayed(Duration.zero, () => _showCountryPicker(context));
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
          // Profile Card (same as before)
          _buildSettingItem(
            icon: Icons.language,
            title: 'Language Preference',
            onTap: () {
              _showCountryPicker(context); // Trigger country picker when tapped
            },
          ),
          _buildDivider(),
          // Other setting items...
        ],
      ),
    );
  }

  // Build individual setting item
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

  // Divider between settings
  Widget _buildDivider() {
    return const Divider(
      color: Color(0xFF222222),
      height: 1,
      thickness: 1,
    );
  }

  // Function to show the country picker dialog
  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: false, // Optionally, hide the phone code
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
        });

        // Display a snackbar with the selected country name and flag
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selected: ${country.name}'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }
}
