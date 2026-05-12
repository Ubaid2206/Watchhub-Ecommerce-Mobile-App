import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedIssue = 'General Inquiry';

  final List<String> _issueTypes = [
    'General Inquiry',
    'Order Issue',
    'Payment Problem',
    'Product Question',
    'Account Help',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Customer Support'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'How can we help you?',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1a1a2e),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Fill out the form below and we\'ll get back to you soon',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              // Contact Info Cards
              Row(
                children: [
                  Expanded(
                    child: _buildContactCard(
                      icon: Icons.email,
                      title: 'Email',
                      value: 'support@watchhub.com',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildContactCard(
                      icon: Icons.phone,
                      title: 'Phone',
                      value: '+92 300 1234567',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Email Field
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Issue Type Dropdown
              DropdownButtonFormField<String>(
                value: _selectedIssue,
                decoration: InputDecoration(
                  labelText: 'Issue Type',
                  prefixIcon: const Icon(Icons.category_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _issueTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedIssue = newValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              // Message Field
              TextFormField(
                controller: _messageController,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: 'Your Message',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Message sent successfully!'),
                        ),
                      );
                      _nameController.clear();
                      _emailController.clear();
                      _messageController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1a1a2e),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Send Message',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // FAQ Section
              Text(
                'Frequently Asked Questions',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1a1a2e),
                ),
              ),
              const SizedBox(height: 16),
              _buildFAQItem(
                'How long does shipping take?',
                'Standard shipping takes 5-7 business days.',
              ),
              _buildFAQItem(
                'What is your return policy?',
                '30-day return policy for all products.',
              ),
              _buildFAQItem(
                'Do you ship internationally?',
                'Yes, we ship to most countries worldwide.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a2e).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF1a1a2e), size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1a1a2e),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// ```

// ---

// ## ✅ **DONE! Project Complete!**

// **Ye raha complete folder structure:**
// ```
// lib/
//   ├── main.dart
//   ├── models/
//   │   ├── watch_model.dart
//   │   ├── user_model.dart
//   │   └── review_model.dart
//   ├── providers/
//   │   ├── auth_provider.dart
//   │   ├── cart_provider.dart
//   │   └── wishlist_provider.dart
//   ├── screens/
//   │   ├── splash_screen.dart
//   │   ├── auth/
//   │   │   ├── login_screen.dart
//   │   │   └── signup_screen.dart
//   │   ├── home/
//   │   │   ├── main_screen.dart
//   │   │   └── home_screen.dart
//   │   ├── product/
//   │   │   └── product_detail_screen.dart
//   │   ├── reviews/
//   │   │   └── reviews_screen.dart
//   │   ├── search/
//   │   │   └── search_screen.dart
//   │   ├── cart/
//   │   │   └── cart_screen.dart
//   │   ├── wishlist/
//   │   │   └── wishlist_screen.dart
//   │   └── profile/
//   │       ├── profile_screen.dart
//   │       ├── edit_profile_screen.dart
//   │       ├── order_history_screen.dart
//   │       ├── addresses_screen.dart
//   │       └── support_screen.dart
//   └── widgets/
//       └── watch_card.dart