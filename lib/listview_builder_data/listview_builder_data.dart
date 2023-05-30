import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_fonts.dart';
import 'package:expense_tracker/core/app_size.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Data extends StatelessWidget {
  final AddDataModel item;
  final Function onDelete;

  const Data({Key? key, required this.item, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.blue),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppString.textCategory,
                          style: getTextStyle(
                              AppFonts.semiBoldBlack, AppSize.textSize15),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(item.category!),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(item.date!),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(item.time!),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      item.note!,
                      style: getTextStyle(
                          AppFonts.regularGrey, AppSize.textSize15),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    item.amount.toString(),
                    style: TextStyle(
                      color: (item.type == 'Income'
                          ? AppColor.colorGreen
                          : AppColor.colorRed),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  InkWell(
                    child: const Icon(
                      Icons.delete,
                      color: AppColor.colorRed,
                    ),
                    onTap: () {
                      showAlertDialog2(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog2(BuildContext context) {
    // set up the buttons
    Widget cancelButton = InkWell(
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Text(
          "Cancel",
          style: getTextStyle(AppFonts.regularBlue, AppSize.textSize16),
        ),
      ),
      onTap: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget deleteButton = InkWell(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text("Delete",
            style: getTextStyle(AppFonts.regularBlue, AppSize.textSize16)),
      ),
      onTap: () {
        Navigator.of(context, rootNavigator: true).pop();
        onDelete();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: const Text("Delete Cart"),
      content: const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Text("Are you sure You want to Delete?"),
      ),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
