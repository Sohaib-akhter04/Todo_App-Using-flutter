import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> todoList = [];
  String singleValue = "";
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  addString(content) {
    setState(() {
      singleValue = content;
    });
  }

  addList() {
    setState(() {
      todoList.add({"value": singleValue, "done": false});
      textController.clear();
    });
  }

  deleteItem(index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo Application",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 75,
        backgroundColor: Colors.teal[700],
        elevation: 4,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 90,
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.teal,
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      todoList[index]['done'] =
                                          !(todoList[index]['done'] ?? false);
                                    });
                                  },
                                  child: todoList[index]['done'] ?? false
                                      ? Icon(
                                          Icons.check,
                                          size: 20.0,
                                          color: Colors.teal,
                                        )
                                      : Icon(
                                          Icons.circle_outlined,
                                          size: 20.0,
                                          color: Colors.teal,
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 50,
                              child: Text(
                                todoList[index]['value'].toString(),
                                style: TextStyle(
                                  color: todoList[index]['done'] ?? false
                                      ? Colors.grey
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  decoration: todoList[index]['done'] ?? false
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 30,
                              child: TextButton(
                                onPressed: () {
                                  deleteItem(index);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: const Color.fromARGB(255, 77, 77, 77),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 10,
              child: Row(
                children: [
                  Expanded(
                    flex: 70,
                    child: Container(
                      height: 40,
                      child: TextFormField(
                        controller: textController,
                        onChanged: (content) {
                          addString(content);
                        },
                        style: TextStyle(
                          color: Colors.black, 
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fillColor: Colors.teal[300],
                          filled: true,
                          labelText: 'Create Task...',
                          labelStyle: const TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 3,
                    child: SizedBox(width: 5),
                  ),
                  Expanded(
                    flex: 27,
                    child: ElevatedButton(
                      onPressed: () {
                        addList();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                      child: Container(
                        height: 15,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.white, 
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
