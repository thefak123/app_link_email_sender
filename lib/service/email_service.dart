

import 'dart:ffi';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:register_email_verification/webite.dart';

class EmailService{
  late String name;
  late String email;
  late String password;
  late String date;

  
  void setEmail(String email){
    this.email = email;
  }
  void setPassword(String password){
    this.password = password;
  }

  void setName(String name){
    this.name = name;
  }

  void setDate(String date){
    this.date = date;
  }
  
  Future<SendReport> sendEmail() async{

      String username = 'hehe@wadawwa.my.id';
      String password = '@Mlbbunse123';
      
      final smtpServer = SmtpServer("mail.wadawwa.my.id", username:username, password: password);
  
      final websiteUtility = WebsiteUtility();
      // Create our message.
      final messageToSent = Message()
        ..from = Address(username, "Email Verification Service")
        ..recipients.add(email)
        ..subject = "Email Verification"
        ..html = websiteUtility.getEmailVerificationWebsite(name, email, date);
     
      
      return await send(messageToSent, smtpServer);
      
  }
}