// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:region_list_app/classes/region_data_table_source.dart';
import 'package:region_list_app/classes/ui_controller.dart';
import 'package:region_list_app/system/controllers/region.dart';
import 'package:region_list_app/system/models/region.dart';
import 'package:region_list_app/system/repository/region.dart';

class HomeController extends UIController {
  HomeController(super.context, super.refreshCallback);

  // Repository
  late RegionRepository repository;

  // Controllers
  late TabController webTabController;
  late ScrollController webScrollController;
  RegionController? regionController;

  RegionsModel? regionsData;
  RegionDataTableSource? regionsDataTableSource;
  final tabs = ["Alamat", "Keluarga", "Bahasa", "Penjamin Bayar"]
      .map((e) => Tab(text: e))
      .toList();

  Future<void> getRegionsData() async {
    regionsData = await repository.getRegions();
    regionsDataTableSource = RegionDataTableSource(
        regionsData!, webOnRegionEditClicked, webOnRegionDeleteClicked);

    setState(() {});
  }

  Future<void> deleteRegion(String id) async {
    setState(() {
      regionsData = null;
    });

    await repository.deleteRegion(id);
    await getRegionsData();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Region has been deleted successfully")));
  }

  void webOnFormCancelClicked() {
    regionController?.dispose();

    setState(() {
      regionController = null;
    });
  }

  void webOnFormSubmitClicked() async {
    if (!regionController!.formKey.currentState!.validate()) return;

    await regionController!.submit();
    regionController!.dispose();

    setState(() {
      regionsData = null;
      regionsDataTableSource = null;
      regionController = null;
    });

    getRegionsData();
  }

  void webOnRegionAddClicked() {
    setState(() {
      regionController = RegionController(context, super.refreshCallback)
        ..initState();
    });
  }

  void webOnRegionEditClicked(RegionModel data) {
    setState(() {
      regionController =
          RegionController(context, super.refreshCallback, data: data)
            ..initState();
    });
  }

  void webOnRegionDeleteClicked(RegionModel data) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Confirm"),
            content: const Text("Are you sure you want to delete this region?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    deleteRegion(data.id);
                  },
                  child:
                      const Text("Yes", style: TextStyle(color: Colors.red))),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No")),
            ],
          );
        });
  }

  @override
  void initState() {
    repository = RegionRepository(system);
    webScrollController = ScrollController();

    getRegionsData();
  }

  @override
  void dispose() {
    regionController?.dispose();
    webScrollController.dispose();
    webTabController.dispose();
  }
}
