import 'package:region_list_app/classes/repository.dart';
import 'package:region_list_app/system/controllers/region.dart';
import 'package:region_list_app/system/models/common_address.dart';
import 'package:region_list_app/system/models/region.dart';

abstract class RegionUseCases extends Repository {
  RegionUseCases(super.system);

  Future<CommonAddressesModel> getProvince();

  Future<CommonAddressesModel> getCity(String provinceId);

  Future<CommonAddressesModel> getDistrict(String cityId);

  Future<CommonAddressesModel> getWard(String districtId);

  Future<void> saveRegion(RegionController controller);

  Future<void> updateRegion(RegionController controller);

  Future<RegionsModel> getRegions();

  Future<void> deleteRegion(String id);
}
