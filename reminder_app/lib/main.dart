import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Map<String, dynamic>> tasks = [
    {'title': 'Get Grocery', 'isChecked': false},
    {'title': 'Collage', 'isChecked': true},
    {'title': 'Study', 'isChecked': false},
  ];


  void addTask(String taskTitle) {
    setState(() {
      tasks.add({'title': taskTitle, 'isChecked': false});
    });
  }


  void toggleCheckbox(int index, bool? value) {
    setState(() {
      tasks[index]['isChecked'] = value!;
    });
  }


  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/notification.png',
                width: 40,
                height: 50,
              ),
              SizedBox(width: 20),
              Text(
                'Notify Me',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 2.0,
                offset: Offset(0, 5),
              )
            ]),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            color: Colors.white,
            elevation: 2,
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Checkbox(
                value: tasks[index]['isChecked'],
                onChanged: (value) {
                  toggleCheckbox(index, value);
                },
              ),
              title: Text(
                tasks[index]['title'],
                style: TextStyle(
                  decoration: tasks[index]['isChecked']
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete,color: Colors.red,),
                onPressed: () {
                  deleteTask(index);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTaskDialog(
              onAdd: addTask,
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class AddTaskDialog extends StatelessWidget {
  final Function(String) onAdd;
  final TextEditingController controller = TextEditingController();

  AddTaskDialog({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Task'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'Enter task'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            String taskTitle = controller.text;
            if (taskTitle.isNotEmpty) {
              onAdd(taskTitle);
              Navigator.of(context).pop();
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
