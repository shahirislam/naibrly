import 'package:flutter/material.dart';
import 'package:naibrly/provider/screens/verify_information_screen.dart';
import '../widgets/button.dart';
import '../widgets/colors.dart';
import '../widgets/textfield.dart';
import '../widgets/upload_card.dart';

class YourInformationScreen extends StatefulWidget {
  const YourInformationScreen({super.key});

  @override
  State<YourInformationScreen> createState() => _YourInformationScreenState();
}

class _YourInformationScreenState extends State<YourInformationScreen> {
  String selectedCountryCode = "+1";
  String selectedStartDay = "Mon";
  String selectedEndDay = "Fri";
  String selectedStartTime = "9:00 am";
  String selectedEndTime = "5:00 pm";
  String selectedRole = "Owner";
  String selectedService = "Home Repairs";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KoreColors.background,
      appBar: AppBar(
        backgroundColor: KoreColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Your Information",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtext
            const Text(
              "We need to collect your personal business information.",
              style: TextStyle(
                color: Color(0xFF1C1C1C),
                fontSize: 13,
              ),
              textAlign: TextAlign.start,
            ),

            const SizedBox(height: 20),

            // Upload Business Logo
            const Text(
              "Upload Business Logo",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            const KoreUploadCard(
              label: "Upload Your Business Logo",
              hint: "Max 3 MB",
              icon: Icons.cloud_upload_outlined,
            ),
            const SizedBox(height: 24),

            // Business Name (Registered)
            const KoreTextField(
              label: "Business Name (AS REGISTERED)",
              hint: "Jacob Meikle",
            ),
            const SizedBox(height: 16),

            // Business Name (DBA)
            const KoreTextField(
              label: "Business Name (DBA)",
              hint: "Jacob Meikle",
            ),
            const SizedBox(height: 16),

            // Role dropdown
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<String>(
                underline: const SizedBox(),
                isExpanded: true,
                value: selectedRole,
                hint: const Text("Select your role"),
                items: const [
                  DropdownMenuItem(value: "Owner", child: Text("Owner")),
                  DropdownMenuItem(value: "Manager", child: Text("Manager")),
                  DropdownMenuItem(value: "Operator", child: Text("Operator")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),

            // Business Address
            TextField(
              decoration: InputDecoration(
                hintText: "Business Address",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF0E7A60)),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Phone number row
            Row(
              children: [
                // Country code dropdown
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedCountryCode,
                      isDense: true,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(value: "+1", child: Text("+1")),
                        DropdownMenuItem(value: "+44", child: Text("+44")),
                        DropdownMenuItem(value: "+91", child: Text("+91")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedCountryCode = value!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Phone number input
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF0E7A60)),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Business Website
            TextField(
              decoration: InputDecoration(
                hintText: "Business Website",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF0E7A60)),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Business Service Days
            const Text(
              "Business Service Days",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildDropdown(["Mon", "Tue", "Wed", "Thu", "Fri"], selectedStartDay, (value) {
                    setState(() {
                      selectedStartDay = value!;
                    });
                  }),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("to"),
                ),
                Expanded(
                  child: _buildDropdown(["Mon", "Tue", "Wed", "Thu", "Fri"], selectedEndDay, (value) {
                    setState(() {
                      selectedEndDay = value!;
                    });
                  }),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Business Hours
            const Text(
              "Business Hours",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildDropdown(["9:00 am", "10:00 am"], selectedStartTime, (value) {
                    setState(() {
                      selectedStartTime = value!;
                    });
                  }),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("to"),
                ),
                Expanded(
                  child: _buildDropdown(["5:00 pm", "6:00 pm"], selectedEndTime, (value) {
                    setState(() {
                      selectedEndTime = value!;
                    });
                  }),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Services Provided
            const Text(
              "Services Provided",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<String>(
                underline: const SizedBox(),
                isExpanded: true,
                value: selectedService,
                hint: const Text("Select services"),
                items: const [
                  DropdownMenuItem(value: "Home Repairs", child: Text("Home Repairs")),
                  DropdownMenuItem(value: "Cleaning", child: Text("Cleaning")),
                  DropdownMenuItem(value: "Renovations", child: Text("Renovations")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedService = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 8),

            const ServiceTag(
              text: "Home Repairs & Maintenance",
              dotColor: Color(0xFFFF7043),
              textColor: Color(0xFFFF7043),
              backgroundColor: Color(0xFFFFF0E6),
            ),
            SizedBox(height: 8),
            const ServiceTag(
              text: "Cleaning & Organization",
              dotColor: Color(0xFFFFC107),
              textColor: Color(0xFFFFC107),
              backgroundColor: Color(0xFFFFF9E5),
            ),
            SizedBox(height: 8),
            const ServiceTag(
              text: "Renovations & Upgrades",
              dotColor: Color(0xFFE53935),
              textColor: Color(0xFFE53935),
              backgroundColor: Color(0xFFFFEBEE),
            ),



            const SizedBox(height: 40),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: KoreButton(
          text: "Next",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const VerifyInformationScreen(),
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper dropdown builder
  Widget _buildDropdown(List<String> items, String value, Function(String?) onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        isExpanded: true,
        value: value,
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}


class ServiceTag extends StatelessWidget {
  final String text;
  final Color dotColor;
  final Color backgroundColor;

  const ServiceTag({
    super.key,
    required this.text,
    required this.dotColor,
    required this.backgroundColor, required Color textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, color: dotColor, size: 8),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
