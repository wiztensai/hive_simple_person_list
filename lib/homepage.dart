import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_simple_person_list/constant.dart';
import 'package:hive_simple_person_list/person_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _FormInputState();
}

class _FormInputState extends State<HomePage> {
  var box;
  var data = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    box = Hive.box(Constant.HIVE_DB_PERSON);
    data = box.get(Constant.HIVE_TB_PERSON) ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Input')),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Text('Nama'),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Input nama disini...',
                    border: InputBorder.none,
                  ),
                ),
                const Text('Alamat'),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    hintText: 'Input alamat disini...',
                    border: InputBorder.none,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      var name = nameController.text;
                      var address = addressController.text;

                      data.add(PersonModel(name, address));

                      box.put(Constant.HIVE_TB_PERSON, data);

                      setState(() {
                        // cuma utk mentriger rebuild
                        var hehe =
                            box.get(Constant.HIVE_TB_PERSON)[0] as PersonModel;
                        print(hehe.name);
                      });
                    },
                    child: const Text('Submit'))
              ])),
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              var person = data[index] as PersonModel;

              return Card(
                margin: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nama: ${person.name}'),
                    Text('Alamat: ${person.address}'),
                  ],
                ),
              );
            },
          )
        ],
      )),
    );
  }
}
