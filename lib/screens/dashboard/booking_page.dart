import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_wellness/screens/dashboard/appointment.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../components/button.dart';
import '../../components/custom_appbar.dart';
import '../../utils/config.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  CalendarFormat _formate = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: const CustomAppBar(
        appTitle: 'Appointment',
        icon: FaIcon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                _tableCalendar(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Config.widthSize! * 0.02,
                      vertical: Config.heightSize! * 0.05),
                  child: Center(
                    child: Text(
                      "Select Counseling Time",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Config.widthSize! * 0.05,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          _isWeekend
              ? SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Config.widthSize! * 0.02,
                        vertical: Config.heightSize! * 0.04),
                    alignment: Alignment.center,
                    child: Text(
                      "Weekend is not available, please select another Date",
                      style: TextStyle(
                        fontSize: Config.widthSize! * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              : SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                            _timeSelected = true;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(Config.widthSize! * 0.01),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: _currentIndex == index
                                      ? Colors.white
                                      : Colors.black),
                              borderRadius: BorderRadius.circular(
                                  Config.widthSize! * 0.05),
                              color: _currentIndex == index
                                  ? Config.primaryColor
                                  : null),
                          alignment: Alignment.center,
                          child: Text(
                            "${index + 9}:00${index + 9 > 11 ? "PM" : "AM"}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Config.widthSize! * 0.045,
                              color:
                                  _currentIndex == index ? Colors.white : null,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 8,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.5,
                  ),
                ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Config.widthSize! * 0.02,
                  vertical: Config.heightSize! * 0.1),
              child: Button(
                width: double.infinity,
                title: "Make Appointment",
                onPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return AppointmentPage();
                    },
                  ));
                },
                disble: _timeSelected && _dateSelected ? false : true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2024, 12, 31),
      calendarFormat: _formate,
      currentDay: _currentDay,
      rowHeight: Config.heightSize! * 0.06,
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Config.primaryColor,
          shape: BoxShape.circle,
        ),
      ),
      availableCalendarFormats: {CalendarFormat.month: "Month"},
      onFormatChanged: (format) {
        setState(() {
          _formate = format;
        });
      },
      onDaySelected: ((selectDay, focusDay) {
        setState(() {
          _currentDay = selectDay;
          _focusDay = focusDay;
          _dateSelected = true;
          if (selectDay.weekday == 6 || selectDay.weekday == 7) {
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
          }
        });
      }),
    );
  }
}
