import 'package:flutter/material.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/views/base/Ios_effect/iosTapEffect.dart';
import 'package:naibrly/widgets/bundle_card.dart';
import 'package:naibrly/services/mock_data_service.dart';
import 'package:naibrly/views/screen/Users/Home/create_bundle_bottomsheet.dart';

class BundelsScreen extends StatefulWidget {
  const BundelsScreen({super.key});

  @override
  State<BundelsScreen> createState() => _BundelsScreenState();
}

class _BundelsScreenState extends State<BundelsScreen> {
  List<Map<String, dynamic>> bundles = [];
  List<Map<String, dynamic>> categories = [];
  String selectedCategory = 'All';
  int? expandedIndex;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await MockDataService.initialize();
    
    setState(() {
      bundles = MockDataService.getActiveBundles();
      categories = MockDataService.getCategories();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        backgroundColor: AppColors.White,
        elevation: 0,
        title: const AppText(
          "Naibrly Bundles",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Handle search action
            },
            icon: const Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          //_buildCategoryFilter(),

          // Bundles List
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with count
                  Row(
                    children: [
                      AppText(
                        "${bundles.length} Active Bundles",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                      const Spacer(),
                      IosTapEffect(
                        onTap: () {
                          // Handle sort action
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.primary, width: 1),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(
                                "Sort",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF0E7A60),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.sort,
                                size: 16,
                                color: Color(0xFF0E7A60),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Bundle Cards
                     ...bundles.asMap().entries.map((entry) {
                       final index = entry.key;
                       final bundle = entry.value;

                       return Column(
                         children: [
                           BundleCard(
                             serviceTitle: bundle['title'] ?? 'Unknown Bundle',
                             bundleDescription: bundle['description'] ?? '',
                             originalPrice: '\$${bundle['originalPrice']}',
                             discountedPrice: '\$${bundle['discountedPrice']}',
                             savings: '-\$${bundle['originalPrice'] - bundle['discountedPrice']}',
                             providers: List<Map<String, dynamic>>.from(bundle['providers'] ?? []),
                             benefits: List<String>.from(bundle['benefits'] ?? []),
                             isExpanded: expandedIndex == index,
                             onToggleExpansion: () {
                               setState(() {
                                 expandedIndex = expandedIndex == index ? null : index;
                               });
                             },
                             onJoinBundle: () {
                               _handleJoinBundle(bundle['id']);
                             },
                           ),
                           if (index < bundles.length - 1) const SizedBox(height: 12),
                         ],
                       );
                     }),

                  const SizedBox(height: 20),
                  
                  // Create Bundle Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const CreateBundleBottomSheet(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0E7A60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Create Bundle",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // All Categories Button
          _buildCategoryChip('All', selectedCategory == 'All'),
          const SizedBox(width: 8),
          
          // Category Chips
          ...categories.map((category) {
            final categoryName = category['name'] ?? 'Unknown';
            final isSelected = selectedCategory == categoryName;
            
            return Row(
              children: [
                _buildCategoryChip(categoryName, isSelected),
                const SizedBox(width: 8),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String name, bool isSelected) {
    return IosTapEffect(
      onTap: () {
        setState(() {
          selectedCategory = name;
        });
        _filterBundlesByCategory();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: AppText(
          name,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : Colors.grey.shade600,
        ),
      ),
    );
  }

  void _filterBundlesByCategory() {
    if (selectedCategory == 'All') {
      setState(() {
        bundles = MockDataService.getActiveBundles();
      });
    } else {
      setState(() {
        bundles = MockDataService.getBundlesByCategory(selectedCategory);
      });
    }
  }

  Future<void> _handleJoinBundle(String bundleId) async {
    try {
      final success = await MockDataService.joinBundle(bundleId);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully joined bundle!'),
            backgroundColor: Colors.green,
          ),
        );
        // Refresh data
        _loadData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to join bundle. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
