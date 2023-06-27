import 'package:hive_flutter/adapters.dart';
import 'package:send_remider_to_user/constants/colors.dart';
import 'package:send_remider_to_user/data/sharedpref/constants/preferences.dart';
import 'package:send_remider_to_user/stores/form/form_store.dart';
import 'package:send_remider_to_user/stores/theme/theme_store.dart';
import 'package:send_remider_to_user/ui/add_todo/add_todo.dart';
import 'package:send_remider_to_user/ui/add_todo/widget/delete_task.dart';
import 'package:send_remider_to_user/ui/add_todo/widget/show_dailogue.dart';
import 'package:send_remider_to_user/ui/add_todo/widget/todo_list_card.dart';
import 'package:send_remider_to_user/ui/contacts/contacts.dart';
import 'package:send_remider_to_user/utils/device/device_utils.dart';
import 'package:send_remider_to_user/utils/locale/app_localization.dart';
import 'package:send_remider_to_user/widgets/title_with_back_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen>
    with TickerProviderStateMixin {
  //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;

  final _formStore = FormStore();

  String _mobile = '';

  int selectedButton = 0;
  late TabController _tabController;

  @override
  void initState() {
    loadData();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _mobile = preferences.getString(Preferences.mobile) ?? '';
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initializing stores
    _themeStore = Provider.of<ThemeStore>(context);
  }

  List<Family> familyList = [
    Family(
        'Ruchita Kamthe',
        'Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet, consectetur',
        '12/3/2023 4:78 AM',
        'meet.google.com/nyd-aceb-xws',
        'gsgdhgdsv hjgdsjdsj jdhgjdgs dsjhg'),
    Family(
        'Shabana Sayyad',
        'Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet, consectetur',
        '12/3/2023 4:78 AM',
        'meet.google.com/nyd-aceb-xws',
        'gsgdhgdsv hjgdsjdsj jdhgjdgs dsjhg'),
    Family(
        'Rohit Adhav',
        'Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet, consectetur',
        '12/3/2023 4:78 AM',
        'meet.google.com/nyd-aceb-xws',
        'gsgdhgdsv hjgdsjdsj jdhgjdgs dsjhg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Task List'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: 'My Task',
              // icon: Icon(Icons.cloud_outlined),
            ),
            Tab(
              text: 'Team Task',
              // icon: Icon(Icons.beach_access_sharp),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _buildMyTask(),
          _buildMyTask(),
        ],
      ),
    );
  }

  Widget _buildMyTask() {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Column(
                  children: [
                    Expanded(child: _buildTodoListContent()),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: DeviceUtils.getScaledWidth(context, 5),
                      bottom: DeviceUtils.getScaledHeight(context, 2)),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddTodoPage()));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.newButtonColor,
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(
                                DeviceUtils.getScaledWidth(context, 3)),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: DeviceUtils.getScaledWidth(context, 8),
                            ))),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPopTaskDetails(
      userName, desc, date, googleLink, document) async {
    return (await detailsDialog(
            context: context,
            userName: userName,
            desc: desc,
            date: date,
            googleLink: googleLink,
            document: document)) ??
        false;
  }

  Future<bool> _onWillPopDelete(userName, ontap) async {
    return (await deleteTaskDialog(
            context: context, userName: userName, ontap: ontap)) ??
        false;
  }

  Widget _buildTodoListContent() {
    return Container(
      color: AppColors.violetFaint,
      child: Column(
        children: [
          // SizedBox(
          //   height: DeviceUtils.getScaledHeight(context, 2),
          // ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(
                //         DeviceUtils.getScaledWidth(context, 5)),
                //     topRight: Radius.circular(
                //         DeviceUtils.getScaledWidth(context, 5)))),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: DeviceUtils.getScaledHeight(context, 2),
                    horizontal: DeviceUtils.getScaledWidth(context, 3)),
                child: Column(children: [
                  // _buildUserName(),
                  // buildTabWidget(),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context, 1),
                  ),
                  Expanded(
                      child: ValueListenableBuilder(
                    valueListenable:
                        Hive.box<Contact>(contactsBoxName).listenable(),
                    builder: (context, Box<Contact> box, _) {
                      if (box.values.isEmpty)
                        return Center(
                          child: Text("No contacts"),
                        );
                      return ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          Contact? c = box.getAt(index);
                          // String? relationship = relationships[c!.relationship];
                          return InkWell(
                            onLongPress: () {
                              _onWillPopDelete(c.name, () async {
                                DeviceUtils.hideKeyboard(context);
                                Navigator.of(context).pop();
                                await box.deleteAt(index);
                              });
                            },
                            child: TodoListCard(
                              userName: c!.name,
                              desc: c.desc,
                              time: c.time,
                              googleLink: c.googleLink,
                              ontap: () {
                                _onWillPopTaskDetails(
                                  c.name,
                                  c.desc,
                                  c.time,
                                  c.googleLink,
                                  c.image,
                                );

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => AddTodoPage()));
                              },
                            ),
                          );
                          // InkWell(
                          //   onLongPress: () {
                          //     showDialog(
                          //       context: context,
                          //       barrierDismissible: true,
                          //       builder: (_) => AlertDialog(
                          //         content: Text(
                          //           "Do you want to delete ${c.desc}?",
                          //         ),
                          //         actions: <Widget>[
                          //           TextButton(
                          //             child: Text("No"),
                          //             onPressed: () => Navigator.of(context).pop(),
                          //           ),
                          //           TextButton(
                          //             child: Text("Yes"),
                          //             onPressed: () async {
                          //               // Navigator.of(context).pop();
                          //               await box.deleteAt(index);
                          //             },
                          //           ),
                          //         ],
                          //       ),
                          //     );
                          //   },
                          //   child: Card(
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: <Widget>[
                          //           _buildDivider(),
                          //           Text(c!.name),
                          //           _buildDivider(),
                          //           Text(c.desc),
                          //           _buildDivider(),
                          //           Text("Age: ${c.time}"),
                          //           _buildDivider(),
                          //           // Text("Relationship: $relationship"),
                          //           _buildDivider(),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // );
                        },
                      );
                    },
                  ))
                  //     ListView.separated(
                  //   shrinkWrap: true,
                  //   // physics: NeverScrollableScrollPhysics(),
                  //   // itemCount: nameLsit.length,
                  //   itemCount: familyList.length,

                  //   separatorBuilder: (BuildContext context, int index) =>
                  //       SizedBox(
                  //     height: DeviceUtils.getScaledHeight(context, 1.5),
                  //   ),
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return TodoListCard(
                  //       firstName: familyList[index].firstName,
                  //       lastName: familyList[index].desc,
                  //       mobile: familyList[index].date,
                  //       address: familyList[index].googleLink,
                  //       ontap: () {
                  //         _onWillPopPaymentDialog(
                  //             familyList[index].firstName,
                  //             familyList[index].desc,
                  //             familyList[index].date,
                  //             familyList[index].googleLink,
                  //             familyList[index].document);

                  //         // Navigator.push(
                  //         //     context,
                  //         //     MaterialPageRoute(
                  //         //         builder: (context) => AddTodoPage()));
                  //       },
                  //     );
                  //   },
                  // )),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, 5),
          vertical: DeviceUtils.getScaledHeight(context, 3)),
      child: TitleWidget(
        back: true,
        text: AppLocalizations.of(context).translate('family_text'),
      ),
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree

    super.dispose();
  }
}

class Family {
  String firstName;
  String desc;
  String date;
  String googleLink;
  String document;

  Family(this.firstName, this.desc, this.date, this.googleLink, this.document);
}
