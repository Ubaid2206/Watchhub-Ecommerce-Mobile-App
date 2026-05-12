import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  String searchQuery = '';
  
  final List<Map<String, dynamic>> users = [
    {
      'id': '1',
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'phone': '+1 234 567 8900',
      'totalOrders': 15,
      'totalSpent': 12500,
      'status': 'Active',
      'joinDate': '2023-01-15',
    },
    {
      'id': '2',
      'name': 'Jane Smith',
      'email': 'jane.smith@example.com',
      'phone': '+1 234 567 8901',
      'totalOrders': 8,
      'totalSpent': 5200,
      'status': 'Active',
      'joinDate': '2023-03-20',
    },
    {
      'id': '3',
      'name': 'Mike Johnson',
      'email': 'mike.j@example.com',
      'phone': '+1 234 567 8902',
      'totalOrders': 22,
      'totalSpent': 18900,
      'status': 'Active',
      'joinDate': '2022-11-10',
    },
    {
      'id': '4',
      'name': 'Sarah Williams',
      'email': 'sarah.w@example.com',
      'phone': '+1 234 567 8903',
      'totalOrders': 3,
      'totalSpent': 450,
      'status': 'Inactive',
      'joinDate': '2024-01-05',
    },
    {
      'id': '5',
      'name': 'Tom Brown',
      'email': 'tom.brown@example.com',
      'phone': '+1 234 567 8904',
      'totalOrders': 0,
      'totalSpent': 0,
      'status': 'Blocked',
      'joinDate': '2024-02-01',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredUsers = users.where((user) {
      final matchesSearch = user['name'].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                           user['email'].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          'User Management',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1a1a2e),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search users...',
                hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          // Stats Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: _buildStatItem('Total Users', users.length.toString(), Colors.blue),
                ),
                Container(width: 1, height: 30, color: Colors.grey[300]),
                Expanded(
                  child: _buildStatItem('Active', users.where((u) => u['status'] == 'Active').length.toString(), Colors.green),
                ),
                Container(width: 1, height: 30, color: Colors.grey[300]),
                Expanded(
                  child: _buildStatItem('Blocked', users.where((u) => u['status'] == 'Blocked').length.toString(), Colors.red),
                ),
              ],
            ),
          ),
          
          // Users List
          Expanded(
            child: filteredUsers.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people_outline, size: 64, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'No users found',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];
                      return _buildUserCard(user);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
    Color statusColor = user['status'] == 'Active' 
        ? Colors.green 
        : user['status'] == 'Blocked' 
            ? Colors.red 
            : Colors.grey;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: statusColor.withOpacity(0.1),
          child: Text(
            user['name'].toString().substring(0, 1).toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
        ),
        title: Text(
          user['name'],
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              user['email'],
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                user['status'],
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ),
          ],
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                _buildInfoRow(Icons.phone_outlined, 'Phone', user['phone']),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.calendar_today_outlined, 'Joined', user['joinDate']),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.shopping_bag_outlined, 'Total Orders', user['totalOrders'].toString()),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.attach_money, 'Total Spent', '\$${user['totalSpent']}'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _showUserDetails(user);
                        },
                        icon: const Icon(Icons.visibility_outlined, size: 18),
                        label: Text(
                          'View Details',
                          style: GoogleFonts.poppins(fontSize: 13),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey[300]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _toggleUserStatus(user);
                        },
                        icon: Icon(
                          user['status'] == 'Blocked' ? Icons.check_circle_outline : Icons.block,
                          size: 18,
                          color: Colors.white,
                        ),
                        label: Text(
                          user['status'] == 'Blocked' ? 'Unblock' : 'Block',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: user['status'] == 'Blocked' ? Colors.green : Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showUserDetails(Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'User Details',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue.withOpacity(0.1),
                child: Text(
                  user['name'].toString().substring(0, 1).toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                user['name'],
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                user['email'],
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              // Add more user details here
            ],
          ),
        );
      },
    );
  }

  void _toggleUserStatus(Map<String, dynamic> user) {
    setState(() {
      user['status'] = user['status'] == 'Blocked' ? 'Active' : 'Blocked';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'User ${user['status'] == 'Blocked' ? 'blocked' : 'unblocked'} successfully',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: user['status'] == 'Blocked' ? Colors.red : Colors.green,
      ),
    );
  }
}
