import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:send_remider_to_user/constants/colors.dart';
import 'package:send_remider_to_user/constants/keyboardoverlay.dart';
import 'package:send_remider_to_user/data/sharedpref/constants/preferences.dart';
import 'package:send_remider_to_user/main.dart';
import 'package:send_remider_to_user/responsive.dart';
import 'package:send_remider_to_user/stores/form/form_store.dart';
import 'package:send_remider_to_user/stores/theme/theme_store.dart';
import 'package:send_remider_to_user/utils/device/device_utils.dart';
import 'package:send_remider_to_user/widgets/button_widget.dart';
import 'package:send_remider_to_user/widgets/textfeild_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:send_remider_to_user/widgets/title_with_back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../contacts/contacts.dart';

class AddTodoPage extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  //text controllers:-----------------------------------------------------------
  final TextEditingController _googleMeetController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _reminderTitleController =
      TextEditingController();

  //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;

  final _formStore = FormStore();
  FocusNode numberFocusNode = FocusNode();

  FlutterLocalNotificationsPlugin? _flutterLocalNotificationService;

//   @override
//   void initState() {
//     super.initState();
//     _flutterLocalNotificationService = FlutterLocalNotificationsPlugin();
// var initializationSettingsAndroid= AndroidInitializationSettings('app_icon');
// var initializationSettingsIOS=IOSInitializationSettings();
// initializationSettings=InitializationSettings(initializationSettingsAndroid,initializationSettingsIOS);
//     _flutterLocalNotificationService.initialize(initializationSettings,selectNotification:)
//   }
  FlutterLocalNotificationsPlugin? _local = null;
  @override
  void initState() {
    super.initState();
    _initLocalNotifications();
  }

  Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    _local = FlutterLocalNotificationsPlugin();
    await _local!.initialize(initializationSettings);
  }

  DateTime? scheduleTime;
  Future<void> scheduleNotification() async {
    if (_local == null) {
      return; // Return if _local is not initialized
    }

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      // 'your_channel_description',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Calculate the notification trigger time by adding 15 minutes to the current time
    final scheduledTime = DateTime.now().add(Duration(seconds: 15));

    // Schedule the notification
    await _local!.schedule(
      0, // Notification ID
      notificationTitle,
      notificationBody,
      scheduleTime!,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
    );
  }

  int curStep = 0;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initializing stores
    _themeStore = Provider.of<ThemeStore>(context);

    // final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    // final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map?;

    // curStep = arguments!['curStep'];
  }

  String? notificationTitle;
  String? notificationBody;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: constraint.maxHeight),
                            child: IntrinsicHeight(
                              child: Container(
                                color: AppColors.violetFaint,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              AppColors.violet,
                                              AppColors.violetFaint
                                            ],
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            _buildTitle(),
                                          ],
                                        )),
                                    Expanded(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        //height: MediaQuery.of(context).size.height,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  DeviceUtils.getScaledWidth(
                                                      context, 5)),
                                              topRight: Radius.circular(
                                                  DeviceUtils.getScaledWidth(
                                                      context, 5))),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 25,
                                              offset: Offset(0, 10),
                                            ),
                                          ],
                                          color: Color(0xffFFFFFF),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  DeviceUtils.getScaledWidth(
                                                      context, 6.6)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                height:
                                                    DeviceUtils.getScaledHeight(
                                                        context, 3),
                                              ),
                                              _buildTodo(),
                                              SizedBox(
                                                height:
                                                    DeviceUtils.getScaledHeight(
                                                        context, 2),
                                              ),
                                              _button(() {
                                                if (_firstNameController
                                                        .text.isNotEmpty &&
                                                    _reminderTitleController
                                                        .text.isNotEmpty &&
                                                    _descController
                                                        .text.isNotEmpty &&
                                                    _toDateController
                                                        .text.isNotEmpty &&
                                                    _descController
                                                        .text.isNotEmpty &&
                                                    _googleMeetController
                                                        .text.isNotEmpty) {
                                                  Box<Contact> contactsBox =
                                                      Hive.box<Contact>(
                                                          contactsBoxName);
                                                  contactsBox.add(Contact(
                                                    _firstNameController.text,
                                                    _toDateController.text,
                                                    _descController.text,
                                                    _googleMeetController.text,
                                                    image!.path,
                                                    _reminderTitleController
                                                        .text,
                                                  ));
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    notificationTitle =
                                                        _reminderTitleController
                                                            .text;
                                                    notificationBody =
                                                        _descController.text;
                                                  });
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Reminder saved successfully',
                                                      toastLength:
                                                          Toast.LENGTH_LONG);
                                                  scheduleNotification();
                                                }
                                              }, 'Add Reminder'),
                                              SizedBox(
                                                height:
                                                    DeviceUtils.getScaledHeight(
                                                        context, 2),
                                              ),
                                              // Expanded(
                                              //   child: Padding(
                                              //     padding: EdgeInsets.only(
                                              //         bottom: DeviceUtils
                                              //             .getScaledHeight(
                                              //                 context, 1)),
                                              //     child: Image(
                                              //       image: AssetImage(
                                              //         Assets.spero_logo,
                                              //       ),
                                              //       height: DeviceUtils
                                              //           .getScaledHeight(
                                              //               context, 12),
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildTodo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormLableText('User Name'),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 1),
        ),
        _buildFirstNameField(),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 1),
        ),
        _buildFormLableText('Reminder Title'),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 1),
        ),
        _buildReminderTitleField(),

        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 2),
        ),
        _buildFormLableText('Add Todo Task'),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 1),
        ),
        _buildDescField(),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 2),
        ),
        _buildFormLableText('Add Google Meet Link'),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 1),
        ),
        _buildGoogleMeetLinkField(),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 2),
        ),
        _buildFormLableText('Select Date'),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 1),
        ),
        _buildDateField(),
        // NumberTextField(),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 2),
        ),
        Visibility(
          visible: _addImage == false && image == null,
          child: _buildFormLableText('Add Image'),
        ),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 1),
        ),
        Visibility(
            visible: _addImage == false && image == null,
            child: _buildAddImageField()),
        // _button(() {
        //   myAlert();
        // }, 'Add Image'),

        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 3),
        ),
        image != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    //to show image, you type like this.
                    File(image!.path),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                  ),
                ),
              )
            : Container(),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 3),
        ),
        // _button(() async {
        //   // opens storage to pick files and the picked file or files
        //   // are assigned into result and if no file is chosen result is null.
        //   // you can also toggle "allowMultiple" true or false depending on your need
        //   final result =
        //       await FilePicker.platform.pickFiles(allowMultiple: false);

        //   // if no file is picked
        //   if (result == null) return;
        //   if (result != null) {
        //     setState(() {
        //       file = File(result.files.first.path!);
        //     });
        //   } else {
        //     // User canceled the picker
        //   }
        //   // we will log the name, size and path of the
        //   // first picked file (if multiple are selected)
        //   print(result.files.first.name);
        //   print(result.files.first.size);
        //   print(result.files.first.path);
        // }, 'Add Image'),

        // SizedBox(
        //   height: DeviceUtils.getScaledHeight(context, 3),
        // ),
        // file != null ? Text(file!.path) : Container(),

        // SizedBox(
        //   height: DeviceUtils.getScaledHeight(context, 3),
        // ),
      ],
    );
  }

  File? file;
