import 'package:flutter/material.dart';
import 'package:pricecreator/menu_item.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [
    itemSettings
  ];

  static const itemSettings = MenuItem(
    text: 'Ajustar ganancia',
    icon: Icons.settings
  );
}