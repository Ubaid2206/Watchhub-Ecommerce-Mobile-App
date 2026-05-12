# WatchHub Admin Panel

## Overview
Complete admin panel for managing your WatchHub e-commerce store.

## Features

### 1. Dashboard
- **Statistics Overview**: Total orders, revenue, products, and users
- **Sales Chart**: Visual representation of weekly sales
- **Recent Orders**: Quick view of latest orders
- **Quick Actions**: Fast navigation to all management screens

### 2. Product Management
- **View Products**: See all products with search and category filter
- **Add Product**: Create new products with details
- **Edit Product**: Update existing product information
- **Delete Product**: Remove products from inventory
- **Product Details**: Name, price, stock, category, brand, specifications

### 3. Order Management
- **Status Filters**: All, Pending, Processing, Shipped, Delivered, Cancelled
- **Order Details**: Customer info, items, total amount
- **Update Status**: Process, ship, or cancel orders
- **Order Actions**: Quick actions for pending orders

### 4. User Management
- **User List**: View all registered users
- **Search Users**: Find users by name or email
- **User Details**: Orders, spending, join date
- **Block/Unblock**: Control user access
- **User Stats**: Total users, active, blocked

### 5. Reviews Management
- **Filter Reviews**: All, Pending, Approved, Rejected
- **Approve/Reject**: Moderate user reviews
- **Delete Reviews**: Remove inappropriate content
- **Review Details**: User, product, rating, comment

## How to Access

### From Your App:
1. Add a button or menu item in your app to navigate to admin panel
2. Import the admin login screen:
```dart
import 'package:watchhub/screens/admin/admin_login_screen.dart';
```

3. Navigate to admin login:
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const AdminLoginScreen()),
);
```

### Demo Credentials:
- **Email**: admin@watchhub.com
- **Password**: admin123

## File Structure
```
lib/screens/admin/
├── admin_dashboard.dart           # Main dashboard
├── admin_login_screen.dart        # Admin authentication
├── product_management_screen.dart # Product CRUD
├── add_product_screen.dart        # Add/Edit products
├── order_management_screen.dart   # Order management
├── user_management_screen.dart    # User management
└── reviews_management_screen.dart # Review moderation
```

## Dependencies Required
Make sure you have these in your `pubspec.yaml`:
```yaml
dependencies:
  provider: ^6.1.5+1
  google_fonts: ^8.0.1
  fl_chart: ^0.69.2  # For charts in dashboard
```

## Installation
1. Run `flutter pub get` to install dependencies
2. The admin panel is ready to use!

## Integration Tips

### Add Admin Access in Profile Screen:
```dart
// In your profile_screen.dart, add this tile:
ListTile(
  leading: const Icon(Icons.admin_panel_settings),
  title: const Text('Admin Panel'),
  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AdminLoginScreen()),
    );
  },
)
```

### Add Admin Button in Drawer/Menu:
```dart
ListTile(
  leading: const Icon(Icons.dashboard),
  title: const Text('Admin Dashboard'),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AdminLoginScreen()),
    );
  },
)
```

## Features Coming Soon
- Analytics & Reports
- Inventory Management
- Discount & Coupon Management
- Email Notifications
- Export Data (CSV, PDF)
- Multi-admin Support

## Notes
- This is a demo version with static data
- Connect to your backend API for real data
- Implement proper authentication and authorization
- Add role-based access control for production use

## Support
For issues or questions, contact: support@watchhub.com
