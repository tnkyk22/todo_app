import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String API_URL = "http://127.0.0.1:5001/todos";
  List todolist = [];
  Future<List> fetchTodoList() async {
    final response = await http.get(Uri.parse(API_URL));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  initState() {
    super.initState();
    fetchTodoList().then((value) {
      print(value);
      setState(() {
        todolist = value;
      });
    });
  }

  final task = TextEditingController();
  void addtodo() {
    setState(
      () {
        todolist.add(task.value.text);
        task.clear();
      },
    );
  }

  void edittodo() {}
  void deltodo(index) {
    setState(
      () {
        todolist.removeAt(index);
      },
    );
  }

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
                      controller: task,
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
                      title: Text(todolist[index]['title']),
                      trailing: IconButton(
                        onPressed: () => deltodo(index),
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
