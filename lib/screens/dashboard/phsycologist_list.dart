import 'package:flutter/material.dart';
import 'package:mental_wellness/screens/dashboard/doctor_details.dart';
import 'package:mental_wellness/utils/constants.dart';

class PsycologistList extends StatefulWidget {
  const PsycologistList({Key? key}) : super(key: key);

  @override
  State<PsycologistList> createState() => _PsycologistListState();
}

class _PsycologistListState extends State<PsycologistList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Psychologist',
          style: TextStyle(color: Colors.black),
        ),
        titleSpacing: 0,
      ),
      body: SizedBox(
          height: double.infinity,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: List<Widget>.generate(docList.length, (index) {
              return Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DoctorDetails();
                        },
                      ),
                    );
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        docList[index]['image'],
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                docList[index]['name'],
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(docList[index]['position']),
                              Text(
                                docList[index]['hospital'],
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.blue),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          )),
    );
  }
}
