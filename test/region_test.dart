import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:region_list_app/system/repository/region.dart';
import 'package:region_list_app/system/system.dart';

void main() async {
  final system = await System().init();
  final repository = RegionRepository(system);

  // Get regions
  test("Get regions", () async {
    final regions = await repository.getRegions();

    log("Got ${regions.data.length} regions data👍");
  });
}
