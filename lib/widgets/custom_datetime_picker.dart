import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:noteworthy/widgets/custom_textbox_borderless.dart';

import '../styles.dart';
import 'package:flutter/material.dart';

class CustomDateTimePicker extends StatefulWidget {
  TextEditingController dateController;
  ValueSetter<DateTime> newDate;

  TextEditingController timeController;
  ValueSetter<TimeOfDay> newTime;

  CustomDateTimePicker({
    required this.dateController,
    required this.newDate,
    required this.timeController,
    required this.newTime,
  });

  @override
  _CustomDateTimePickerState createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
  DateTime? newDate;
  TimeOfDay? newTime;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            height: 50,
            width: width - 240,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              style: const TextStyle(fontSize: 18.0, fontFamily: defaultFont),
              autofocus: false,
              readOnly: true,
              controller: widget.dateController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[50],
                labelStyle: LabelStyle1,
                errorStyle: errorStyle,
                contentPadding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                prefixIcon: IconButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      initialDate: newDate ?? DateTime.now(),
                      lastDate: DateTime(2100),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: defaultColor,
                            buttonTheme: const ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                            colorScheme:
                                const ColorScheme.light(primary: defaultColor)
                                    .copyWith(secondary: defaultColor),
                          ),
                          child: child!,
                        );
                      },
                    ).then((value) {
                      setState(() {
                        widget.newDate(value!);
                        newDate = value;
                        widget.dateController.text =
                            DateFormat('yyyy-MM-dd').format(value).toString();
                      });
                    });
                  },
                  icon: Icon(
                    widget.dateController.text != ""
                        ? Icons.calendar_month_sharp
                        : Icons.calendar_today,
                    color: defaultColor,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            width: width - 270,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              style: const TextStyle(fontSize: 18.0, fontFamily: defaultFont),
              autofocus: false,
              readOnly: true,
              controller: widget.timeController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[50],
                labelStyle: LabelStyle1,
                errorStyle: errorStyle,
                contentPadding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                prefixIcon: IconButton(
                  onPressed: () async {
                    final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: defaultColor,
                            buttonTheme: const ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                            colorScheme:
                                const ColorScheme.light(primary: defaultColor)
                                    .copyWith(secondary: defaultColor),
                          ),
                          child: child!,
                        );
                      },
                    ).then((value) {
                      setState(() {
                        widget.newTime(value!);
                        newTime = value;
                        widget.timeController.text = value.format(context);
                        ;
                      });
                    });
                    ;
                  },
                  icon: Icon(
                    widget.timeController.text != ""
                        ? Icons.access_time_filled
                        : Icons.access_time,
                    color: defaultColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
