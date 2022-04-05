import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../package/const.dart';
import '../provider/resto_provider.dart';

class SearchBox extends StatefulWidget {
  String hintText;

  SearchBox({required this.hintText});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final _controller = TextEditingController();
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
            controller: _controller,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: _controller.clear,
                icon: Icon(Icons.clear),
              ),
              hintText: widget.hintText,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              icon: Icon(Icons.search),
            ),
            onSubmitted: (String query) {
              final search =
                  Provider.of<RestoProviderSearch>(context, listen: false);
              if (query.isNotEmpty) {
                search.changeQuery(query);
              } else {
                search.changeQuery(' ');
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
