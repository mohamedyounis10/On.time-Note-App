import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../core/app_color.dart';
import '../../core/app_padding.dart';
import '../../core/schedule_card.dart';
import '../cubit/logic.dart';
import '../cubit/state.dart';
import 'note_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundDark,
      endDrawer: Drawer(
        backgroundColor: const Color(0xff3C1F7B),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColor.backgroundDark!,
                AppColor.backgroundPurple!,
                AppColor.backgroundBlack!,
              ],
            ),
          ),
          child: Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    "Menu",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.white),
                title: Text("Schedule", style: AppColor.whiteText),
                onTap: () {
                  Navigator.of(context).pop();
                  context.read<ToDoLogic>().toggleView(true);
                },
              ),
              ListTile(
                leading: Icon(Icons.note, color: Colors.white),
                title: Text("Notes", style: AppColor.whiteText),
                onTap: () {
                  Navigator.of(context).pop();
                  context.read<ToDoLogic>().toggleView(false);
                },
              ),
            ],
          ),
        ),
      ),
      body: BlocConsumer<ToDoLogic, ToDoState>(
        listener: (context,state){
          if(state is RemoveState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                    "Task Removed",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2)
              ),
            );
          }
          if(state is TaskCheckedState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 2),
                content: Text(
                  "Checkbox is changed",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.grey,
              ),
            );
          }
        },
        builder: (context,state){
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  AppColor.backgroundDark!,
                  AppColor.backgroundPurple!,
                  AppColor.backgroundBlack!,
                ],
              ),
            ),
            child: Padding(
              padding: AppPadding.pagePadding,
              child: SafeArea(
                child: Column(
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'on.time',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30.sp,
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            return IconButton(
                              onPressed: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                              icon: const Icon(Icons.more_vert, color: Colors.white),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    Expanded(
                          child: Column(
                            children: [
                              // Toggle Buttons
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xff3C1F7B),
                                ),
                                height: 50,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  child: ToggleButtons(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    selectedColor: Colors.white,
                                    fillColor: Color(0xff272430),
                                    color: Colors.white,
                                    constraints: BoxConstraints(minWidth: 120, minHeight: 50),
                                    textStyle: TextStyle(fontSize: 18.sp),
                                    children: [
                                      Text('Schedule'),
                                      Text('Note'),
                                    ],
                                    onPressed: (int index) {
                                      context.read<ToDoLogic>().toggleView(index == 0);
                                    },
                                    isSelected: [
                                      context.read<ToDoLogic>().isScheduleSelected,
                                      ! context.read<ToDoLogic>().isScheduleSelected
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),

                              if (context.read<ToDoLogic>().isScheduleSelected) ...[
                                TableCalendar(
                                  firstDay: DateTime.utc(2020, 1, 1),
                                  lastDay: DateTime.utc(2030, 12, 31),
                                  focusedDay:  context.read<ToDoLogic>().focusedDay,
                                  selectedDayPredicate: (day) =>
                                      isSameDay( context.read<ToDoLogic>().selectedDay, day),
                                  onDaySelected: (selectedDay, focusedDay) {
                                    context.read<ToDoLogic>().selectDay(selectedDay);
                                  },
                                  headerStyle: HeaderStyle(
                                    titleTextStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    formatButtonVisible: false,
                                    leftChevronIcon:
                                    Icon(Icons.chevron_left, color: Colors.white),
                                    rightChevronIcon:
                                    Icon(Icons.chevron_right, color: Colors.white),
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
                                    todayDecoration: BoxDecoration(
                                      color: Color(0xff7E64FF),
                                      shape: BoxShape.circle,
                                    ),
                                    todayTextStyle: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.bold),
                                    selectedDecoration: BoxDecoration(
                                      color: Color(0xff7E64FF),
                                      shape: BoxShape.circle,
                                    ),
                                    selectedTextStyle: AppColor.whiteText,
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.topLeft,
                                  child:Text('Schedule',style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white
                                  ),),
                                ),

                                SizedBox(height: 20.h,),
                                Expanded(child:
                                ListView.builder(
                                  itemCount: context.read<ToDoLogic>().tasks.length,
                                  itemBuilder: (context, index) {
                                    final sortedTasks = List.from(context.read<ToDoLogic>().tasks)
                                      ..sort((a, b) => a.time.compareTo(b.time));
                                    final task = sortedTasks[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: ScheduleCard(
                                        day: task.time.day.toString(),
                                        title: task.text,
                                        time: DateFormat('EEEE, yyyy-MM-dd').format(task.time),
                                        isChecked: task.isTake,
                                        onChanged: (newValue) {
                                          context.read<ToDoLogic>().checkTask(index, newValue);
                                        },
                                      ),
                                    );
                                  },
                                ))

                              ]
                              else ...[
                                Expanded(
                                  child: ListView.builder(
                                    itemCount:  context.read<ToDoLogic>().tasks.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 10.h),
                                        padding: AppPadding.cardPadding,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff7E64FF),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              value:  context.read<ToDoLogic>().tasks[index].isTake,
                                              onChanged: (newValue) {
                                                context.read<ToDoLogic>().checkTask(index, newValue!);
                                              },
                                              activeColor: Colors.white,
                                              checkColor: Colors.black,
                                            ),
                                            SizedBox(width: 10.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    context.read<ToDoLogic>().tasks[index].text,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.sp,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  Text(
                                                    DateFormat('yyyy-MM-dd – kk:mm').format(context.read<ToDoLogic>().tasks[index].time),
                                                    style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.delete, color: Colors.red),
                                              onPressed: () {
                                                context.read<ToDoLogic>().removeTask(index);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (c) => NoteScreen(),
                                      ),
                                    );
                                  },
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0.w),
                                      child: Container(
                                        width: 50.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: Color(0xff7E64FF),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: const Icon(Icons.add,
                                            color: Colors.white, size: 35),
                                      ),
                                    ),
                                  ),
                                )
                              ]
                            ],
                          ),
                        )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
