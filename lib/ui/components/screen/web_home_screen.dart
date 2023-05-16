import 'package:flutter/material.dart';
import 'package:region_list_app/system/controllers/home.dart';
import 'package:region_list_app/ui/components/screen/forms/web_region_form.dart';

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({super.key});

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen>
    with SingleTickerProviderStateMixin {
  late HomeController controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller = HomeController(context, () => setState(() {}))..initState();
    controller.webTabController =
        TabController(length: controller.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller.webScrollController,
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: controller.webScrollController,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TabBar(
                  controller: controller.webTabController,
                  labelColor: const Color(0xFF555555),
                  unselectedLabelStyle:
                      const TextStyle(fontWeight: FontWeight.w400),
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: controller.tabs),
            ),
            const SizedBox(height: 10),
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                                child: TextField(
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  prefixIcon: Icon(Icons.search),
                                  hintText: "Search"),
                            )),
                            const SizedBox(width: 10),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(20),
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                            color: Colors.blue))),
                                onPressed: () {},
                                child: Row(
                                  children: const [
                                    Icon(Icons.filter_alt),
                                    SizedBox(width: 5),
                                    Text("Filter")
                                  ],
                                )),
                            const SizedBox(width: 10),
                            ElevatedButton(
                                onPressed: controller.webOnRegionAddClicked,
                                child: Row(children: const [
                                  Icon(Icons.add),
                                  SizedBox(width: 5),
                                  Text("Tambah Alamat")
                                ]))
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (controller.regionsData == null)
                          const Center(child: CircularProgressIndicator())
                        else
                          PaginatedDataTable(
                              rowsPerPage: controller
                                          .regionsDataTableSource!.rowCount <
                                      10
                                  ? controller.regionsDataTableSource!.rowCount
                                  : 10,
                              columns: [
                                "Nama Jalan",
                                "Kecamatan",
                                "Kelurahan",
                                "Kota",
                                "Provinsi",
                                "Negara",
                                "Kategori",
                                "Status",
                                "Actions"
                              ]
                                  .map((e) => DataColumn(
                                      label: Text(e,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold))))
                                  .toList(),
                              source: controller.regionsDataTableSource!),
                        if (controller.regionController != null)
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: const Color(0xFFF8F8F8),
                                borderRadius: BorderRadius.circular(10)),
                            child: controller.regionController!.isLoadingData &&
                                    controller.regionController!.data != null
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Column(
                                    children: [
                                      WebRegionForm(
                                          controller:
                                              controller.regionController!),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.white),
                                              onPressed: controller
                                                  .webOnFormCancelClicked,
                                              child: const Text("Cancel",
                                                  style: TextStyle(
                                                      color: Colors.blue))),
                                          ElevatedButton(
                                              onPressed: controller
                                                      .regionController!
                                                      .isSubmitting
                                                  ? null
                                                  : controller
                                                      .webOnFormSubmitClicked,
                                              child: controller
                                                      .regionController!
                                                      .isSubmitting
                                                  ? const CircularProgressIndicator(
                                                      color: Colors.white)
                                                  : const Text("Simpan"))
                                        ],
                                      )
                                    ],
                                  ),
                          )
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
