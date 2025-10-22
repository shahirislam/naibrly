import 'package:flutter/material.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/views/base/Ios_effect/iosTapEffect.dart';

class BundleCard extends StatefulWidget {
  final String serviceTitle;
  final String bundleDescription;
  final String originalPrice;
  final String discountedPrice;
  final String savings;
  final List<Map<String, dynamic>> providers;
  final List<String> benefits;
  final VoidCallback? onJoinBundle;
  final bool isExpandable;
  final bool isExpanded;
  final VoidCallback? onToggleExpansion;

  const BundleCard({
    Key? key,
    required this.serviceTitle,
    required this.bundleDescription,
    required this.originalPrice,
    required this.discountedPrice,
    required this.savings,
    required this.providers,
    required this.benefits,
    this.onJoinBundle,
    this.isExpandable = true,
    this.isExpanded = false,
    this.onToggleExpansion,
  }) : super(key: key);

  @override
  State<BundleCard> createState() => _BundleCardState();
}

class _BundleCardState extends State<BundleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            offset: const Offset(0, 1),
            blurRadius: 15,
          ),
        ],
        border: Border.all(
          width: 0.8,
          color: Colors.black.withOpacity(0.10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Title and Bundle Description Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      widget.serviceTitle,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 4),
                    AppText(
                      widget.bundleDescription,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              // Joined Users Avatars
              Stack(
                children: [
                  _buildUserAvatar(),
                  Positioned(
                    left: 20,
                    child: _buildUserAvatar(),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              // Expand/Collapse Icon (only if expandable)
              if (widget.isExpandable)
                IosTapEffect(
                  onTap: widget.onToggleExpansion ?? () {},
                  child: Icon(
                    widget.isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Expanded Content
          if (widget.isExpanded && widget.isExpandable) ...[
            const SizedBox(height: 16),
            
            // Provider Information
            for (int i = 0; i < widget.providers.length; i++) ...[
              _buildProviderInfo(widget.providers[i]),
              if (i < widget.providers.length - 1) const SizedBox(height: 8),
            ],
            
            const SizedBox(height: 16),
            
            // Total Benefits Section
            const AppText(
              "Total Benefits:",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            const SizedBox(height: 8),
            
            for (String benefit in widget.benefits)
              _buildBenefitItem(benefit),

            const SizedBox(height: 15),
          ],

          // Pricing Row (always visible)
          Row(
            children: [
              // Original Price (Strikethrough)
              RichText(
                text: TextSpan(
                  text: widget.originalPrice,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.red,
                    decorationThickness: 2.0,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Discounted Price
              AppText(
                widget.discountedPrice,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              // Savings
              AppText(
                widget.savings,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
              const Spacer(),
              // Join Bundle Button
              IosTapEffect(
                onTap: widget.onJoinBundle ?? () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: widget.isExpanded ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1,
                    ),
                  ),
                  child: AppText(
                    "Join Bundle",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: widget.isExpanded ? Colors.white : AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        color: Colors.grey.shade300,
      ),
      child: Image.asset('assets/images/jane.png'),
    );
  }

  Widget _buildProviderInfo(Map<String, dynamic> provider) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade300,
          ),
          child: Image.asset(provider['avatar'] ?? 'assets/images/jane.png'),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                provider['name'] ?? 'Unknown Provider',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Image.asset('assets/images/location.png'),
                  const SizedBox(width: 4),
                  Expanded(
                    child: AppText(
                      provider['location'] ?? 'Unknown Location',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            "•",
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: AppText(
              text,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