// FilePickerResult? result = await FilePicker.platform.pickFiles();

// if (result != null) {
//   File file = File(result.files.single.path);
// } else {
//   // User canceled the picker
// }
  bool toDateTimeClick = false;
  bool fromDateTimeClick = false;
  Widget _buildDateField() {
    return Observer(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            _onDateTimeClick();
            setState(() {
              toDateTimeClick = true;
              fromDateTimeClick = false;
            });
          },
          child: AbsorbPointer(
            child: CustomIconTextFieldWidget(
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledWidth(context, 0.7),
                  vertical: DeviceUtils.getScaledHeight(context, 0)),
              isReadOnly: true,
              hint: 'Select Date',
              textfeildBorder: AppColors.cardBorder,
              hintColor: AppColors.textfeildText,
              fontWeight: FontWeight.w400,
              inputType: TextInputType.text,
              icon: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Responsive.isTablet(context)
                        ? DeviceUtils.getScaledWidth(context, 2.6)
                        : DeviceUtils.getScaledWidth(context, 0)),
                child: Icon(
                  Icons.calendar_today_outlined,
                  size: DeviceUtils.getScaledHeight(context, 3),
                  color: _themeStore.darkMode
                      ? Colors.white70
                      : AppColors.blackShade,
                ),
              ),
              //  ImageIcon(
              //   AssetImage(Assets.calendar),
              //   color: _themeStore.darkMode
              //       ? Colors.white70
              //       : AppColors.blackShade,
              // ),
              iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black,
              textController: _toDateController,
              inputAction: TextInputAction.done,
              autoFocus: false,
              errorText: null,
            ),
          ),
        );
      },
    );
  }

  // var dateTime;
  _onDateTimeClick() async {
    DateTime? dateTime = await showOmniDateTimePicker(
      // DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      isForce2Digits: true,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      selectableDayPredicate: (dateTime) {
        // Disable 25th Feb 2023
        if (dateTime == DateTime(2023, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );
    print("dateTime: $dateTime");
    if (dateTime.toString().isNotEmpty &&
        dateTime.toString() != null &&
        dateTime.toString() != "null") {
      String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(dateTime!);
      if (formattedDate.isNotEmpty) {
        if (toDateTimeClick == true) {
          _toDateController.text = formattedDate.toString();
          scheduleTime = dateTime;
        }
        setState(() {});
      } else {}
    }
  }

  Widget _buildFirstNameField() {
    return Observer(
      builder: (context) {
        return Container(
          /*padding: EdgeInsets.symmetric(
            horizontal: DeviceUtils.getScaledWidth(context, 3.2),
          ),*/
          child: CustomIconTextFieldWidget(
            // focusNode: Platform.isIOS ? numberFocusNode : null,
            padding: EdgeInsets.zero,
            hintColor: AppColors.hintColor,
            hint: 'Enter User Name',
            inputType: TextInputType.text,
            // icon: Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: Responsive.isTablet(context)
            //           ? DeviceUtils.getScaledWidth(context, 2.6)
            //           : DeviceUtils.getScaledWidth(context, 0)),
            //   child: Icon(
            //     Icons.call,
            //     color: _themeStore.darkMode
            //         ? Colors.white70
            //         : AppColors.blackShade,
            //     size: DeviceUtils.getScaledWidth(context, 5.4),
            //   ),
            // ),
            // onTap: () {
            //   _tryPasteCurrentPhone();
            // },
            isIcon: true,
            // prefixText: '+91   ',
            // maxLength: 20,
            iconColor: Colors.black,
            textController: _firstNameController,
            inputAction: TextInputAction.done,
            autoFocus: false,

            onChanged: (value) {
              // setState(() {
              //   _tryPasteCurrentPhone();
              // });

              // if(value.toString().isEmpty) {
              // _formStore.setMobile(_firstNameController.text);
              //}

              // setState(() {
              // _formStore.setFirstName(value);
              // });
            },
            // onFieldSubmitted: (value) {
            //   FocusScope.of(context).requestFocus(_lastNameFocusNode);
            // },
            errorText: null,
          ),
        );
      },
    );
  }

  Widget _buildReminderTitleField() {
    return Observer(
      builder: (context) {
        return Container(
          /*padding: EdgeInsets.symmetric(
            horizontal: DeviceUtils.getScaledWidth(context, 3.2),
          ),*/
          child: CustomIconTextFieldWidget(
            // focusNode: Platform.isIOS ? numberFocusNode : null,
            padding: EdgeInsets.zero,
            hintColor: AppColors.hintColor,
            hint: 'Add Reminder Title',
            inputType: TextInputType.text,
            // icon: Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: Responsive.isTablet(context)
            //           ? DeviceUtils.getScaledWidth(context, 2.6)
            //           : DeviceUtils.getScaledWidth(context, 0)),
            //   child: Icon(
            //     Icons.call,
            //     color: _themeStore.darkMode
            //         ? Colors.white70
            //         : AppColors.blackShade,
            //     size: DeviceUtils.getScaledWidth(context, 5.4),
            //   ),
            // ),
            // onTap: () {
            //   _tryPasteCurrentPhone();
            // },
            isIcon: true,
            // prefixText: '+91   ',
            // maxLength: 20,
            iconColor: Colors.black,
            textController: _reminderTitleController,
            inputAction: TextInputAction.done,
            autoFocus: false,

            onChanged: (value) {
              // setState(() {
              //   _tryPasteCurrentPhone();
              // });

              // if(value.toString().isEmpty) {
              // _formStore.setMobile(_firstNameController.text);
              //}

              // setState(() {
              _formStore.setFirstName(value);
              // });
            },
            // onFieldSubmitted: (value) {
            //   FocusScope.of(context).requestFocus(_lastNameFocusNode);
            // },
            errorText: null,
          ),
        );
      },
    );
  }

  Widget _buildDescField() {
    return Observer(
      builder: (context) {
        return Container(
          /*padding: EdgeInsets.symmetric(
            horizontal: DeviceUtils.getScaledWidth(context, 3.2),
          ),*/
          child: CustomIconTextFieldWidget(
            padding: EdgeInsets.zero,
            hintColor: AppColors.hintColor,
            hint: 'Add Task',
            inputType: TextInputType.text,

            // icon: Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: Responsive.isTablet(context)
            //           ? DeviceUtils.getScaledWidth(context, 2.6)
            //           : DeviceUtils.getScaledWidth(context, 0)),
            //   child: Icon(
            //     Icons.call,
            //     color: _themeStore.darkMode
            //         ? Colors.white70
            //         : AppColors.blackShade,
            //     size: DeviceUtils.getScaledWidth(context, 5.4),
            //   ),
            // ),
            // onTap: () {
            //   _tryPasteCurrentPhone();
            // },
            isIcon: true,
            // prefixText: '+91   ',
            // maxLength: 20,
            iconColor: Colors.black,
            textController: _descController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            onChanged: (value) {
              // setState(() {
              //   _tryPasteCurrentPhone();
              // });

              // if(value.toString().isEmpty) {
              // _formStore.setMobile(_firstNameController.text);
              //}

              // setState(() {
              _formStore.setLastName(value);

              // });
            },

            errorText: null,
          ),
        );
      },
    );
  }

  Widget _buildGoogleMeetLinkField() {
    return Observer(
      builder: (context) {
        return Container(
          /*padding: EdgeInsets.symmetric(
            horizontal: DeviceUtils.getScaledWidth(context, 3.2),
          ),*/
          child: CustomIconTextFieldWidget(
            padding: EdgeInsets.zero,
            hintColor: AppColors.hintColor,
            hint: 'Add Google Meet Link',
            inputType: TextInputType.text,

            isIcon: true,
            // prefixText: '+91   ',
            // maxLength: 20,
            iconColor: Colors.black,
            textController: _googleMeetController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            onChanged: (value) {
              _formStore.setLastName(value);
            },

            errorText: null,
          ),
        );
      },
    );
  }

  bool _addImage = false;
  Widget _buildAddImageField() {
    return GestureDetector(
      onTap: () {
        myAlert();
        setState(() {
          _addImage == true;
        });
      },
      child: AbsorbPointer(
        child: Observer(
          builder: (context) {
            return Container(
              /*padding: EdgeInsets.symmetric(
                horizontal: DeviceUtils.getScaledWidth(context, 3.2),
              ),*/
              child: CustomIconTextFieldWidget(
                padding: EdgeInsets.zero,
                hintColor: AppColors.hintColor,
                hint: 'Select Image',
                inputType: TextInputType.text,

                isIcon: true,
                // prefixText: '+91   ',
                // maxLength: 20,
                iconColor: Colors.black,
                textController: _imageController,
                inputAction: TextInputAction.done,
                autoFocus: false,
                onChanged: (value) {
                  _formStore.setLastName(value);
                },

                errorText: null,
              ),
            );
          },
        ),
      ),
    );
  }

  int count = 0;
  Widget _button(ontap, text) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, 7)),
      child: ButtonWidget(onPressed: ontap, text: text),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, 5),
          vertical: DeviceUtils.getScaledHeight(context, 3)),
      child: TitleWidget(
          back: true,
          ontap: () {
            if (count != 0) {
              setState(() {
                count--;
              });
            } else if (count == 0) {}
            DeviceUtils.hideKeyboard(context);
            Navigator.of(context).pop();
          },
          text: 'Add Task'),
    );
  }

  Widget _buildFormLableText(text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.subtitle2!.copyWith(
          fontSize: DeviceUtils.getScaledWidth(context, 3.5),
          color: AppColors.textfeildText),
      textAlign: TextAlign.center,
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _toDateController.dispose();
    _firstNameController.dispose();
    _descController.dispose();
    _googleMeetController.dispose();
    _imageController.dispose();
    _reminderTitleController.dispose();
    super.dispose();
  }
}
