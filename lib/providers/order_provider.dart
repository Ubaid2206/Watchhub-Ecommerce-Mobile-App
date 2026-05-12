import 'package:flutter/material.dart';
import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _orders = [];
  
  List<OrderModel> get orders => _orders;
  
  List<OrderModel> getUserOrders(String userId) {
    return _orders.where((order) => order.userId == userId).toList();
  }
  
  List<OrderModel> getOrdersByStatus(String status) {
    if (status == 'All') return _orders;
    return _orders.where((order) => order.status == status).toList();
  }
  
  void addOrder(OrderModel order) {
    _orders.insert(0, order); // Add at the beginning
    notifyListeners();
  }
  
  void updateOrderStatus(String orderId, String newStatus) {
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      final updatedOrder = OrderModel(
        id: _orders[index].id,
        userId: _orders[index].userId,
        userName: _orders[index].userName,
        userEmail: _orders[index].userEmail,
        items: _orders[index].items,
        totalAmount: _orders[index].totalAmount,
        status: newStatus,
        orderDate: _orders[index].orderDate,
        shippingAddress: _orders[index].shippingAddress,
        paymentMethod: _orders[index].paymentMethod,
      );
      _orders[index] = updatedOrder;
      notifyListeners();
    }
  }
  
  void cancelOrder(String orderId) {
    updateOrderStatus(orderId, 'Cancelled');
  }
  
  int get totalOrders => _orders.length;
  
  int get pendingOrders => 
      _orders.where((order) => order.status == 'Pending').length;
  
  int get processingOrders => 
      _orders.where((order) => order.status == 'Processing').length;
  
  int get shippedOrders => 
      _orders.where((order) => order.status == 'Shipped').length;
  
  int get deliveredOrders => 
      _orders.where((order) => order.status == 'Delivered').length;
  
  int get cancelledOrders => 
      _orders.where((order) => order.status == 'Cancelled').length;
  
  double get totalRevenue {
    return _orders
        .where((order) => 
            order.status != 'Cancelled' && order.status != 'Pending')
        .fold(0, (sum, order) => sum + order.totalAmount);
  }
  
  // Get recent orders for dashboard
  List<OrderModel> getRecentOrders({int limit = 5}) {
    return _orders.take(limit).toList();
  }
  
  // Get sales data for chart (last 7 days)
  Map<int, double> getWeeklySales() {
    final now = DateTime.now();
    final weekSales = <int, double>{};
    
    for (int i = 0; i < 7; i++) {
      weekSales[i] = 0;
    }
    
    for (var order in _orders) {
      final daysDiff = now.difference(order.orderDate).inDays;
      if (daysDiff < 7 && order.status != 'Cancelled') {
        final dayIndex = 6 - daysDiff;
        weekSales[dayIndex] = (weekSales[dayIndex] ?? 0) + order.totalAmount;
      }
    }
    
    return weekSales;
  }
}
