import 'package:flutter/material.dart';
import 'package:region_list_app/system/system.dart';

class UIController {
  final BuildContext context;
  final void Function() refreshCallback;
  late System system;

  UIController(this.context, this.refreshCallback) {
    system = System.of(context);
  }

  void setState(void Function() callback) {
    callback();
    refreshCallback();
  }

  void initState() {}

  void dispose() {}
}
