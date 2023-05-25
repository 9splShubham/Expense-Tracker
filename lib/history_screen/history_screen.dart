import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/db_helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late DbHelper dbHelper;
  List<Map<String, dynamic>> DbData = [];

  @override
  void initState() {
    // TODO: implement initState
    dbHelper = DbHelper();
    fetchDataFromDb();
    super.initState();
  }

  void fetchDataFromDb() async {
    final data = await dbHelper.getAllData();
    setState(() {
      DbData = data;
    });
  }

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
                  border: Border.all(color: AppColor.colorBlue, width: 5),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppString.textMonth),
                      Icon(Icons.arrow_drop_down_sharp),
                      VerticalDivider(
                        color: AppColor.colorBlue,
                        thickness: 5,
                      ),
                      Text(AppString.textYear),
                      Icon(Icons.arrow_drop_down_sharp),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    border: TableBorder.all(
                      color: AppColor.colorBlue,
                    ),
                    columns: [
                      DataColumn(label: Text("ID")),
                      DataColumn(label: Text("DATE")),
                      DataColumn(label: Text("TIME")),
                      DataColumn(label: Text("TYPE")),
                      DataColumn(label: Text("AMOUNT")),
                      DataColumn(label: Text("CATEGORY")),
                      DataColumn(label: Text("PAYMENT")),
                      DataColumn(label: Text("STATUS")),
                      DataColumn(label: Text("NOTE")),
                    ],
                    rows: DbData.map((row) {
                      return DataRow(
                        cells: [
                          DataCell(Text(row['id'].toString())),
                          DataCell(Text(row['date'].toString())),
                          DataCell(Text(row['time'].toString())),
                          DataCell(Text(row['type'].toString())),
                          DataCell(Text(row['amount'].toString())),
                          DataCell(Text(row['category'].toString())),
                          DataCell(Text(row['payment'].toString())),
                          DataCell(Text(row['status'].toString())),
                          DataCell(Text(row['note'].toString())),
                        ],
                      );
                    }).toList()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
