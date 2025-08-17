import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import '../cubit/logic.dart';
import '../cubit/state.dart';
import '../models/task.dart';
import '../../core/app_color.dart';
import '../../core/app_padding.dart';

class NoteScreen extends StatelessWidget {
  final TextEditingController text = TextEditingController();

  DateTime? localSelectedDay;

  @override
  Widget build(BuildContext context) {
    localSelectedDay = context.read<ToDoLogic>().selectedDay;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.backgroundDark!,
              AppColor.backgroundPurple!,
              AppColor.backgroundBlack!,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: AppPadding.pagePadding,
            child: BlocConsumer<ToDoLogic, ToDoState>(
              listener: (context,state){
                if(state is AddState){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                      content: Text(
                        "Task Added",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                  Navigator.pop(context);
                }
                if(state is EmptyState){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text(
                        "Please write a note and select a date",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.grey,
                    ),
                  );

                }
              },
              builder:(context,state) {
                return Column(
                  children: [
                    // Back Button
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Note',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 22.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 48),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Items
                    Expanded(
                      child: Column(
                            children: [
                              // Text Field
                              Expanded(
                                child: TextFormField(
                                  controller: text,
                                  maxLines: 10,
                                  style: AppColor.whiteText.copyWith(
                                      fontSize: 18.sp),
                                  decoration: InputDecoration(
                                    hintText: 'Write your note here...',
                                    hintStyle: AppColor.white70Text.copyWith(
                                        fontSize: 18.sp),
                                    filled: true,
                                    fillColor: const Color(0xff7E64FF),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18.r),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: AppPadding.textFieldPadding,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.h),

                              // Calendar
                              TableCalendar(
                                firstDay: DateTime.utc(2020, 1, 1),
                                lastDay: DateTime.utc(2030, 12, 31),
                                focusedDay: context.read<ToDoLogic>().focusedDay,
                                selectedDayPredicate: (day) => isSameDay(localSelectedDay, day),
                                onDaySelected: (selectedDay, focusedDay) {
                                  if (!selectedDay.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
                                    localSelectedDay = selectedDay;
                                    context.read<ToDoLogic>().selectDay(selectedDay);
                                  }
                                },
                                // New: Disable days before today
                                enabledDayPredicate: (day) {
                                  return !day.isBefore(DateTime.now().subtract(Duration(days: 1)));
                                },
                                headerStyle: HeaderStyle(
                                  titleTextStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  formatButtonVisible: false,
                                  leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                                  rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
                                  headerPadding: EdgeInsets.symmetric(vertical: 8),
                                  titleCentered: true,
                                ),
                                daysOfWeekStyle: DaysOfWeekStyle(
                                  weekdayStyle: AppColor.whiteText,
                                  weekendStyle: AppColor.whiteText,
                                ),
                                calendarStyle: CalendarStyle(
                                  defaultTextStyle: AppColor.whiteText,
                                  weekendTextStyle: TextStyle(color: Colors.red),
                                  disabledTextStyle: TextStyle(color: Colors.grey), // Added to style disabled days
                                  todayDecoration: BoxDecoration(
                                    color: Color(0xff7E64FF),
                                    shape: BoxShape.circle,
                                  ),
                                  todayTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  selectedDecoration: BoxDecoration(
                                    color: Color(0xff7E64FF),
                                    shape: BoxShape.circle,
                                  ),
                                  selectedTextStyle: AppColor.whiteText,
                                ),
                              ),
                              SizedBox(height: 15.h),

                              // Add Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff7D64FF),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (text.text.isNotEmpty &&
                                        localSelectedDay != null) {
                                      final task = Task(
                                        context
                                            .read<ToDoLogic>()
                                            .tasks
                                            .length + 1,
                                        text.text,
                                        false,
                                        localSelectedDay!,
                                      );
                                      context.read<ToDoLogic>().addTask(task);
                                    } else {
                                      context.read<ToDoLogic>().emptyField();
                                    }
                                  },
                                  child: Text(
                                    "Add",
                                    style: TextStyle(
                                        fontSize: 20.sp, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                    ),
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
