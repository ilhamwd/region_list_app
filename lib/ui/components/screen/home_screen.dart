import 'package:flutter/material.dart';
import 'package:region_list_app/system/controllers/home.dart';
import 'package:region_list_app/ui/components/screen/region/region_add_screen.dart';
import 'package:region_list_app/ui/components/screen/region/region_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller = HomeController(context, () => setState(() {}))..initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text("My Regions",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .merge(const TextStyle(color: Colors.white))),
                const SizedBox(height: 20),
                if (controller.regionsData == null)
                  const Center(
                      child: CircularProgressIndicator(color: Colors.white))
                else
                  Expanded(
                      child: RefreshIndicator(
                    onRefresh: controller.getRegionsData,
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1 / 1.2,
                      children: List.generate(
                          controller.regionsData!.data.length, (index) {
                        final data = controller.regionsData!.data[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push<bool>(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegionDetailScreen(data: data)));
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text([
                                    data.namaJalan,
                                    data.kecamatan,
                                    data.kota
                                  ]
                                      .where((element) => element.isNotEmpty)
                                      .join(", ")),
                                  const SizedBox(height: 5),
                                  Text(
                                    data.provinsi,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push<bool>(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegionDetailScreen(
                                                              data: data,
                                                              isEditable:
                                                                  true))).then(
                                                  (value) => value == null
                                                      ? null
                                                      : controller
                                                          .getRegionsData());
                                            },
                                            color: Colors.blue,
                                            icon: const Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text("Confirm"),
                                                      content: const Text(
                                                          "Are you sure you want to delete this region?"),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              controller
                                                                  .deleteRegion(
                                                                      data.id);
                                                            },
                                                            child: const Text(
                                                                "Yes",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red))),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "No")),
                                                      ],
                                                    );
                                                  });
                                            },
                                            color: Colors.red,
                                            icon: const Icon(Icons.delete)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ))
              ],
            ),
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  onPressed: () {
                    Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegionAddScreen()))
                        .then((value) => value == null
                            ? null
                            : setState(() {
                                controller.getRegionsData();
                              }));
                  },
                  child: const Icon(Icons.add)))
        ],
      )),
    );
  }
}
