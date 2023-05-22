import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  /*final date = TextEditingController();*/

  DateTime _date = DateTime(2023, 05, 22);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text("Date & Time: "),
                SizedBox(
                  width: 10,
                ),
                SizedBox(width: 250, child: TextField()),
                InkWell(
                  child: Icon(Icons.calendar_month),
                  onTap: () async {
                    DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: _date,
                        firstDate: DateTime(200),
                        lastDate: DateTime(2023));
                    if (newDate == null) return;
                    setState(() => _date = newDate);
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text("Type :"),
                SizedBox(
                  height: 50,
                  width: 100,
                  child: TextField(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
