// Can be used for province, city, district, and ward

class CommonAddressModel {
  late String id, name;

  CommonAddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class CommonAddressesModel {
  final List<CommonAddressModel> data = [];

  CommonAddressesModel.fromJson(List<dynamic> data) {
    for (final address in data) {
      this.data.add(CommonAddressModel.fromJson(address));
    }
  }
}
