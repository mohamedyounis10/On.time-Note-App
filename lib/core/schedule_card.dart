import 'package:flutter/material.dart';
import 'app_color.dart';
import 'app_padding.dart';

class ScheduleCard extends StatelessWidget {
  final String day;
  final String title;
  final String time;
  final bool isChecked;
  final ValueChanged<bool>? onChanged;

  const ScheduleCard({
    Key? key,
    required this.day,
    required this.title,
    required this.time,
    this.isChecked = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Day Circle
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColor.mainPurple,
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.mainPurple, width: 3),
              ),
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              width: 2,
              height: 80,
              color: AppColor.mainPurple,
            ),
          ],
        ),
        SizedBox(width: 12),
        // Card
        Expanded(
          child: Container(
            padding: AppPadding.cardPadding,
            margin: EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: AppColor.cardDark,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppColor.whiteBoldText.copyWith(fontSize: 18),
                    ),
                    Divider(color: AppColor.mainPurple, thickness: 1),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text("Time  ", style: AppColor.white70Text.copyWith(fontWeight: FontWeight.bold)),
                        Text(time, style: AppColor.whiteText),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      if (onChanged != null) {
                        onChanged!(!isChecked); // Toggle value
                      }
                    },
                    child: Icon(
                      isChecked ? Icons.check_box : Icons.check_box_outline_blank,
                      color: AppColor.mainPurple,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}