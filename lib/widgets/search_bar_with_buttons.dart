import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarWithButtons extends StatelessWidget {
  const SearchBarWithButtons({
    super.key,
    required this.onChanged,
    required this.onTapAdd
  });

  final Function(String) onChanged;
  final Function() onTapAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 400, height: 40,
          child: SearchBar(
            hintText: 'Search',
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(CupertinoIcons.search, color: Colors.grey.withOpacity(0.8),),
            ),
            onChanged: onChanged,
          ),
        ),

        ElevatedButton(onPressed: onTapAdd, child: const Icon(Icons.add)),

      ],
    );
  }
}