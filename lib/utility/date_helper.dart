import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHelper{
  String convertToDateFormat(DateTime dt){
    int day = dt.day;
    
    int monthInt = dt.month;
    
    String month = DateFormat('MMMM').format(DateTime(0, monthInt));
    int year = dt.year;
    return "$day $month $year";
  }
}