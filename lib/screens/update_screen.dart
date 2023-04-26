import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui/screens/print_data.dart';
import '../database_helper.dart';

class UpdateScreen extends StatefulWidget {
  int id;
  String name;
  String address;
  String math;
  String sci;
  String eng;
  String comp;
  String age;

  UpdateScreen(this.id, this.name, this.address, this.math, this.sci, this.eng,
      this.comp, this.age,
      {super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController stName = TextEditingController();
  TextEditingController stAddress = TextEditingController();
  TextEditingController stMath = TextEditingController();
  TextEditingController stScience = TextEditingController();
  TextEditingController stEnglish = TextEditingController();
  TextEditingController stComputer = TextEditingController();
  TextEditingController stAge = TextEditingController();

  @override
  void initState() {
    super.initState();
    stName.text = widget.name;
    stAddress.text = widget.address;
    stMath.text = widget.math;
    stScience.text = widget.sci;
    stEnglish.text = widget.eng;
    stComputer.text = widget.comp;
    stAge.text = widget.age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Data'),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.only(top: 28, left: 28.0),
            child: Text(
              'Change Name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: TextField(
              controller: stName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          SubList(name: 'Age', stName: stAge),
          const Padding(
            padding: EdgeInsets.only(left: 28.0),
            child: Text('Change Address',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: TextField(
              controller: stAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 28),
            child: Text(
              'Enter Subjects Marks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SubList(name: 'Math', stName: stMath),
          SubList(name: 'Science', stName: stScience),
          SubList(name: 'English', stName: stEnglish),
          SubList(name: 'Computer', stName: stComputer),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrintData(),
                    ),
                  );
                  String name = stName.text.toString();
                  String address = stAddress.text.toString();
                  String math = stMath.text.toString();
                  String sci = stScience.text.toString();
                  String eng = stEnglish.text.toString();
                  String comp = stComputer.text.toString();
                  String age = stAge.text.toString();
                  final dbHelper = DBHelper();
                  await dbHelper.updateData({
                    'name': name,
                    'age': age,
                    'address': address,
                    'math': math,
                    'sci': sci,
                    'eng': eng,
                    'comp': comp,
                    'id': widget.id
                  });
                  setState(() {});
                },
                child: const Text('Update')),
          ),
        ]),
      ),
    );
  }
}

class SubList extends StatelessWidget {
  final String name;
  final TextEditingController stName;

  const SubList({super.key, required this.name, required this.stName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28, top: 28, right: 38),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            padding: const EdgeInsets.only(bottom: 3, left: 7),
            height: 35,
            width: 100,
            child: Center(
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2),
                ],
                keyboardType: TextInputType.number,
                controller: stName,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
