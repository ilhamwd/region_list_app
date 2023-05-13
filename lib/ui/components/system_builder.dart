import 'package:flutter/widgets.dart';
import 'package:region_list_app/system/system.dart';

class SystemBuilder extends StatefulWidget {
  const SystemBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, System system) builder;

  @override
  State<SystemBuilder> createState() => _SystemBuilderState();
}

class _SystemBuilderState extends State<SystemBuilder> {
  late System system;

  @override
  void initState() {
    super.initState();

    system = System();
  }

  @override
  Widget build(BuildContext context) {
    return SystemInheritedWidget(
        system: system, child: widget.builder(context, system));
  }
}

class SystemInheritedWidget extends InheritedWidget {
  final System system;

  const SystemInheritedWidget(
      {super.key, required super.child, required this.system});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
