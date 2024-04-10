import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:register_email_verification/utility/date_helper.dart';

class VerifyRegisterPage extends StatelessWidget {
  final String name;
  final String email;
  final String date;
  final DateHelper dateHelper = DateHelper();
  VerifyRegisterPage(
      {super.key, required this.name, required this.email, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.blue,  Color.fromARGB(255, 12, 113, 160)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 120, bottom: 50),
          child: Card(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/phone_success.png",
                    width: 150,
                    height: 200,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Register ",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("Success!",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
                      
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        Text(name, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                        const Divider(color: Colors.white, thickness: 2,indent: 5, endIndent: 5,),
                        Text(email, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                        const Divider(color: Colors.white, thickness: 2,indent: 5, endIndent: 5,),
                        Text(dateHelper.convertToDateFormat(DateTime.parse(date)), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                      ]),
                    ),
                  ),
                 
                  // Navigator.of(context).pop();
                  TextButton(child: const Text("Back to Register", style: TextStyle(
                    decoration: TextDecoration.underline,
                  )), onPressed: (){
                    Navigator.of(context).pop();
                  },)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
