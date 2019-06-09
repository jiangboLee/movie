import 'package:flutter/material.dart';
import 'package:movie/ui/main_page.dart';
import 'package:movie/message_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:core/core.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

Future<void> main() async {

  final prefs = await SharedPreferences.getInstance();
  final keyValueStore = FlutterKeyValueStore(prefs);
  final store = createStore(Client(), keyValueStore);

  runApp(LeeApp(store: store,));
}

class LeeApp extends StatefulWidget {

  final Store<AppState> store;

  const LeeApp({Key key, this.store}) : super(key: key);

  @override
  _LeeAppState createState() => _LeeAppState();
}

class _LeeAppState extends State<LeeApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.store.dispatch(InitAction());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
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
      ),
    );
  }
}

