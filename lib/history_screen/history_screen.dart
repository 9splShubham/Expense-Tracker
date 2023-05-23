import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.textHistory),
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                AppString.textLISTOFEXPENSES,
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.colorBlue),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppString.textMonth),
                      Icon(Icons.arrow_drop_down_sharp),
                      VerticalDivider(
                        width: 5,
                        color: AppColor.colorBlue,
                      ),
                      Text(AppString.textYear),
                      Icon(Icons.arrow_drop_down_sharp),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
