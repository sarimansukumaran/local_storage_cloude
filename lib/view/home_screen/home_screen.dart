import 'package:flutter/material.dart';
import 'package:local_storage_cloude/condroller/home_screen_controller.dart';
import 'package:local_storage_cloude/utils/color_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await HomeScreenController.getEmployee();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //   backgroundColor: ColorConstants.backgroundColor,
        title: Text("Local Storage"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          customBottomSheet(context);
        },
        child: Icon(
          Icons.add,
          color: ColorConstants.floatingbtncolor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: ColorConstants.backgroundColor,
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          title: Text(
            HomeScreenController.employeedatalist[index]["name"],
            style: TextStyle(color: ColorConstants.main_white),
          ),
          subtitle: Text(
            HomeScreenController.employeedatalist[index]["designation"],
            style: TextStyle(color: ColorConstants.main_white),
          ),
          trailing: IconButton(
              onPressed: () async {
                await HomeScreenController.removeEmployee(
                    HomeScreenController.employeedatalist[index]["id"]);
                setState(() {});
              },
              icon: Icon(
                Icons.delete,
                color: ColorConstants.main_white,
              )),
        ),
        separatorBuilder: (context, index) => Divider(),
        itemCount: HomeScreenController.employeedatalist.length,
      ),
    );
  }

  Future<dynamic> customBottomSheet(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController designationController = TextEditingController();
    return showModalBottomSheet(
        backgroundColor: ColorConstants.primarybg,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Name : ", border: OutlineInputBorder()),
                    controller: nameController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Distination :",
                        border: OutlineInputBorder()),
                    controller: designationController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () async {
                          await HomeScreenController.addEmployee(
                              nameController.text, designationController.text);
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              )))
                    ],
                  )
                ],
              ),
            ));
  }
}
