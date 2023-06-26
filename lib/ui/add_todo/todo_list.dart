import 'package:send_remider_to_user/constants/colors.dart';
import 'package:send_remider_to_user/data/sharedpref/constants/preferences.dart';
import 'package:send_remider_to_user/stores/form/form_store.dart';
import 'package:send_remider_to_user/stores/theme/theme_store.dart';
import 'package:send_remider_to_user/ui/add_todo/add_todo.dart';
import 'package:send_remider_to_user/ui/add_todo/widget/todo_list_card.dart';
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

class _TodoListScreenState extends State<TodoListScreen> {
  //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;

  final _formStore = FormStore();

  String _mobile = '';

  int selectedButton = 0;

  @override
  void initState() {
    loadData();
    super.initState();
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
    Family('Ruchita', 'Kamthe',
        'Building no, Street, Area, State, Country, Pin', '7437347483'),
    Family('Shabana', 'Sayyad',
        'Building no, Street, Area, State, Country, Pin', '7437347483'),
    Family('Rohit', 'Adhav', 'Building no, Street, Area, State, Country, Pin',
        '7437347659'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      Expanded(child: _buildFamilyListContent()),
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
      ),
    );
  }

  Widget _buildFamilyListContent() {
    return Container(
      color: AppColors.violetFaint,
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.violet, AppColors.violetFaint],
                ),
              ),
              child: _buildTitle()),
          // SizedBox(
          //   height: DeviceUtils.getScaledHeight(context, 2),
          // ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          DeviceUtils.getScaledWidth(context, 5)),
                      topRight: Radius.circular(
                          DeviceUtils.getScaledWidth(context, 5)))),
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
                      child: ListView.separated(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    // itemCount: nameLsit.length,
                    itemCount: familyList.length,

                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: DeviceUtils.getScaledHeight(context, 1.5),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return TodoListCard(
                        firstName: familyList[index].firstName,
                        lastName: familyList[index].lastName,
                        mobile: familyList[index].number,
                        address: familyList[index].addres,
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddTodoPage()));
                        },
                      );
                    },
                  )),
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
  String lastName;
  String addres;
  String number;

  Family(this.firstName, this.lastName, this.addres, this.number);
}
