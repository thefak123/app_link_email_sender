import 'package:flutter/material.dart';
import 'package:date_picker_plus/date_picker_plus.dart';

class DatePickerComponent {
    Future<DateTime?> showDatePicker(BuildContext context, DateTime? selectedDate) async{
        DateTime? dt = await showDatePickerDialog(
            context: context,
            minDate: DateTime(1950, 1, 1),
            maxDate: DateTime(2020, 12, 31),
            selectedDate: selectedDate,
        );
        return dt;
    }
}