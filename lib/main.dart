import 'package:flutter/material.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:region_list_app/system/system.dart';
import 'package:region_list_app/ui/components/screen/home_screen.dart';
import 'package:region_list_app/ui/components/screen/splash_screen.dart';
import 'package:region_list_app/ui/components/system_builder.dart';

void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return SystemBuilder(builder: (context, system) {
      return FlutterWebFrame(
          maximumSize: const Size(720, double.infinity),
          backgroundColor: Colors.blue,
          builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          elevation: 10)),
                  inputDecorationTheme: InputDecorationTheme(
                    errorStyle:
                        const TextStyle(color: Colors.white, fontSize: 13),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  )),
              home: const App(),
            );
          });
    });
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<System>(
          future: System.of(context).init(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SplashScreen();
            }

            return const HomeScreen();
          }),
    );
  }
}
