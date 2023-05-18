import 'package:employees_book/PROVIDER/labourListProvider.dart';
import 'package:employees_book/PROVIDER/mainProvider.dart';
import 'package:employees_book/SCREEN/homeScreen.dart';
import 'package:employees_book/SCREEN/labourRegister.dart';
import 'package:employees_book/SCREEN/loginScreen.dart';
import 'package:employees_book/SCREEN/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final keyApplicationId = '4LWXiYYt0DSuyEvz7537yOgZ7DLqiz2E1x3L3IZd';
  final keyClientKey = 'd94lhi52cVcoECd0l28L4CnMdyxjpRfFwPq884Ih';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider()),
        ChangeNotifierProvider(create: (context) => LabourListProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/splashScreen',
        routes: {
          '/splashScreen': (context) => const SplashScreen(),
          '/loginScreen': (context) => const LoginScreen(),
          '/homeScreen': (context) => const HomeScreen(),
          '/labourRegister': (context) => const LabourRegister(),
        },
      ),
    );
  }
}
