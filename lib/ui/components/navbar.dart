import 'package:flutter/material.dart';
import 'package:region_list_app/ui/components/reusable/custom_dropdown.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Row(
          children: [
            const Icon(Icons.menu),
            const SizedBox(width: 100),
            Image.asset("assets/img/logo.png", width: 70),
            const SizedBox(width: 50),
            const Expanded(
                child: TextField(
              decoration: InputDecoration(
                  hintText: "Search", suffixIcon: Icon(Icons.search)),
            )),
            const SizedBox(width: 20),
            DefaultTextStyle(
              style: const TextStyle(fontSize: 12),
              child: CustomDropdown(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  isExpanded: false,
                  isDense: true,
                  items: [
                    DropdownMenuItem(
                        child: Row(
                      children: const [
                        Icon(Icons.apps),
                        SizedBox(width: 5),
                        Text("Module")
                      ],
                    ))
                  ],
                  onChanged: (_) {}),
            ),
            const SizedBox(width: 20),
            const Icon(Icons.notifications),
            const SizedBox(width: 20),
            const Icon(Icons.help),
            const SizedBox(width: 20),
            const Icon(Icons.settings_rounded),
            const SizedBox(width: 20),
            const Icon(Icons.more_vert),
            const SizedBox(width: 20),
            ClipOval(
              child: Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.orange,
                  child: const Icon(
                    Icons.apple,
                    color: Colors.white,
                    size: 16,
                  )),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.blue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(color: Colors.blue))),
                onPressed: () {},
                child: const Text("Sign Out"))
          ],
        ),
      ),
    );
  }
}
