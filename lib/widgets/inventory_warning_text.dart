import 'package:flutter/material.dart';
import 'package:ma_solutions_cms/utils/constants.dart';

import '../utils/helper_functions.dart';


class InventoryWarningText extends StatelessWidget {
  const InventoryWarningText({
    super.key,
    required this.title,
    required this.inventory,
    this.textColor = Colors.black45,
    this.backgroundColor = Colors.white,
    this.onTap,
  });

  final String title, inventory;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: defaultSpace),
        child: Container(
          width: 250,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(30.0),
            border: const Border(),
          ),
          padding: const EdgeInsets.all(defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Inventory Name
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              /// Remaining Counter
              const SizedBox(height: defaultSpace / 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    inventory,
                    style: Theme.of(context).textTheme.titleLarge!.apply(color: textColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    ' remaining',
                    style: Theme.of(context).textTheme.titleLarge!.apply(color: textColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              /// tagline
              const SizedBox(height: defaultSpace / 2,),
              Text(
                'Refill the items',
                style: Theme.of(context).textTheme.bodySmall!.apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}