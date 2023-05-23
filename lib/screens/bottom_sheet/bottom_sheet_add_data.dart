import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomSheetSelect extends StatefulWidget {
  const BottomSheetSelect({Key? key}) : super(key: key);

  @override
  State<BottomSheetSelect> createState() => _BottomSheetSelectState();
}

class _BottomSheetSelectState extends State<BottomSheetSelect> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppString.textPICKACATEGORY,
                ),
                InkWell(
                  child: Icon(
                    Icons.cancel_outlined,
                    color: AppColor.colorBlue,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  AppString.textAddCategory,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.add_circle_outline_outlined,
                  color: AppColor.colorBlue,
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 400,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Icon(Icons.school),
                        Text("Schools"),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
