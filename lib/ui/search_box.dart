import 'package:flutter/material.dart';

import '../package/const.dart';

class SearchBox extends StatefulWidget {
  String hintText;

  SearchBox({required this.hintText});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          border: Border.all(color: warnaAksen2, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: TextField(
            decoration: InputDecoration(
              hintText: widget.hintText,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              icon: Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
