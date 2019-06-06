import 'package:flutter/material.dart';
import 'package:movie/ui/main_page.dart';
import 'package:movie/message_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(LeeApp());
}

class LeeApp extends StatefulWidget {
  @override
  _LeeAppState createState() => _LeeAppState();
}

class _LeeAppState extends State<LeeApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lee',
      theme: ThemeData(
        primaryColor: const Color(0xFF1C306D),
        accentColor: const Color(0xFFFFAD32),
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: const MainPage(),
      supportedLocales: [
        const Locale('en', ''),
        const Locale('fi', ''),
        const Locale('zh', ''),
      ],
      localizationsDelegates: [
        const LEELocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}

