import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown(
      {super.key,
      required this.items,
      required this.onChanged,
      this.value,
      this.hint});

  final List<DropdownMenuItem<T>> items;
  final void Function(T? value) onChanged;
  final T? value;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<T>(
        isExpanded: true,
        items: items,
        onChanged: onChanged,
        value: value,
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(10),
        hint: hint == null ? null : Text(hint!),
      ),
    );
  }
}
