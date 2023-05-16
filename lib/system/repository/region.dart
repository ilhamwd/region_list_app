import 'package:region_list_app/system/config.dart';
import 'package:region_list_app/system/controllers/region.dart';
import 'package:region_list_app/system/models/common_address.dart';
import 'package:region_list_app/system/models/region.dart';
import 'package:region_list_app/system/use_cases/region.dart';

class RegionRepository extends RegionUseCases {
  RegionRepository(super.system);

  @override
  Future<CommonAddressesModel> getCity(String provinceId) async {
    final req = await system.dio
        .get("${Config.emsifaBaseUrl}regencies/$provinceId.json");

    return CommonAddressesModel.fromJson(req.data);
  }

  @override
  Future<CommonAddressesModel> getDistrict(String cityId) async {
    final req =
        await system.dio.get("${Config.emsifaBaseUrl}districts/$cityId.json");

    return CommonAddressesModel.fromJson(req.data);
  }

  @override
  Future<CommonAddressesModel> getProvince() async {
    final req = await system.dio.get("${Config.emsifaBaseUrl}provinces.json");

    return CommonAddressesModel.fromJson(req.data);
  }

  @override
  Future<CommonAddressesModel> getWard(String districtId) async {
    final req = await system.dio
        .get("${Config.emsifaBaseUrl}villages/$districtId.json");

    return CommonAddressesModel.fromJson(req.data);
  }

  @override
  Future<void> saveRegion(RegionController controller) async {
    await system.dio
        .post("${Config.baseUrl}submit.php", data: controller.payload);
  }

  @override
  Future<void> deleteRegion(String id) async {
    await system.dio.post("${Config.baseUrl}delete.php?id=$id");
  }

  @override
  Future<RegionsModel> getRegions() async {
    final data = await system.dio.get("${Config.baseUrl}get.php");

    return RegionsModel.fromJson(data.data);
  }

  @override
  Future<void> updateRegion(RegionController controller) async {
    await system.dio.post(
        "${Config.baseUrl}update.php?id=${controller.data!.id}",
        data: controller.payload);
  }
}
