import 'package:flutter/material.dart';

PreferredSizeWidget appBar(BuildContext context, String title) {
  return AppBar(
    iconTheme: const IconThemeData(
      color: Colors.pink,
    ),
    title: Text(title),
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.grey.shade100,
    elevation: 0,
    actions: [
      PopupMenuButton(
        icon: const Icon(Icons.add),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Bleeding',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Bleeding',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Bleeding',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Bleeding',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ];
        },
      )
    ],
  );
}
