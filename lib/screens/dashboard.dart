import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/history_screen/history_screen.dart';
import 'package:expense_tracker/screens/add_data.dart';
import 'package:expense_tracker/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
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

  final user = FirebaseAuth.instance.currentUser;

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
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
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
                            Text(AppString.textRS10000),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppString.textExpense),
                            Text(AppString.textRS5000),
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
            ],
          ),
        ),
      ),
    );
  }
}
