// Kategori, provinsi, kecamatan, kode pos, rt, rw, negara, kota, kelurahan, nama jalanan, nomor telepon, active
class RegionModel {
  late String id,
      kategori,
      negara,
      provinsi,
      kota,
      kodePos,
      kecamatan,
      kelurahan,
      rt,
      rw,
      namaJalan;
  late bool isActive;

  RegionModel.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    kategori = data['kategori'];
    negara = data['negara'];
    provinsi = data['provinsi'];
    kota = data['kota'];
    kodePos = data['kode_pos'];
    kecamatan = data['kecamatan'];
    kelurahan = data['kelurahan'];
    rt = data['rt'];
    rw = data['rw'];
    namaJalan = data['nama_jalan'];
    isActive = data['is_active'] == "1";
  }
}

class RegionsModel {
  final data = <RegionModel>[];

  RegionsModel.fromJson(List<dynamic> data) {
    for (final region in data) {
      this.data.add(RegionModel.fromJson(region));
    }
  }
}
