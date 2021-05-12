import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWid extends StatefulWidget {
  final Function submitFn;

  DatePickerWid(this.submitFn);

  @override
  _DatePickerWidState createState() => _DatePickerWidState();
}

class _DatePickerWidState extends State<DatePickerWid> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    DateFormat.yMMMMd().format(selectedDate);

    widget.submitFn(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          return _selectDate(context);
        },
        child: Text('Pick a Date'));
  }
}
