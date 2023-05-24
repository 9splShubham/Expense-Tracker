import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_fonts.dart';
import 'package:expense_tracker/core/app_size.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/db_helper/db_helper.dart';
import 'package:expense_tracker/screens/bottom_sheet/bottom_sheet_add_data.dart';
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
  String dropdown = 'Cash';
  String drop = 'Clear';

  /// List of items in our dropdown menu
  var items = ['Income', 'Expense'];
  var payment = ['Cash', 'Card', 'Net Banking', 'Cheque'];
  var status = ['Clear', 'Under Process', 'Reject'];

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
                      controller: TextEditingController(
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
                      controller: TextEditingController(
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
                          setState(() async {
                            dropdownvalue = newValue!;
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            dbHelper.insertType(newValue!);
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
                  Text(AppString.textCategory),
                  SizedBox(
                    width: 30,
                  ),
                  SizedBox(
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
                  ),
                  Icon(
                    Icons.arrow_drop_down_sharp,
                    color: AppColor.colorBlue,
                  )
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
                      child: DropdownButton(
                        // Initial Value
                        value: dropdown,

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
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdown = newValue!;
                            dbHelper.insertPayment(newValue!);
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
                  Text(AppString.textAddStatus),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 210,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        // Initial Value
                        value: drop,

                        // Down Arrow Icon
                        icon: const Icon(
                          Icons.arrow_drop_down_rounded,
                          color: AppColor.colorBlue,
                        ),

                        // Array list of items
                        items: status.map((String status) {
                          return DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            drop = newValue!;
                            dbHelper.insertStatus(newValue!);
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
                  Text(AppString.textAddNote),
                  SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                      height: 20,
                      width: 250,
                      child: TextFormField(
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
                  onPressed: () {},
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
