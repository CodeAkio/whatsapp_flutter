import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/modules/login/login_page.dart';
import 'package:whatsapp_flutter/shared/themes/app_colors.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: AppColors.primary,
          colorScheme: Theme.of(context)
              .colorScheme
              .copyWith(secondary: AppColors.secondary)),
      title: 'WhatsApp',
      home: const LoginPage(),
    );
  }
}
