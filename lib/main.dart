import 'dart:async';

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:register_email_verification/component/custom_alert_dialog.dart';
import 'package:register_email_verification/component/custom_button.dart';
import 'package:register_email_verification/component/date_picker_component.dart';
import 'package:register_email_verification/component/date_picker_field.dart';
import 'package:register_email_verification/component/text_form_field.dart';
import 'package:register_email_verification/exception/send_email_exception.dart';
import 'package:register_email_verification/pages/verify_register_page.dart';
import 'package:register_email_verification/service/email_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:form_validator/form_validator.dart';
import 'package:mailer/mailer.dart';
import 'package:register_email_verification/utility/app_link_utility.dart';
import 'package:uni_links/uni_links.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _formKey = GlobalKey<FormState>();

  DateTime? dt;
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final datePickerComponent = DatePickerComponent();
  final customAlertDialog = CustomAlertDialog();
  final emailService = EmailService();
  final emailValidator = ValidationBuilder()
      .email("Please input correct email format")
      .required()
      .build();

  String? validateEmails(String? s) {
    if (s == "") {
      return null;
    }
    var emails = s!.split(",");
    for (String email in emails) {
      String? checkResult = emailValidator(email.trim());
      if (checkResult != null) {
        return checkResult;
      }
    }
    return null;
  }

  AppLinkUtility appLinkUtility = AppLinkUtility();
  StreamSubscription? sub;

  Future<void> initUniLinks() async {
    sub = linkStream.listen((String? link) {
      // Parse the link and warn the user, if it is not correct
      var uri = Uri.parse(link!);
      var name = uri.queryParameters['name'];
      var email = uri.queryParameters['email'];
      var date = uri.queryParameters['date'];
      var page = uri.queryParameters['page'];
      if (page == 'emailVerification') {
        if (context.mounted)
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VerifyRegisterPage(
                    name: name!,
                    email: email!,
                    date: date!,
                  )));
      }
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });
  }
  // https://gegeh.wadawwa.my.id?page=register&id=tegar

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appLinkUtility.initialRouting(context);
    initUniLinks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(children: [
              const Text("REGISTER FORM",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue)),
              const SizedBox(
                height: 30,
              ),
              // TextFormF(controller: fromEmail, placeholder: "Input From Email", validator: ValidationBuilder().email("Please input correct email format").build(), maxLines: 1),
              TextFormF(
                  controller: name,
                  placeholder: "Input Name",
                  validator:
                      ValidationBuilder().minLength(1).required().build(),
                  maxLines: 1),
              TextFormF(
                  controller: email,
                  placeholder: "Input Email",
                  validator: emailValidator,
                  maxLines: 1),
              TextFormF(
                  controller: password,
                  placeholder: "Input Password",
                  obsecureText: true,
                  validator:
                      ValidationBuilder().minLength(6).required().build(),
                  maxLines: 1),
              DatePickerField(
                dt: dt,
                onClick: () async {
                  
                    DateTime? date =
                        await datePickerComponent.showDatePicker(context, dt);
                    if (date != null) {
                      setState(() {
                        dt = date;
                      });
                    }
                  
                },
              ),

              const SizedBox(
                height: 30,
              ),
              CustomButton(
                  backgroundColor: Colors.blue,
                  fontSize: 15,
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    customAlertDialog.confirmationDialog(
                        ctx: context,
                        title: "Alert !",
                        description: "Make sure the data is correct",
                        yesFunction: () async {
                          try {
                            if (_formKey.currentState!.validate() &&
                                dt != null) {
                              Loader.show(context,
                                  progressIndicator:
                                      const CircularProgressIndicator());

                              emailService.setName(name.value.text);
                              emailService.setEmail(email.value.text);
                              emailService.setDate(dt.toString());
                              emailService.setPassword(password.value.text);

                              SendReport sr = await emailService.sendEmail();

                              if (context.mounted &&
                                  sr.messageSendingEnd.toString() != "") {
                                Loader.hide();
                                customAlertDialog.showMessageDialog(
                                    ctx: context,
                                    title: "Success",
                                    description:
                                        "Email Verification link has already been sent, plase check your email");
                                name.clear();
                                email.clear();
                                password.clear();
                                setState(() {
                                  dt = null;
                                });
                              }
                            } else {
                              Loader.hide();
                              throw SendEmailFormException(
                                  "Please check the input format");
                            }
                          } on MailerException catch (e) {
                            if (context.mounted) {
                              Loader.hide();
                              customAlertDialog.showMessageDialog(
                                  ctx: context,
                                  title: "Error (When sending email)",
                                  description: e.message);
                            }
                          } on SendEmailFormException catch (e) {
                            if (context.mounted) {
                              Loader.hide();
                              customAlertDialog.showMessageDialog(
                                  ctx: context,
                                  title: "Error (On form input)",
                                  description: e.message);
                            }
                          }
                        });
                  },
                  buttonText: "REGISTER",)
            ]),
          ),
        ),
      ),
    );
  }
}
