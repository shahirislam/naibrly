import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/views/base/Ios_effect/iosTapEffect.dart';
import 'package:naibrly/views/screen/Users/Home/bundle_published_bottomsheet.dart';

class CreateBundleBottomSheet extends StatefulWidget {
  const CreateBundleBottomSheet({super.key});

  @override
  State<CreateBundleBottomSheet> createState() => _CreateBundleBottomSheetState();
}

class _CreateBundleBottomSheetState extends State<CreateBundleBottomSheet> {
  String? selectedCategory;
  DateTime? fromDate;
  DateTime? toDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  
  final List<String> categories = [
    'Interior',
    'Door & Window',
    'Plumbing',
    'Electrical',
    'HVAC',
    'Cleaning',
    'Maintenance'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
            // Header
            Center(
              child: Column(
                children: [
                  const AppText(
                    "Create Bundle",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    "Bundle Target: 3 Users (within 10 miles)",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textcolor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            // Category Selection Section
            const AppText(
              "Select Category*",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            const SizedBox(height: 12),
            
            // Selected Categories Chips
            Row(
              children: [
                Expanded(
                  child: _buildCategoryChip("Interior"),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildCategoryChip("Door & window..."),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Dropdown for selecting category
            Container(
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red, // Red border as shown in design
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  hintText: "Select one",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),
            
            // Date Selection Section
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        "From date*",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 8),
                      _buildDateField("Select date", fromDate, (date) {
                        setState(() {
                          fromDate = date;
                        });
                      }),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        "To date*",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 8),
                      _buildDateField("Select date", toDate, (date) {
                        setState(() {
                          toDate = date;
                        });
                      }),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Time Selection Section
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        "From*",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 8),
                      _buildTimeField("00:00", fromTime, (time) {
                        setState(() {
                          fromTime = time;
                        });
                      }),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        "To Time*",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 8),
                      _buildTimeField("00:00", toTime, (time) {
                        setState(() {
                          toTime = time;
                        });
                      }),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 20),
            
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // Close the create bundle bottom sheet
                  Navigator.pop(context);
                  
                  // Show the success bottom sheet
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const BundlePublishedBottomSheet(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7043), // Orange color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Publish",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
              SizedBox(height: 10),
          ],
        ),
      ),
    ),
    );
  }

  Widget _buildCategoryChip(String text) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9), // Light greenish-grey
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String hint, DateTime? selectedDate, Function(DateTime?) onDateSelected) {
    return IosTapEffect(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedDate != null 
                  ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                  : hint,
                style: TextStyle(
                  fontSize: 14,
                  color: selectedDate != null ? Colors.black : Colors.grey,
                ),
              ),
            ),
            const Icon(
              Icons.calendar_today,
              size: 20,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeField(String hint, TimeOfDay? selectedTime, Function(TimeOfDay?) onTimeSelected) {
    return IosTapEffect(
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? TimeOfDay.now(),
        );
        if (picked != null) {
          onTimeSelected(picked);
        }
      },
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedTime != null 
                  ? selectedTime!.format(context)
                  : hint,
                style: TextStyle(
                  fontSize: 14,
                  color: selectedTime != null ? Colors.black : Colors.grey,
                ),
              ),
            ),
            const Icon(
              Icons.access_time,
              size: 20,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
