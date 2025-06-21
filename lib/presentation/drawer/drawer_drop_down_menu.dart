import 'package:flutter/material.dart';
import 'package:news/extension/extensions.dart';

import '../../core/colors_manger/colors_manger.dart';

class DrawerDropDownMenu extends StatelessWidget {
  String dropDownTextView;
  List<String> dropDownItems;
  final void Function(String?) onChange;
  String selectedComponent;

  DrawerDropDownMenu({
    super.key,
    required this.dropDownTextView,
    required this.selectedComponent,
    required this.dropDownItems,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.heightQuery * 0.02),
        Container(
          margin: EdgeInsets.symmetric(horizontal: context.heightQuery * 0.01),
          padding: EdgeInsets.symmetric(horizontal: context.heightQuery * 0.01),
          width: double.infinity,
          height: context.heightQuery * 0.07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Theme.of(context).hoverColor, width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: context.heightQuery * 0.01,
                ),
                child: Text(
                  dropDownTextView,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Spacer(),
              Container(
                width: context.widthQuery*0.5,
                height: context.heightQuery*0.06,
                padding: EdgeInsets.symmetric(horizontal: context.heightQuery*0.02),
                decoration: BoxDecoration(
                  color: Theme.of(context).hoverColor,
                  borderRadius: BorderRadius.circular(
                    context.heightQuery * 0.05,
                  ),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  dropdownColor: Theme.of(context).hoverColor,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).canvasColor,
                    size: 30,
                  ),
                  items: dropDownItems.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    );
                  }).toList(),
                  onChanged: onChange,
                  hint: Text(
                    selectedComponent,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
