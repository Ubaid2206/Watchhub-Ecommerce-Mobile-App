import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewsManagementScreen extends StatefulWidget {
  const ReviewsManagementScreen({super.key});

  @override
  State<ReviewsManagementScreen> createState() => _ReviewsManagementScreenState();
}

class _ReviewsManagementScreenState extends State<ReviewsManagementScreen> {
  String selectedFilter = 'All';
  
  final List<Map<String, dynamic>> reviews = [
    {
      'id': '1',
      'userName': 'John Doe',
      'productName': 'Rolex Submariner',
      'rating': 5,
      'comment': 'Absolutely stunning watch! The quality is exceptional and it looks even better in person.',
      'date': '2024-02-10',
      'status': 'Pending',
    },
    {
      'id': '2',
      'userName': 'Jane Smith',
      'productName': 'Omega Speedmaster',
      'rating': 4,
      'comment': 'Great watch, but the delivery took longer than expected. Overall satisfied with the purchase.',
      'date': '2024-02-09',
      'status': 'Approved',
    },
    {
      'id': '3',
      'userName': 'Mike Johnson',
      'productName': 'Tag Heuer Carrera',
      'rating': 5,
      'comment': 'Perfect for sports activities. Love the design and functionality!',
      'date': '2024-02-08',
      'status': 'Approved',
    },
    {
      'id': '4',
      'userName': 'Sarah Williams',
      'productName': 'Casio G-Shock',
      'rating': 3,
      'comment': 'Good watch but had some issues with the strap.',
      'date': '2024-02-07',
      'status': 'Pending',
    },
    {
      'id': '5',
      'userName': 'Tom Brown',
      'productName': 'Seiko Presage',
      'rating': 1,
      'comment': 'This is spam content with inappropriate language!!!',
      'date': '2024-02-06',
      'status': 'Rejected',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredReviews = selectedFilter == 'All'
        ? reviews
        : reviews.where((review) => review['status'] == selectedFilter).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          'Reviews Management',
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
          // Filter Tabs
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                _buildFilterTab('All', reviews.length),
                _buildFilterTab('Pending', reviews.where((r) => r['status'] == 'Pending').length),
                _buildFilterTab('Approved', reviews.where((r) => r['status'] == 'Approved').length),
                _buildFilterTab('Rejected', reviews.where((r) => r['status'] == 'Rejected').length),
              ],
            ),
          ),
          
          // Reviews List
          Expanded(
            child: filteredReviews.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star_outline, size: 64, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'No reviews found',
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
                    itemCount: filteredReviews.length,
                    itemBuilder: (context, index) {
                      final review = filteredReviews[index];
                      return _buildReviewCard(review);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String label, int count) {
    final isSelected = selectedFilter == label;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedFilter = label;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? const Color(0xFF1a1a2e) : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? const Color(0xFF1a1a2e) : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1a1a2e) : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    Color statusColor = review['status'] == 'Approved' 
        ? Colors.green 
        : review['status'] == 'Rejected' 
            ? Colors.red 
            : Colors.orange;

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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue.withOpacity(0.1),
                  child: Text(
                    review['userName'].toString().substring(0, 1).toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            review['userName'],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              review['status'],
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        review['productName'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Rating
            Row(
              children: [
                ...List.generate(5, (index) {
                  return Icon(
                    index < review['rating'] ? Icons.star : Icons.star_outline,
                    color: Colors.amber,
                    size: 18,
                  );
                }),
                const SizedBox(width: 8),
                Text(
                  review['date'],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Comment
            Text(
              review['comment'],
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            
            // Actions for Pending reviews
            if (review['status'] == 'Pending') ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _updateReviewStatus(review, 'Rejected');
                      },
                      icon: const Icon(Icons.close, size: 18),
                      label: Text(
                        'Reject',
                        style: GoogleFonts.poppins(fontSize: 13),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
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
                        _updateReviewStatus(review, 'Approved');
                      },
                      icon: const Icon(Icons.check, size: 18, color: Colors.white),
                      label: Text(
                        'Approve',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            
            // Delete option for all reviews
            if (review['status'] != 'Pending') ...[
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () {
                  _deleteReview(review);
                },
                icon: const Icon(Icons.delete_outline, size: 18),
                label: Text(
                  'Delete Review',
                  style: GoogleFonts.poppins(fontSize: 13),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _updateReviewStatus(Map<String, dynamic> review, String newStatus) {
    setState(() {
      review['status'] = newStatus;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Review ${newStatus.toLowerCase()} successfully',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: newStatus == 'Approved' ? Colors.green : Colors.orange,
      ),
    );
  }

  void _deleteReview(Map<String, dynamic> review) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete Review',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Are you sure you want to delete this review?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                reviews.removeWhere((r) => r['id'] == review['id']);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Review deleted successfully',
                    style: GoogleFonts.poppins(),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
