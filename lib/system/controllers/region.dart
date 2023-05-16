// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:region_list_app/classes/ui_controller.dart';
import 'package:region_list_app/system/models/common_address.dart';
import 'package:region_list_app/system/models/region.dart';
import 'package:region_list_app/system/repository/region.dart';

class RegionController extends UIController {
  final RegionModel? data;

  RegionController(super.context, super.refreshCallback, {this.data});

  // Repository
  late RegionRepository repository;

  // Controllers
  final formKey = GlobalKey<FormState>();
  late TextEditingController rtController,
      rwController,
      kodePosController,
      namaJalanController;
  String? kategori, negara = "Indonesia", provinsi, kota, kecamatan, kelurahan;
  bool isActive = true;

  // States
  bool hasBeenSubmittedBefore = false,
      isSubmitting = false,
      isLoadingData = true;

  // Dropdown items
  List<DropdownMenuItem<String>> negaraList = [
        const DropdownMenuItem(value: "Indonesia", child: Text("Indonesia"))
      ],
      provinsiList = [],
      kotaList = [],
      kecamatanList = [],
      kelurahanList = [],
      kategoriList = [
        "KTP",
        "SIM",
      ].map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList();

  Future<void> selectProvinsi(String? provinceId) async {
    if (provinceId == null) return;

    setState(() {
      provinsi = provinceId;
      kota = null;
      kecamatan = null;
      kelurahan = null;
    });

    kotaList = (await repository.getCity(getAddressId(provinceId)))
        .data
        .map((e) => DropdownMenuItem<String>(
            value: getAddressValue(e), child: Text(e.name)))
        .toList();

    kecamatanList.clear();
    kelurahanList.clear();

    setState(() {});
  }

  Future<void> selectKota(String? cityId) async {
    if (cityId == null) return;

    setState(() {
      kota = cityId;
      kecamatan = null;
      kelurahan = null;
    });

    kecamatanList = (await repository.getDistrict(getAddressId(cityId)))
        .data
        .map((e) => DropdownMenuItem<String>(
            value: getAddressValue(e), child: Text(e.name)))
        .toList();

    kelurahanList.clear();

    setState(() {});
  }

  Future<void> selectKecamatan(String? districtId) async {
    if (districtId == null) return;

    setState(() {
      kecamatan = districtId;
      kelurahan = null;
    });

    kelurahanList = (await repository.getWard(getAddressId(districtId)))
        .data
        .map((e) => DropdownMenuItem<String>(
            value: getAddressValue(e), child: Text(e.name)))
        .toList();

    setState(() {});
  }

  Future<void> submit() async {
    hasBeenSubmittedBefore = true;

    if (!formKey.currentState!.validate()) return;

    setState(() {
      isSubmitting = true;
    });

    try {
      if (data == null) {
        await repository.saveRegion(this);
      } else {
        await repository.updateRegion(this);
      }

      if (!kIsWeb) Navigator.pop(context, true);
    } catch (e) {
      setState(() {
        isSubmitting = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }

  // Lifecycle

  @override
  void dispose() {
    rtController.dispose();
    rwController.dispose();
    namaJalanController.dispose();
    kodePosController.dispose();
  }

  @override
  void initState() {
    repository = RegionRepository(system);

    rtController = TextEditingController(text: data?.rt);
    rwController = TextEditingController(text: data?.rw);
    namaJalanController = TextEditingController(text: data?.namaJalan);
    kodePosController = TextEditingController(text: data?.kodePos);

    repository.getProvince().then((value) {
      provinsiList = value.data
          .map((e) => DropdownMenuItem<String>(
              value: getAddressValue(e), child: Text(e.name)))
          .toList();

      if (data != null) return getDetailData();

      setState(() {});
    });
  }

  // Helpers

  Future<void> getDetailData() async {
    kategori = data!.kategori;
    negara = data!.negara;
    kodePosController.text = data!.kodePos;
    namaJalanController.text = data!.namaJalan;
    rtController.text = data!.rt;
    rwController.text = data!.rw;
    isActive = data!.isActive;

    // Restore address
    provinsi = provinsiList
        .where((element) {
          return getAddressName(element.value!) == data!.provinsi;
        })
        .first
        .value;

    await selectProvinsi(provinsi);

    kota = kotaList
        .where((element) {
          return getAddressName(element.value!) == data!.kota;
        })
        .first
        .value;

    await selectKota(kota);

    kecamatan = kecamatanList
        .where((element) {
          return getAddressName(element.value!) == data!.kecamatan;
        })
        .first
        .value;

    await selectKecamatan(kecamatan);

    kelurahan = kelurahanList
        .where((element) {
          return getAddressName(element.value!) == data!.kelurahan;
        })
        .first
        .value;

    setState(() {
      isLoadingData = false;
    });
  }

  String getAddressValue(CommonAddressModel data) => "${data.id}>>${data.name}";

  String getAddressId(String address) {
    return address.split(">>").first;
  }

  String getAddressName(String address) {
    return address.split(">>").last;
  }

  Map<String, dynamic> get payload {
    return {
      "kategori": kategori,
      "negara": negara,
      "provinsi": provinsi,
      "kota": kota,
      "kecamatan": kecamatan,
      "kelurahan": kelurahan,
      "kode_pos": kodePosController.text,
      "nama_jalan": namaJalanController.text,
      "rt": rtController.text,
      "rw": rwController.text,
      "is_active": isActive ? 1 : 0
    }.map((key, value) {
      try {
        if (value is! String) throw 1;

        return MapEntry(key, getAddressName(value));
      } catch (e) {
        return MapEntry(key, value);
      }
    });
  }
}
