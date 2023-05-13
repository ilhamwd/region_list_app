import 'package:flutter/material.dart';
import 'package:region_list_app/system/controllers/region.dart';
import 'package:region_list_app/ui/components/reusable/custom_button.dart';
import 'package:region_list_app/ui/components/screen/forms/region_form.dart';

class RegionAddScreen extends StatefulWidget {
  const RegionAddScreen({super.key});

  @override
  State<RegionAddScreen> createState() => _RegionAddScreenState();
}

class _RegionAddScreenState extends State<RegionAddScreen> {
  late final RegionController controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller = RegionController(context, () => setState(() {}))..initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const BackButton(color: Colors.white),
                      Text("Add Region",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .merge(const TextStyle(color: Colors.white))),
                    ],
                  ),
                  const SizedBox(height: 20),
                  RegionForm(controller: controller),
                  const SizedBox(height: 20),
                  CustomButton(
                      onPressed: controller.submit,
                      child: controller.isSubmitting
                          ? const CircularProgressIndicator()
                          : const Text("Submit", textAlign: TextAlign.center))
                ],
              ),
            ),
          ),
        ));
  }
}
