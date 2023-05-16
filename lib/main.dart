import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:region_list_app/system/system.dart';
import 'package:region_list_app/ui/components/navbar.dart';
import 'package:region_list_app/ui/components/screen/home_screen.dart';
import 'package:region_list_app/ui/components/screen/splash_screen.dart';
import 'package:region_list_app/ui/components/screen/web_home_screen.dart';
import 'package:region_list_app/ui/components/system_builder.dart';

void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return SystemBuilder(builder: (context, system) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: kIsWeb
                    ? ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))
                    : ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        elevation: 10)),
            iconTheme: const IconThemeData(color: Color(0xFF555555)),
            inputDecorationTheme: InputDecorationTheme(
              errorStyle: kIsWeb
                  ? null
                  : const TextStyle(color: Colors.white, fontSize: 13),
              fillColor: Colors.white,
              filled: !kIsWeb,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: kIsWeb
                      ? const BorderSide(color: Color(0xFFDDDDDD))
                      : BorderSide.none),
            )),
        home: const App(),
      );
    });
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !kIsWeb
          ? null
          : const PreferredSize(
              preferredSize: Size(double.infinity, 100), child: Navbar()),
      body: FutureBuilder<System>(
          future: System.of(context).init(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SplashScreen();
            }

            return kIsWeb ? const WebHomeScreen() : const HomeScreen();
          }),
    );
  }
}
