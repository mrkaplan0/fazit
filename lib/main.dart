import 'package:fazit/contrast.dart';
import 'package:fazit/firebase_options.dart';
import 'package:fazit/landingpage.dart';
import 'package:fazit/providers/providers.dart';
import 'package:fazit/widgets/animated_progr_indicator.dart';
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
  await Hive.openBox("books");
  await Hive.openBox("myTheme");
  await Hive.openBox("favorites");
}

GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey();

class MyApp extends ConsumerWidget {
  final Future<FirebaseApp> _initialization =
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
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
              scaffoldBackgroundColor: scaffoldBackgroundColor,
              appBarTheme:
                  const AppBarTheme(backgroundColor: appBarBackgroundColor),
              colorScheme:
                  ColorScheme.fromSeed(seedColor: const Color(0xFFF56D91)),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  brightness: Brightness.dark,
                  seedColor: const Color(0xFFF56D91)),
              useMaterial3: true,
            ),
            themeMode: themeMode,
            home: const LandingPage(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const MaterialApp(
            home: Scaffold(
          body: ContainerProgressIndicator(),
        ));
      },
    );
  }
}
