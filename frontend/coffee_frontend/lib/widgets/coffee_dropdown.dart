import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CoffeeDropdown<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final T? selectedItem;
  final Function(T?) onChanged;
  final String Function(T)? itemAsString;
  final Future<List<T>> Function(String)? asyncItems;

  const CoffeeDropdown({
    Key? key,
    required this.label,
    this.items = const [],
    this.selectedItem,
    required this.onChanged,
    this.itemAsString,
    this.asyncItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownSearch<T>(
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          menuProps: MenuProps(
            backgroundColor: Theme.of(context).cardTheme.color,
          ),
        ),
        asyncItems: asyncItems,
        items: items,
        itemAsString: itemAsString,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: label,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
        onChanged: onChanged,
        selectedItem: selectedItem,
      ),
    );
  }
}
