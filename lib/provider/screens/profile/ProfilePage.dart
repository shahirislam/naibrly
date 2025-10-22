import 'package:flutter/material.dart';
import '../../widgets/profile/address_change_section.dart';
import '../../widgets/profile/my_information_section.dart';
import '../../widgets/profile/my_services_section.dart';
import '../../widgets/profile/payout_information_section.dart';
import '../../widgets/profile/profile_header.dart';
import '../../widgets/profile/service_area_section.dart';
import '../../widgets/profile/settings_section.dart';
import 'package:naibrly/widgets/payment_confirmation_bottom_sheet.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Profile",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),

              ProfileHeader(
                onWithdrawPressed: () => _showWithdrawBottomSheet(context),
              ),

              const SizedBox(height: 30),
              const MyInformationSection(),

              const SizedBox(height: 30),
              const MyServicesSection(),

              const SizedBox(height: 30),
              const ServiceAreaSection(),

              const SizedBox(height: 30),
              const PayoutInformationSection(),

              const SizedBox(height: 30),
              const AddressChangeSection(),

              const SizedBox(height: 20),
              const SettingsSection(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showWithdrawBottomSheet(BuildContext context) {
    showWithdrawBottomSheet(
      context,
      onSuccess: () => _showSuccessBottomSheet(context),
    );
  }

  void _showSuccessBottomSheet(BuildContext context) {
    showSuccessBottomSheet(context);
  }
}
