import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'providers/app_state.dart';
import 'providers/auth_state.dart';
import '../screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        // List of providers to update/use state
        providers: [
          ChangeNotifierProvider(create: (_) => AppState()),
          ChangeNotifierProvider(create: (_) => Auth()),
        ],
        child: MaterialApp(
          title: 'Twitter Clone',
          // Custom theme that overrides/extends default theme
          theme: ThemeData(
            primaryColor: Colors.blue,
            primaryColorDark: Colors.black,
            primaryColorLight: Colors.grey,
            textTheme: const TextTheme(
              headline4: TextStyle(fontSize: 27.5, fontWeight: FontWeight.w500),
              headline6: TextStyle(fontSize: 20),
              subtitle1: TextStyle(fontSize: 20),
              bodyText1: TextStyle(fontSize: 25),
              bodyText2: TextStyle(fontSize: 18),
              button: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
          // Home page defined by HomeScreen widget
          home: const HomeScreen(),
        ));
  }
}
