import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auksion_app/controllers/authcontroller.dart';
import 'package:auksion_app/views/screens/homepage.dart';
import 'package:auksion_app/views/screens/loginpage.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale("uz"),
        Locale("en"),
        Locale("ru"),
      ],
      path: 'resources/langs',
      startLocale: const Locale("en"),
      child: const Myapp(),
    ),
  );
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  final authcontroller = Authcontroller();

  bool isLogged = false;

  @override
  void initState() {
    authcontroller.checkLogin().then((value) {
      setState(() {
        isLogged = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      dark: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      initial: AdaptiveThemeMode.dark,
      builder: (light, dark) => MaterialApp(
        theme: light,
        darkTheme: dark,
        home: isLogged ? Homepage() : Loginpage(),
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
      ),
    );
  }
}
