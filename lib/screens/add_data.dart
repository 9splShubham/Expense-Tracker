import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_config.dart';
import 'package:expense_tracker/core/app_fonts.dart';
import 'package:expense_tracker/core/app_size.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/core/com_helper/com_helper.dart';
import 'package:expense_tracker/db_helper/db_helper.dart';
import 'package:expense_tracker/model/model.dart';
import 'package:expense_tracker/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  /// Initial Selected Value
  String dropdownvalue = 'Income';

  String Category = 'Food';

  /// List of items in our dropdown menu
  var items = ['Income', 'Expense'];

  var category = [
    'Food',
    'Shoping',
    'Social Life',
    'Education',
    'Transport',
    'Health'
  ];

  /// DATE
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  /// TIME

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked_s = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context, //context of current state
    );

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
      });
  }

  late DbHelper dbHelper;

  @override
  void initState() {
    dbHelper = DbHelper();
    super.initState();
  }

  late TextEditingController dateController = TextEditingController();
  late TextEditingController timeController = TextEditingController();
  late TextEditingController amountController = TextEditingController();
  late TextEditingController noteController = TextEditingController();

  void AddDataInDb() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String Date = dateController.text;
    String Time = timeController.text;
    String Amount = amountController.text;
    String Note = noteController.text;

    AddDataModel aModel = AddDataModel();

    aModel.userId = sp.getString(AppConfig.textUserId);
    aModel.date = Date;
    aModel.time = Time;
    aModel.type = dropdownvalue;
    aModel.amount = int.parse(Amount);
    aModel.category = Category;
    aModel.paymentMethod = SelectedItemPay;
    aModel.status = SelectedItemStatus;
    aModel.note = Note;

    dbHelper = DbHelper();
    await dbHelper.insertData(aModel).then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }).then((value) {
      alertDialog(AppString.textAddeddatasuccessfully);
    }).catchError((error) {
      print('${error}');
    });
  }

  String? SelectedItemPay;
  String? SelectedItemStatus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.textAddData),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppString.textDate),
                  SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: dateController = TextEditingController(
                          text: "${selectedDate.toLocal()}".split(' ')[0]),
                      decoration:
                          InputDecoration(hintText: AppString.textSelectDate),
                    ),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.calendar_month,
                      color: AppColor.colorBlue,
                    ),
                    onTap: () => _selectDate(context),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppString.textTime),
                  SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: timeController = TextEditingController(
                          text: selectedTime.format(context).toString()),
                      decoration:
                          InputDecoration(hintText: AppString.textSelectTime),
                    ),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.access_time_outlined,
                      color: AppColor.colorBlue,
                    ),
                    onTap: () => _selectTime(context),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppString.textType),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    width: 270,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        // Initial Value
                        value: dropdownvalue,

                        // Down Arrow Icon
                        icon: const Icon(
                          Icons.arrow_drop_down_sharp,
                          color: AppColor.colorBlue,
                        ),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppString.textAmount),
                  SizedBox(
                    height: 30,
                    width: 250,
                    child: TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: AppString.textEnterAmount,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppString.textCategory),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 250,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        // Initial Value
                        value: Category,

                        // Down Arrow Icon
                        icon: const Icon(
                          Icons.arrow_drop_down_sharp,
                          color: AppColor.colorBlue,
                        ),

                        // Array list of items
                        items: category.map((String category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            Category = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  /*SizedBox(
                    height: 20,
                    width: 250,
                    child: InkWell(
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: AppString.textSelectCategory,
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return BottomSheetSelect();
                            });
                      },
                    ),
                  ),*/
                  /*    Icon(
                    Icons.arrow_drop_down_sharp,
                    color: AppColor.colorBlue,
                  )*/
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppString.textPaymentMethod),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 210,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        // Initial Value
                        value: SelectedItemPay,

                        // Down Arrow Icon
                        icon: const Icon(
                          Icons.arrow_drop_down_rounded,
                          color: AppColor.colorBlue,
                        ),

                        // Array list of items
                        items: [
                          DropdownMenuItem(value: "Cash", child: Text("Cash")),
                          DropdownMenuItem(value: "Card", child: Text("Card")),
                          DropdownMenuItem(
                              value: "Net Banking", child: Text("Net Banking")),
                          DropdownMenuItem(
                              value: "Cheque", child: Text("Cheque")),
                        ],
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            SelectedItemPay = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SelectedItemPay == 'Cheque'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppString.textAddStatus),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 210,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              // Initial Value
                              value: SelectedItemStatus,

                              // Down Arrow Icon
                              icon: const Icon(
                                Icons.arrow_drop_down_rounded,
                                color: AppColor.colorBlue,
                              ),

                              // Array list of items
                              items: [
                                DropdownMenuItem(
                                    value: "Clear", child: Text("Clear")),
                                DropdownMenuItem(
                                    value: "Under Process",
                                    child: Text("Under Process")),
                                DropdownMenuItem(
                                    value: "Reject", child: Text("Reject")),
                              ],
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  SelectedItemStatus = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 20,
                    ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppString.textAddNote),
                  SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                      height: 20,
                      width: 250,
                      child: TextFormField(
                        controller: noteController,
                        decoration:
                            InputDecoration(hintText: AppString.textAddNote),
                      )),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    AppString.textAddData,
                    style:
                        getTextStyle(AppFonts.regularBlue, AppSize.textSize15),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: AppColor.colorWhite,
                      side: BorderSide(color: AppColor.colorBlue, width: 2)),
                  onPressed: () {
                    AddDataInDb();
                  },
                ),
              ),
              /*          SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {}, child: Text("Add")))*/
            ],
          ),
        ),
      ),
    );
  }
}
