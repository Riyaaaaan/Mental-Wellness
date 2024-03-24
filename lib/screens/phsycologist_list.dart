import 'package:flutter/material.dart';
import 'package:mental_wellness/screens/doctor_details.dart';

class PsycologistList extends StatefulWidget {
  const PsycologistList({Key? key}) : super(key: key);

  @override
  State<PsycologistList> createState() => _PsycologistListState();
}

class _PsycologistListState extends State<PsycologistList> {
  List<Map<String, dynamic>> docList = [
    {
      "image": Image.network(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5IPj8bOq0BhZcQaOzwLEuiyiW0FiMSKDl7eUOS8tj4nhuAjujoO7mIoxdlw&s",
      ),
      "name": "Dr.Deven Lane",
      "position": "Psycologist",
      "hospital": "Square"
    },
    {
      "image": Image.network(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5IPj8bOq0BhZcQaOzwLEuiyiW0FiMSKDl7eUOS8tj4nhuAjujoO7mIoxdlw&s",
      ),
      "name": "Dr.Samanta Lane",
      "position": "Psycologist",
      "hospital": "Square"
    },
    {
      "image": Image.network(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5IPj8bOq0BhZcQaOzwLEuiyiW0FiMSKDl7eUOS8tj4nhuAjujoO7mIoxdlw&s",
      ),
      "name": "Dr.Deven Lane",
      "position": "Psycologist",
      "hospital": "Square"
    },
    {
      "image": Image.network(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5IPj8bOq0BhZcQaOzwLEuiyiW0FiMSKDl7eUOS8tj4nhuAjujoO7mIoxdlw&s",
      ),
      "name": "Dr.Samanta Lane",
      "position": "Psycologist",
      "hospital": "Square"
    },
    {
      "image": Image.network(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5IPj8bOq0BhZcQaOzwLEuiyiW0FiMSKDl7eUOS8tj4nhuAjujoO7mIoxdlw&s",
      ),
      "name": "Dr.Deven Lane",
      "position": "Psycologist",
      "hospital": "Square"
    },
    {
      "image": Image.network(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5IPj8bOq0BhZcQaOzwLEuiyiW0FiMSKDl7eUOS8tj4nhuAjujoO7mIoxdlw&s",
      ),
      "name": "Dr.Samanta Lane",
      "position": "Psycologist",
      "hospital": "Square"
    },
    {
      "image": Image.network(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5IPj8bOq0BhZcQaOzwLEuiyiW0FiMSKDl7eUOS8tj4nhuAjujoO7mIoxdlw&s",
      ),
      "name": "Dr.Deven Lane",
      "position": "Psycologist",
      "hospital": "Square"
    },
    {
      "image": Image.network(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5IPj8bOq0BhZcQaOzwLEuiyiW0FiMSKDl7eUOS8tj4nhuAjujoO7mIoxdlw&s",
      ),
      "name": "Dr.Samanta Lane",
      "position": "Psycologist",
      "hospital": "Square"
    },
  ];
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
                      children: [
                        docList[index]['image'],
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
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
