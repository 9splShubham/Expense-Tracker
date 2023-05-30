import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_config.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/db_helper/db_helper.dart';
import 'package:expense_tracker/history_screen/history_screen.dart';
import 'package:expense_tracker/listview_builder_data/listview_builder_data.dart';
import 'package:expense_tracker/model/model.dart';
import 'package:expense_tracker/screens/add_data.dart';
import 'package:expense_tracker/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  List<AddDataModel> mAddDataModel = [];

  late DbHelper dbHelper;
  @override
  void initState() {
    income();
    expense();
    initData();
    dbHelper = DbHelper();
    super.initState();
  }

  void initData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    dbHelper = DbHelper();
    print('mAddDataModel----${mAddDataModel.length}');
    mAddDataModel = await dbHelper.getItems(sp.getString(AppConfig.textUserId));
    print('object--mProductModel---${mAddDataModel.length}');
    setState(() {});
  }

  removeData(int index) async {
    dbHelper = DbHelper();
    await dbHelper.deleteData(mAddDataModel[index].id);
    initData();
  }

  void fetchMonthData() async {
    final data = await dbHelper.getMonthData(Month, Year);
    setState(() {
      mAddDataModel = data;
    });
  }

  void fetchYearData() async {
    final data = await dbHelper.getYearData(Year);
    setState(() {
      mAddDataModel = data;
    });
  }

  ///Pie Chart

  Map<String, double> dataMap = {
    "Food items": 18,
    "Clothes": 450,
    "Electronics": 20,
    "Shopping": 220
  };

  List<Color> colorList = [
    const Color(0xFF00bbb3),
    const Color(0xFF1976d2),
    const Color(0xFF49ae26),
    const Color(0xFFe88322),
  ];

  int totalIncome = 0;
  void income() async {
    dbHelper = DbHelper();
    int income = await dbHelper.calaculateIncome();
    setState(() {
      totalIncome = income;
    });
  }

  int totalExpense = 0;
  void expense() async {
    dbHelper = DbHelper();
    int expense = await dbHelper.calculateExpense();
    setState(() {
      totalExpense = expense;
    });
  }

  final user = FirebaseAuth.instance.currentUser;

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
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(
                'User : ${user?.email}',
                style: const TextStyle(color: AppColor.colorWhite),
              ),
              decoration: const BoxDecoration(color: AppColor.colorBlue),
            ),
            ListTile(
              leading: const Icon(
                Icons.history,
                color: AppColor.colorBlue,
              ),
              title: const Text(
                AppString.textHistory,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HistoryScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout_rounded,
                color: AppColor.colorBlue,
              ),
              title: const Text(
                AppString.textLogOut,
              ),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false).then((value) {});
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: AppColor.colorBlue,
              borderRadius: BorderRadius.circular(30)),
          child: const Icon(
            Icons.add,
            color: AppColor.colorWhite,
            size: 20,
          ),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddData()));
        },
      ),
      appBar: AppBar(
        title: const Text(AppString.textDashboard),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              const SizedBox(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        thickness: 5,
                        color: AppColor.colorBlue,
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
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppString.textIncome),
                            Text(
                              'RS : $totalIncome',
                              style: TextStyle(color: AppColor.colorGreen),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppString.textExpense),
                            Text('RS : $totalExpense',
                                style: TextStyle(color: AppColor.colorRed)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Text(AppString.textExpense),
                      const SizedBox(
                        height: 20,
                      ),
                      PieChart(
                        dataMap: dataMap,
                        colorList: colorList,
                        chartRadius: 180,
                        centerText: AppString.textData,
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValues: true,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: true,
                            showChartValueBackground: true),
                        legendOptions: const LegendOptions(
                          showLegends: true,
                          legendShape: BoxShape.rectangle,
                          legendTextStyle: TextStyle(fontSize: 10),
                          legendPosition: LegendPosition.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                child: Text("Show all data"),
                onTap: () {
                  initData();
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: mAddDataModel.length,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      AddDataModel item = mAddDataModel[index];
                      return Data(
                          item: mAddDataModel[index],
                          onDelete: () => removeData(index));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
