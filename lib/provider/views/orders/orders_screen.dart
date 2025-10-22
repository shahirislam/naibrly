import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/order.dart';
import '../../viewmodels/orders_viewmodel.dart';
import '../../widgets/orders/order_card.dart';
import '../../widgets/orders/filter_tabs.dart';
import 'package:naibrly/widgets/payment_confirmation_bottom_sheet.dart';
import '../../widgets/home/bottom_navigation.dart';
import '../../widgets/colors.dart';
import '../../screens/order_inbox_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _currentBottomNavIndex = 1; // Orders tab is selected

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrdersViewModel(),
      child: Scaffold(
        backgroundColor: KoreColors.background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Your Orders',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          centerTitle: false,
        ),
        body: Consumer<OrdersViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                // Filter tabs
                FilterTabs(
                  currentFilter: viewModel.currentFilter,
                  onFilterChanged: (filter) => viewModel.setFilter(filter),
                  openCount: viewModel.openOrdersCount,
                  closedCount: viewModel.closedOrdersCount,
                ),
                
                // Orders list
                Expanded(
                  child: viewModel.orders.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 80),
                          itemCount: viewModel.orders.length,
                          itemBuilder: (context, index) {
                            final order = viewModel.orders[index];
                            return OrderCard(
                              order: order,
                              onTap: () => _showOrderDetails(context, order, viewModel),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 48,
            color: KoreColors.textLight.withOpacity(0.5),
          ),
          const SizedBox(height: 12),
          Text(
            'No orders found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: KoreColors.textLight,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'You don\'t have any ${_getCurrentFilterText()} orders yet',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: KoreColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrentFilterText() {
    return context.read<OrdersViewModel>().currentFilter == OrderFilter.open 
        ? 'open' 
        : 'closed';
  }

  void _showOrderDetails(BuildContext context, order, OrdersViewModel viewModel) {
    // Only show bottom sheet for pending orders
    if (order.status == OrderStatus.pending) {
      showOrderDetailsBottomSheet(
        context,
        orderData: {
          'id': order.id,
          'status': order.status.toString().split('.').last,
          'customer': order.customerName,
          'service': order.serviceName,
          'amount': order.price.toString(),
          'date': order.createdAt.toString(),
          'notes': order.description,
        },
      );
    } else if (order.status == OrderStatus.accepted || order.status == OrderStatus.cancelled || order.status == OrderStatus.completed) {
      // For accepted, cancelled, and completed orders, navigate to OrderInboxScreen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OrderInboxScreen(order: order),
        ),
      );
    } else {
      // For other orders, show a simple snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order details for ${order.serviceName} (${order.statusText})'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _navigateToTab(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacementNamed('/home');
        break;
      case 1:
        // Already on orders screen
        break;
      case 2:
        // TODO: Navigate to notifications
        break;
      case 3:
        // TODO: Navigate to profile
        break;
    }
  }
}
