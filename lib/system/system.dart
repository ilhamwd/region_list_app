import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:region_list_app/ui/components/system_builder.dart';

class System {
  static System of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<SystemInheritedWidget>()!
      .system;

  late Dio dio;

  Future<System> init() async {
    dio = Dio();

    return this;
  }
}
