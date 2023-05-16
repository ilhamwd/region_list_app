import 'package:flutter/material.dart';
import 'package:region_list_app/system/models/region.dart';

class RegionDataTableSource extends DataTableSource {
  final RegionsModel data;
  final void Function(RegionModel data) onEditClicked, onDeleteClicked;

  RegionDataTableSource(this.data, this.onEditClicked, this.onDeleteClicked);

  @override
  DataRow? getRow(int index) {
    final region = data.data[index];

    return DataRow(cells: [
      ...[
        region.namaJalan,
        region.kecamatan,
        region.kelurahan,
        region.kota,
        region.provinsi,
        region.negara,
        region.kategori
      ].map((e) => DataCell(Text(e))),
      DataCell(Text(region.isActive ? "Active" : "Inactive")),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () => onEditClicked(region),
              icon: const Icon(Icons.edit, color: Colors.blue)),
          const SizedBox(width: 10),
          IconButton(
              onPressed: () => onDeleteClicked(region),
              icon: const Icon(Icons.delete, color: Colors.red)),
        ],
      ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.data.length;

  @override
  int get selectedRowCount => 0;
}
