import 'package:fazit/firebase_options.dart';
import 'package:fazit/landingpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await initialization();
  runApp(ProviderScope(child: MyApp()));
}

initialization() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox("Books");
}

GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey();

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization =
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container(color: Colors.amber);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            navigatorKey: rootNavigatorKey,
            routes: {"/LandingPage": (context) => const LandingPage()},
            debugShowCheckedModeBanner: false,
            title: 'Fazit',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const LandingPage(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const MaterialApp(
            home: Scaffold(
          body: SizedBox(
              height: 30,
              width: 50,
              child: Image(image: AssetImage('assets/images/fazit_logo.png'))),
        ));
      },
    );
  }
}
