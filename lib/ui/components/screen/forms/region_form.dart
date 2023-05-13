import 'package:flutter/material.dart';
import 'package:region_list_app/system/controllers/region.dart';
import 'package:region_list_app/ui/components/reusable/custom_dropdown.dart';

class RegionForm extends StatefulWidget {
  const RegionForm({super.key, required this.controller});

  final RegionController controller;

  @override
  State<RegionForm> createState() => _RegionFormState();
}

class _RegionFormState extends State<RegionForm> {
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
          requiredFieldBuilder(
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
          const SizedBox(height: 10),
          requiredFieldBuilder(
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
          const SizedBox(height: 10),
          requiredFieldBuilder(
            value: controller.provinsi,
            child: CustomDropdown<String>(
                hint: "Provinsi",
                items: controller.provinsiList,
                value: controller.provinsi,
                onChanged: controller.selectProvinsi),
          ),
          const SizedBox(height: 10),
          requiredFieldBuilder(
            value: controller.kota,
            child: CustomDropdown<String>(
                hint: "Kota",
                items: controller.kotaList,
                value: controller.kota,
                onChanged: controller.selectKota),
          ),
          const SizedBox(height: 10),
          requiredFieldBuilder(
            value: controller.kecamatan,
            child: CustomDropdown<String>(
                hint: "Kecamatan",
                items: controller.kecamatanList,
                value: controller.kecamatan,
                onChanged: controller.selectKecamatan),
          ),
          const SizedBox(height: 10),
          requiredFieldBuilder(
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
          const SizedBox(height: 10),
          TextFormField(
            validator: requiredValidator,
            controller: controller.kodePosController,
            decoration: const InputDecoration(hintText: "Kode Pos"),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller.namaJalanController,
            decoration: const InputDecoration(hintText: "Nama Jalan"),
          ),
          const SizedBox(height: 10),
          Row(
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
          const SizedBox(height: 10),
          CheckboxListTile(
              value: controller.isActive,
              title:
                  const Text("Active", style: TextStyle(color: Colors.white)),
              activeColor: Colors.white,
              checkColor: Colors.blue,
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
