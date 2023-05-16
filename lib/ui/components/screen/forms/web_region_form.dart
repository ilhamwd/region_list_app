import 'package:flutter/material.dart';
import 'package:region_list_app/system/controllers/region.dart';
import 'package:region_list_app/ui/components/reusable/custom_dropdown.dart';

class WebRegionForm extends StatefulWidget {
  const WebRegionForm({super.key, required this.controller});

  final RegionController controller;

  @override
  State<WebRegionForm> createState() => _WebRegionFormState();
}

class _WebRegionFormState extends State<WebRegionForm> {
  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return Form(
      key: controller.formKey,
      onChanged: () {
        if (controller.hasBeenSubmittedBefore) {
          controller.formKey.currentState!.validate();
        }
      },
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: requiredFieldBuilder(
                  value: controller.kategori,
                  child: CustomDropdown<String>(
                      hint: "Kategori",
                      items: controller.kategoriList,
                      value: controller.kategori,
                      onChanged: (val) {
                        if (val == null) return;

                        setState(() {
                          controller.kategori = val;
                        });
                      }),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: requiredFieldBuilder(
                  value: controller.negara,
                  child: CustomDropdown<String>(
                      hint: "Negara",
                      items: controller.negaraList,
                      value: controller.negara,
                      onChanged: (val) {
                        if (val == null) return;

                        setState(() {
                          controller.negara = val;
                        });
                      }),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: requiredFieldBuilder(
                  value: controller.provinsi,
                  child: CustomDropdown<String>(
                      hint: "Provinsi",
                      items: controller.provinsiList,
                      value: controller.provinsi,
                      onChanged: controller.selectProvinsi),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: requiredFieldBuilder(
                  value: controller.kota,
                  child: CustomDropdown<String>(
                      hint: "Kota",
                      items: controller.kotaList,
                      value: controller.kota,
                      onChanged: controller.selectKota),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: requiredFieldBuilder(
                  value: controller.kecamatan,
                  child: CustomDropdown<String>(
                      hint: "Kecamatan",
                      items: controller.kecamatanList,
                      value: controller.kecamatan,
                      onChanged: controller.selectKecamatan),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: requiredFieldBuilder(
                  value: controller.kelurahan,
                  child: CustomDropdown<String>(
                      hint: "Kelurahan",
                      items: controller.kelurahanList,
                      value: controller.kelurahan,
                      onChanged: (val) {
                        if (val == null) return;

                        setState(() {
                          controller.kelurahan = val;
                        });
                      }),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  validator: requiredValidator,
                  controller: controller.kodePosController,
                  decoration: const InputDecoration(hintText: "Kode Pos"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: controller.namaJalanController,
                  decoration: const InputDecoration(hintText: "Nama Jalan"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.rtController,
                        decoration: const InputDecoration(hintText: "RT"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: controller.rwController,
                        decoration: const InputDecoration(hintText: "RW"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CheckboxListTile(
              value: controller.isActive,
              title: const Text("Active"),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (val) {
                setState(() {
                  controller.isActive = val ?? false;
                });
              })
        ],
      ),
    );
  }

  Widget requiredFieldBuilder({required String? value, required Widget child}) {
    return FormField(
        validator: (_) => requiredValidator(value),
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              child,
              if (state.hasError)
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(state.errorText!,
                        style:
                            Theme.of(context).inputDecorationTheme.errorStyle)),
            ],
          );
        });
  }

  String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }

    return null;
  }
}
