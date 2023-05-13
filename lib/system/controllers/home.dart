// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:region_list_app/classes/ui_controller.dart';
import 'package:region_list_app/system/models/region.dart';
import 'package:region_list_app/system/repository/region.dart';

class HomeController extends UIController {
  HomeController(super.context, super.refreshCallback);

  // Repository
  late RegionRepository repository;

  RegionsModel? regionsData;

  Future<void> getRegionsData() async {
    regionsData = await repository.getRegions();

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

  @override
  void initState() {
    repository = RegionRepository(system);

    getRegionsData();
  }
}
