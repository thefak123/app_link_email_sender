import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final double fontSize;
  final Color fontColor;
  final Color backgroundColor;
  final Function() onPressed;
  const CustomButton({required this.fontSize, this.fontColor = Colors.white, this.backgroundColor = Colors.black, 
  required this.onPressed, required this.buttonText, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            style: ElevatedButton.styleFrom(textStyle:  TextStyle(fontSize: fontSize, color: fontColor), backgroundColor: backgroundColor),
            onPressed: onPressed,
            child: Text(buttonText),
          );
  }
}