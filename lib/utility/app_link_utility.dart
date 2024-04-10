

import 'package:flutter/material.dart';
import 'package:register_email_verification/pages/verify_register_page.dart';
import 'package:uni_links/uni_links.dart';

class AppLinkUtility{
  initialRouting(BuildContext context) async{

      final uri = await getInitialUri();
      var name = uri?.queryParameters['name'];
      var email = uri?.queryParameters['email'];
      var date = uri?.queryParameters['date'];
      var page = uri?.queryParameters['page'];
      if(page == 'emailVerification'){
        if(context.mounted) Navigator.of(context).push(MaterialPageRoute(builder: (context) => VerifyRegisterPage(name: name!, email: email!, date: date!,)));
      } 
  }
}