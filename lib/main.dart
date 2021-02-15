import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_bluestack/pages/dashboard/dashbaordscreen.dart';
import 'package:flutter_app_bluestack/pages/login/loginscreen.dart';
import 'package:flutter_app_bluestack/provider/home_provider.dart';
import 'package:flutter_app_bluestack/provider/language_provider.dart';
import 'package:flutter_app_bluestack/provider/theme_provider.dart';
import 'package:flutter_app_bluestack/utils/memory_management.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //for check life cycle
  WidgetsFlutterBinding.ensureInitialized();
  await MemoryManagement.init(); //initialize the shared preference once
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
      /*
      * MultiProvider for top services that do not depends on any runtime values
      * such as user uid/email.
       */
      MultiProvider(
    providers: [
      ChangeNotifierProvider<HomeProvider>(
        create: (context) => HomeProvider(),
      ),
      ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider()),
      ChangeNotifierProvider<LanguageProvider>(
        create: (context) => LanguageProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var isLogedIn = MemoryManagement.getLoginStatus() ?? false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => (isLogedIn) ? DashboardScreen() : LoginScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/home': (context) => DashboardScreen(),
      },
    );
  }
}
