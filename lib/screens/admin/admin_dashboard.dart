import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../../providers/order_provider.dart';
import 'product_management_screen.dart';
import 'order_management_screen.dart';
import 'user_management_screen.dart';
import 'reviews_management_screen.dart';
import 'package:intl/intl.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1a1a2e),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Cards
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildStatCard(
                  'Total Orders',
                  orderProvider.totalOrders.toString(),
                  Icons.shopping_bag_outlined,
                  Colors.blue,
                  '',
                ),
                _buildStatCard(
                  'Revenue',
                  '\$${orderProvider.totalRevenue.toStringAsFixed(0)}',
                  Icons.attach_money,
                  Colors.green,
                  '',
                ),
                _buildStatCard(
                  'Pending',
                  orderProvider.pendingOrders.toString(),
                  Icons.access_time,
                  Colors.orange,
                  '',
                ),
                _buildStatCard(
                  'Delivered',
                  orderProvider.deliveredOrders.toString(),
                  Icons.check_circle_outline,
                  Colors.purple,
                  '',
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Sales Chart
            _buildSectionTitle('Sales Overview (Last 7 Days)'),
            const SizedBox(height: 16),
            _buildSalesChart(orderProvider),
            
            const SizedBox(height: 24),
            
            // Quick Actions
            _buildSectionTitle('Quick Actions'),
            const SizedBox(height: 16),
            _buildQuickActions(),
            
            const SizedBox(height: 24),
            
            // Recent Orders
            _buildSectionTitle('Recent Orders'),
            const SizedBox(height: 16),
            _buildRecentOrders(orderProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, String change) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              if (change.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    change,
                    style: GoogleFonts.poppins(
                      color: Colors.green,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1a1a2e),
                ),
              ),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1a1a2e),
      ),
    );
  }

  Widget _buildSalesChart(OrderProvider orderProvider) {
    final weeklySales = orderProvider.getWeeklySales();
    final spots = weeklySales.entries
        .map((e) => FlSpot(e.key.toDouble(), e.value / 1000))
        .toList();
    
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
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
      child: spots.isEmpty 
        ? Center(
            child: Text(
              'No sales data available',
              style: GoogleFonts.poppins(color: Colors.grey[600]),
            ),
          )
        : LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final now = DateTime.now();
                  final day = now.subtract(Duration(days: 6 - value.toInt()));
                  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  return Text(
                    days[day.weekday - 1],
                    style: GoogleFonts.poppins(fontSize: 10),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots.isNotEmpty ? spots : [const FlSpot(0, 0)],
              isCurved: true,
              color: const Color(0xFF1a1a2e),
              barWidth: 3,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: const Color(0xFF1a1a2e).withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.8,
      children: [
        _buildActionCard('Products', Icons.inventory_2_outlined, Colors.blue, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProductManagementScreen()),
          );
        }),
        _buildActionCard('Orders', Icons.shopping_bag_outlined, Colors.green, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const OrderManagementScreen()),
          );
        }),
        _buildActionCard('Users', Icons.people_outline, Colors.orange, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UserManagementScreen()),
          );
        }),
        _buildActionCard('Reviews', Icons.star_outline, Colors.purple, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReviewsManagementScreen()),
          );
        }),
      ],
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1a1a2e),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrders(OrderProvider orderProvider) {
    final recentOrders = orderProvider.getRecentOrders(limit: 5);
    final dateFormat = DateFormat('MMM dd, yyyy');
    
    return Container(
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
      child: recentOrders.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Text(
                'No recent orders',
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
          )
        : ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: recentOrders.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final order = recentOrders[index];
          Color statusColor;
          switch (order.status) {
            case 'Delivered':
              statusColor = Colors.green;
              break;
            case 'Processing':
              statusColor = Colors.blue;
              break;
            case 'Shipped':
              statusColor = Colors.purple;
              break;
            case 'Cancelled':
              statusColor = Colors.red;
              break;
            default:
              statusColor = Colors.orange;
          }
          
          return ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.shopping_bag_outlined, color: statusColor, size: 20),
            ),
            title: Text(
              'Order #${order.id.substring(0, 8)}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              '${order.userName} • \$${order.totalAmount.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                order.status,
                style: GoogleFonts.poppins(
                  color: statusColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
