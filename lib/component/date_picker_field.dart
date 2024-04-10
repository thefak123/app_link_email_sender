import 'package:flutter/material.dart';
import 'package:register_email_verification/utility/date_helper.dart';

class DatePickerField extends StatefulWidget {
  DateTime? dt;
  Function() onClick;
  DatePickerField({super.key, required this.dt, required this.onClick});

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final dateHelper = DateHelper();
  @override
  Widget build(BuildContext context) {
    
    return TextFormField(
      readOnly: true,
      onTap: widget.onClick,
      decoration:  InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.dt == null ? 'Select birth date' : dateHelper.convertToDateFormat(widget.dt!),
      ),
     
    );
  }
}
