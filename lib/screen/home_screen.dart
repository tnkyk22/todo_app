import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List todolist = [];
  String task = "";
  void addtodo() {
    setState(() {
      todolist.add(task);
      task = "";
    });
  }

  void edittodo() {}
  void deltodo() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To Do List")),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "สิ่งที่ต้องทำ",
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        task = value;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: addtodo,
                      child: Text("เพิ่ม"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(todolist[index]),
                      trailing: IconButton(
                        onPressed: deltodo,
                        icon: Icon(Icons.delete),
                      ),
                    );
                  },
                  itemCount: todolist.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
