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
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  /// Initial Selected Value
  String Type = 'Income';

  String Category = 'Food';
  String Payment = 'Cash';

  /// List of items in our dropdown menu
  var type = ['Income', 'Expense'];

  var category = [
    'Food',
    'Shoping',
    'Social Life',
    'Education',
    'Transport',
    'Health'
  ];

  var payment = [
    'Cash',
    'Card',
    'Net Banking',
    'Cheque',
  ];

  /// DATE
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 1),
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
  late TextEditingController textController = TextEditingController();
  late TextEditingController payController = TextEditingController();

  void AddDataInDb() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String Date = dateController.text;
    String Time = timeController.text;
    String Amount = amountController.text;
    String Note = noteController.text;

    if (Date.isEmpty) {
      alertDialog("Please Enter Date");
    } else if (Time.isEmpty) {
      alertDialog("Please Enter Time");
    } else if (Amount.isEmpty) {
      alertDialog("Please Enter Amount");
    } else if (Note.isEmpty) {
      alertDialog("Please Enter Note");
    } else {
      AddDataModel aModel = AddDataModel();

      aModel.userId = sp.getString(AppConfig.textUserId);
      aModel.date = Date;
      aModel.time = Time;
      aModel.type = Type;
      aModel.amount = int.parse(Amount);
      aModel.category = Category;
      aModel.paymentMethod = Payment;
      aModel.status = SelectedItemStatus;
      aModel.note = Note;

      dbHelper = DbHelper();
      await dbHelper.insertData(aModel).catchError((error) {
        print('${error}');
        alertDialog("Error: Data Save Fail--$error");
      }).then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      }).then((value) {
        alertDialog(AppString.textAddeddatasuccessfully);
      });
    }
  }

  String? SelectedItemStatus;

  @override
  Widget build(BuildContext context) {
    String formattedDate = new DateFormat.yMMMMd().format(selectedDate);
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
                  InkWell(
                    child: SizedBox(
                      width: 250,
                      child: TextFormField(
                        enabled: false,
                        controller: dateController =
                            TextEditingController(text: "${formattedDate}"),
                        style: TextStyle(color: AppColor.colorBlack),
                        decoration:
                            InputDecoration(hintText: AppString.textSelectDate),
                      ),
                    ),
                    onTap: () => _selectDate(context),
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
                  InkWell(
                    child: SizedBox(
                      width: 250,
                      child: TextFormField(
                        enabled: false,
                        controller: timeController = TextEditingController(
                            text: selectedTime.format(context).toString()),
                        style: TextStyle(color: AppColor.colorBlack),
                        decoration:
                            InputDecoration(hintText: AppString.textSelectTime),
                      ),
                    ),
                    onTap: () => _selectTime(context),
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
                        value: Type,

                        // Down Arrow Icon
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: AppColor.colorBlue,
                        ),

                        // Array list of items
                        items: type.map((String type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            Type = newValue!;
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
                    width: 10,
                  ),
                  InkWell(
                    child: Icon(
                      Icons.add_circle_outline_outlined,
                      color: AppColor.colorBlue,
                    ),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (builder) {
                            return Scaffold(
                              body: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Center(
                                        child: Text(
                                          AppString.textEnterYourText,
                                          style: getTextStyle(
                                              AppFonts.semiBoldBlack,
                                              AppSize.textSize20),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      SizedBox(
                                        height: 70,
                                        child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          controller: textController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.blue[100],
                                            hintText:
                                                AppString.textTypeyourtexthere,
                                            hintStyle: getTextStyle(
                                                AppFonts.regularGrey,
                                                AppSize.textSize14),
                                          ),
                                          style: const TextStyle(),
                                          maxLines: 10,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: 160,
                                            child: ElevatedButton(
                                              child: Text(
                                                AppString.textCancel,
                                                style: getTextStyle(
                                                  AppFonts.regularBlue,
                                                  AppSize.textSize16,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: AppColor.colorWhite,
                                                  side: const BorderSide(
                                                      color: AppColor.colorBlue,
                                                      width: 2)),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: 160,
                                            child: ElevatedButton(
                                              child: Text(AppString.textAdd,
                                                  style: getTextStyle(
                                                      AppFonts.regular,
                                                      AppSize.textSize16)),
                                              style: ElevatedButton.styleFrom(
                                                primary: AppColor.colorBlue,
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                setState(() {
                                                  String newOption =
                                                      '${textController.text}';
                                                  category.add(newOption);
                                                  Category = newOption;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 240,
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
                    width: 10,
                  ),
                  InkWell(
                    child: Icon(
                      Icons.add_circle_outline_outlined,
                      color: AppColor.colorBlue,
                    ),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (builder) {
                            return Scaffold(
                              body: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Center(
                                        child: Text(
                                          AppString.textEnterYourText,
                                          style: getTextStyle(
                                              AppFonts.semiBoldBlack,
                                              AppSize.textSize20),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      SizedBox(
                                        height: 70,
                                        child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          controller: payController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.blue[100],
                                            hintText:
                                                AppString.textTypeyourtexthere,
                                            hintStyle: getTextStyle(
                                                AppFonts.regularGrey,
                                                AppSize.textSize14),
                                          ),
                                          style: const TextStyle(),
                                          maxLines: 10,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: 160,
                                            child: ElevatedButton(
                                              child: Text(
                                                AppString.textCancel,
                                                style: getTextStyle(
                                                  AppFonts.regularBlue,
                                                  AppSize.textSize16,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: AppColor.colorWhite,
                                                  side: const BorderSide(
                                                      color: AppColor.colorBlue,
                                                      width: 2)),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: 160,
                                            child: ElevatedButton(
                                              child: Text(AppString.textAdd,
                                                  style: getTextStyle(
                                                      AppFonts.regular,
                                                      AppSize.textSize16)),
                                              style: ElevatedButton.styleFrom(
                                                primary: AppColor.colorBlue,
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                setState(() {
                                                  String newOption =
                                                      '${payController.text}';
                                                  payment.add(newOption);
                                                  Payment = newOption;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 190,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        // Initial Value
                        value: Payment,

                        // Down Arrow Icon
                        icon: const Icon(
                          Icons.arrow_drop_down_rounded,
                          color: AppColor.colorBlue,
                        ),

                        // Array list of items
                        items: payment.map((String payment) {
                          return DropdownMenuItem(
                            value: payment,
                            child: Text(payment),
                          );
                        }).toList(),

                        onChanged: (String? newValue) {
                          setState(() {
                            Payment = newValue!;
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
              Payment == 'Cheque'
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
            ],
          ),
        ),
      ),
    );
  }
}
