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
    fetchMonthData();
    fetchYearData();
    /*fetchDataFromDb();*/
    super.initState();
  }

  /* void fetchDataFromDb() async {
    final data = await dbHelper.getAllData();
    setState(() {
      DbData = data;
    });
  }*/
  void fetchMonthData() async {
    final data = await dbHelper.selectMonthFromDatabase(Month, Year);
    setState(() {
      DbData = data;
    });
  }

  void fetchYearData() async {
    final data = await dbHelper.selectYearFromDatabase(Year, Month);
    setState(() {
      DbData = data;
    });
  }

  String Month = 'January';
  String Year = '2015';
  var month = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  var year = [
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
  ];

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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 160,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            // Initial Value
                            value: Month,

                            // Down Arrow Icon
                            icon: Icon(
                              Icons.arrow_drop_down_sharp,
                              color: AppColor.colorBlue,
                            ),

                            // Array list of items
                            items: month.map((String month) {
                              return DropdownMenuItem(
                                value: month,
                                child: Text(month),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                Month = newValue!;
                                fetchMonthData();
                              });
                            },
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: AppColor.colorBlue,
                        thickness: 5,
                      ),
                      Container(
                        width: 160,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            // Initial Value
                            value: Year,

                            // Down Arrow Icon
                            icon: Icon(
                              Icons.arrow_drop_down_sharp,
                              color: AppColor.colorBlue,
                            ),

                            // Array list of items
                            items: year.map((String year) {
                              return DropdownMenuItem(
                                value: year,
                                child: Text(year),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                Year = newValue!;
                                fetchYearData();
                              });
                            },
                          ),
                        ),
                      ),
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
                      /*DataColumn(label: Text("ID")),*/
                      DataColumn(label: Text("DATE")),
                      /*       DataColumn(label: Text("TIME")),*/

                      DataColumn(label: Text("AMOUNT")),
                      DataColumn(label: Text("TYPE")),
                      /*   DataColumn(label: Text("PAYMENT")),
                      DataColumn(label: Text("STATUS")),*/
                      /*                     DataColumn(label: Text("CATEGORY")),
                      DataColumn(label: Text("PAYMENT")),
                      DataColumn(label: Text("STATUS")),
                      DataColumn(label: Text("NOTE")),*/
                    ],
                    rows: DbData.map((row) {
                      return DataRow(
                        cells: [
                          /*     DataCell(Text(row['id'].toString())),*/
                          DataCell(Text(row['date'].toString())),
                          /*      DataCell(Text(row['time'].toString())),*/

                          DataCell(Text(
                            row['amount'].toString(),
                            style: TextStyle(
                              color: (row['type'].toString() == 'Income'
                                  ? AppColor.colorGreen
                                  : AppColor.colorRed),
                            ),
                          )),
                          DataCell(Text(row['type'].toString())),
                          /*     DataCell(Text(row['payment'].toString())),
                          DataCell(Text(row['status'].toString())),*/
                          /*         DataCell(Text(row['category'].toString())),
                          DataCell(Text(row['payment'].toString())),
                          DataCell(Text(row['status'].toString())),
                          DataCell(Text(row['note'].toString())),*/
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
