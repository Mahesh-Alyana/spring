import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spring/providers/profile_provider.dart';
import 'package:spring/providers/transaction_providers.dart';
import 'package:spring/screens/auth/login_screen.dart';
import 'package:spring/screens/auth/signup_screen.dart';
import 'package:spring/screens/splashScreen.dart';
import 'package:spring/screens/users/edit_profile_screen.dart';
import 'package:spring/screens/users/home_screen.dart';
import 'package:spring/screens/users/payment_details.dart';
import 'package:spring/screens/users/payment_screen.dart';
import 'package:spring/screens/vendor/payment_success_screen.dart';
import 'package:spring/screens/users/profile_screen.dart';
import 'package:spring/screens/users/settings_screen.dart';
import 'package:spring/screens/users/transaction_history.dart';
import 'package:spring/screens/vendor/home_screen.dart';
import 'package:spring/screens/vendor/scan_screen.dart';
import 'package:uni_links/uni_links.dart';

import 'api/auth_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  String deepLinkURL = '';
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    // ignore: deprecated_member_use
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ]);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProfileProvider()),
        ChangeNotifierProvider.value(value: TransactionListProvider()),
        ChangeNotifierProvider.value(value: TransactionProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
