import 'package:flutter/material.dart';
import 'package:region_list_app/system/controllers/region.dart';
import 'package:region_list_app/system/models/region.dart';
import 'package:region_list_app/ui/components/reusable/custom_button.dart';
import 'package:region_list_app/ui/components/screen/forms/region_form.dart';

class RegionDetailScreen extends StatefulWidget {
  const RegionDetailScreen(
      {super.key, required this.data, this.isEditable = false});

  final RegionModel data;
  final bool isEditable;

  @override
  State<RegionDetailScreen> createState() => _RegionDetailScreenState();
}

class _RegionDetailScreenState extends State<RegionDetailScreen> {
  late RegionController controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller =
        RegionController(context, () => setState(() {}), data: widget.data)
          ..initState();
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
                      Text("Region Detail",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .merge(const TextStyle(color: Colors.white))),
                    ],
                  ),
                  if (controller.isLoadingData)
                    const Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: CircularProgressIndicator(color: Colors.white),
                    ))
                  else
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        IgnorePointer(
                            ignoring: !widget.isEditable,
                            child: RegionForm(controller: controller)),
                        if (widget.isEditable)
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: CustomButton(
                                onPressed: controller.submit,
                                child: const Text("Update",
                                    textAlign: TextAlign.center)),
                          ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ));
  }
}
