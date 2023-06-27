import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:send_remider_to_user/constants/colors.dart';
import 'package:send_remider_to_user/constants/keyboardoverlay.dart';
import 'package:send_remider_to_user/data/sharedpref/constants/preferences.dart';
import 'package:send_remider_to_user/responsive.dart';
import 'package:send_remider_to_user/stores/form/form_store.dart';
import 'package:send_remider_to_user/stores/theme/theme_store.dart';
import 'package:send_remider_to_user/utils/device/device_utils.dart';
import 'package:send_remider_to_user/utils/locale/app_localization.dart';
import 'package:send_remider_to_user/widgets/button_widget.dart';
import 'package:send_remider_to_user/widgets/textfeild_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:send_remider_to_user/widgets/title_with_back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  //focus node:-----------------------------------------------------------------
  late FocusNode _flatFocusNode;
  late FocusNode _streetFocusNode;
  late FocusNode _lastNameFocusNode;
  late FocusNode _ageFocusNode;

  //text controllers:-----------------------------------------------------------
  final TextEditingController _emailidController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _alternateContactController =
      TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _flatHouseController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _saveAsController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;

  final _formStore = FormStore();
  FocusNode numberFocusNode = FocusNode();

  final List<String> items = [
    'Pune',
    'Nashik',
    'Mumbai',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  final List<String> addressType = [
    'Home',
    'Temporary',
    'Relatives',
    'Current',
    'Permanant',
    'Hospital',
  ];
  final List<String> relationship = [
    'Mother',
    'Father',
    'Grand Father',
    'Grand Mother',
    'Sister',
    'Brother',
    'Relative',
    'Friend',
  ];
  String? selectedValue;
  String? selectedAddressType;
  String? selectedRelationship;

  String _mobile = '';
  String? _currentAddress;
  Position? _currentPosition;
  bool _isStateError = false;
  String? gender;
  bool _isGenderError = false;
  bool _isAddTypeError = false;
  bool _isRelationshipError = false;

  @override
  void initState() {
    _flatFocusNode = FocusNode();
    _streetFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _ageFocusNode = FocusNode();
    loadData();
    super.initState();
    numberFocusNode.addListener(() {
      bool hasFocus = numberFocusNode.hasFocus;
      if (hasFocus) {
        KeyboardOverlay.showOverlay(context);
      } else {
        KeyboardOverlay.removeOverlay();
      }
    });
  }

  loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _mobile = preferences.getString(Preferences.mobile) ?? '';
    if (_mobile.isNotEmpty && _mobile != null) {
      _contactNumberController.value = TextEditingValue(text: _mobile);
    }
    setState(() {});
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

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        if (place.postalCode!.isNotEmpty && place.postalCode != null) {
          _pinCodeController.value = TextEditingValue(text: place.postalCode!);
        }
        if (place.street!.isNotEmpty && place.street != null) {
          _areaController.value = TextEditingValue(text: place.street!);
        }
        // if (place.subLocality!.isNotEmpty && place.subLocality != null) {
        String flat = place.subLocality!.isNotEmpty &&
                place.subAdministrativeArea!.isNotEmpty &&
                place.thoroughfare!.isNotEmpty
            ? '${place.subLocality!}, ${place.subAdministrativeArea!}, ${place.thoroughfare!}'
            : place.subLocality!.isEmpty &&
                    place.subAdministrativeArea!.isNotEmpty &&
                    place.thoroughfare!.isNotEmpty
                ? '${place.subAdministrativeArea!}, ${place.thoroughfare!}'
                : place.subLocality!.isNotEmpty &&
                        place.subAdministrativeArea!.isEmpty &&
                        place.thoroughfare!.isNotEmpty
                    ? '${place.subLocality!}, ${place.thoroughfare!}'
                    : place.subLocality!.isNotEmpty &&
                            place.subAdministrativeArea!.isNotEmpty &&
                            place.thoroughfare!.isEmpty
                        ? '${place.subLocality!}, ${place.subAdministrativeArea!}'
                        : place.subLocality!.isEmpty &&
                                place.subAdministrativeArea!.isEmpty &&
                                place.thoroughfare!.isNotEmpty
                            ? '${place.thoroughfare!}'
                            : place.subLocality!.isNotEmpty &&
                                    place.subAdministrativeArea!.isEmpty &&
                                    place.thoroughfare!.isEmpty
                                ? '${place.subLocality!}'
                                : place.subLocality!.isEmpty &&
                                        place.subAdministrativeArea!
                                            .isNotEmpty &&
                                        place.thoroughfare!.isEmpty
                                    ? '${place.subAdministrativeArea!}'
                                    : "";
        // : place.subLocality!.isNotEmpty &&
        //         place.subLocality != null &&
        //         place.subAdministrativeArea!.isNotEmpty &&
        //         place.subAdministrativeArea != null &&
        //         place.thoroughfare!.isEmpty &&
        //         place.thoroughfare == null
        //     ? '${place.subLocality!}, ${place.subAdministrativeArea!}'
        //     : place.subLocality!.isEmpty &&
        //             place.subLocality == null &&
        //             place.subAdministrativeArea!.isNotEmpty &&
        //             place.subAdministrativeArea != null &&
        //             place.thoroughfare!.isNotEmpty &&
        //             place.thoroughfare != null
        //         ? '${place.subAdministrativeArea!}, ${place.thoroughfare!}'
        //         : place.subLocality!.isNotEmpty &&
        //                 place.subLocality != null &&
        //                 place.subAdministrativeArea!.isEmpty &&
        //                 place.subAdministrativeArea == null &&
        //                 place.thoroughfare!.isNotEmpty &&
        //                 place.thoroughfare != null
        //             ? '${place.subLocality!}, ${place.thoroughfare!}'
        //             : place.subLocality!.isNotEmpty &&
        //                     place.subLocality != null &&
        //                     place.subAdministrativeArea!.isEmpty &&
        //                     place.subAdministrativeArea == null &&
        //                     place.thoroughfare!.isEmpty &&
        //                     place.thoroughfare == null
        //                 ? '${place.subLocality!}'
        //                 : place.subLocality!.isEmpty &&
        //                         place.subLocality == null &&
        //                         place.subAdministrativeArea!.isNotEmpty &&
        //                         place.subAdministrativeArea != null &&
        //                         place.thoroughfare!.isEmpty &&
        //                         place.thoroughfare == null
        //                     ? '${place.subAdministrativeArea!}'
        //                     : place.subLocality!.isEmpty &&
        //                             place.subLocality == null &&
        //                             place.subAdministrativeArea!.isEmpty &&
        //                             place.subAdministrativeArea == null &&
        //                             place.thoroughfare!.isNotEmpty &&
        //                             place.thoroughfare != null
        //                         ? '${place.thoroughfare!}'
        //                         : '';
        if (flat.isNotEmpty && flat != null) {
          _flatHouseController.value = TextEditingValue(text: flat);
        }
        if (place.locality!.isNotEmpty && place.locality != null) {
          if (items.contains(place.locality!)) {
            selectedValue = place.locality!;
          }
          _formStore.setFlatName(_flatHouseController.text);
          _formStore.setPinCode(_pinCodeController.text);
          _formStore.setStreetName(_areaController.text);
          _formStore.validateFlatName(_flatHouseController.text);
          _formStore.validatePincode(_pinCodeController.text);
          _formStore.validateStreetName(_areaController.text);
          _isStateError = false;
        }
      });
    }).catchError((e) {
      debugPrint(e);
    });
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
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraint) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: constraint.maxHeight),
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
                                              children: [
                                                SizedBox(
                                                  height: DeviceUtils
                                                      .getScaledHeight(
                                                          context, 3),
                                                ),
                                                _buildTodo(),
                                                SizedBox(
                                                  height: DeviceUtils
                                                      .getScaledHeight(
                                                          context, 2),
                                                ),
                                                _button(
                                                    () {},
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            'register_next')),
                                                SizedBox(
                                                  height: DeviceUtils
                                                      .getScaledHeight(
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
                )
              ],
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
        _buildFormLableText(
            AppLocalizations.of(context).translate('register_first_name')),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 1),
        ),
        _buildFirstNameField(),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 2),
        ),
        _buildFormLableText(
            AppLocalizations.of(context).translate('register_desc')),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 1),
        ),
        _buildDescField(),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 2),
        ),
        _buildFormLableText(
            AppLocalizations.of(context).translate('register_select_date')),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 1),
        ),
        _buildDateField(),
        // NumberTextField(),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 2),
        ),
        _button(() {
          myAlert();
        }, AppLocalizations.of(context).translate('register_add_image')),

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
        _button(() async {
          // opens storage to pick files and the picked file or files
          // are assigned into result and if no file is chosen result is null.
          // you can also toggle "allowMultiple" true or false depending on your need
          final result =
              await FilePicker.platform.pickFiles(allowMultiple: false);

          // if no file is picked
          if (result == null) return;
          if (result != null) {
            setState(() {
              file = File(result.files.first.path!);
            });
          } else {
            // User canceled the picker
          }
          // we will log the name, size and path of the
          // first picked file (if multiple are selected)
          print(result.files.first.name);
          print(result.files.first.size);
          print(result.files.first.path);
        }, AppLocalizations.of(context).translate('register_add_image')),

        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 3),
        ),
        file != null ? Text(file!.path) : Container(),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 3),
        ),
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
              hint: AppLocalizations.of(context)
                  .translate('wellness_membership_date_to'),
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
            hint: AppLocalizations.of(context)
                .translate('register_first_name_enter'),
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
            maxLength: 20,
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
              _formStore.setFirstName(value);
              // });
            },
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_lastNameFocusNode);
            },
            errorText: _formStore.formErrorStore.firstName,
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
            focusNode: _lastNameFocusNode,

            padding: EdgeInsets.zero,
            hintColor: AppColors.hintColor,
            hint: AppLocalizations.of(context).translate('register_add_desc'),
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
            maxLength: 20,
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
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_ageFocusNode);
            },
            errorText: _formStore.formErrorStore.lastName,
          ),
        );
      },
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
        text: count == 0
            ? AppLocalizations.of(context).translate('register_yourself')
            : count == 1
                ? AppLocalizations.of(context).translate('contact_details')
                : AppLocalizations.of(context).translate('address'),
      ),
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

  Widget _buildEmailIdField() {
    return Observer(
      builder: (context) {
        return Container(
          /*padding: EdgeInsets.symmetric(
            horizontal: DeviceUtils.getScaledWidth(context, 3.2),
          ),*/
          child: CustomIconTextFieldWidget(
            focusNode: Platform.isIOS ? numberFocusNode : null,
            padding: EdgeInsets.zero,
            hintColor: AppColors.hintColor,
            hint: AppLocalizations.of(context)
                .translate('contact_details_enter_email'),
            inputType: TextInputType.emailAddress,
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
            maxLength: 15,
            iconColor: Colors.black,
            textController: _emailidController,
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
              _formStore.formErrorStore.userEmail = null;
              // });
            },
            errorText: _formStore.formErrorStore.userEmail,
          ),
        );
      },
    );
  }

  // Widget _buildContactNumberField() {
  //   return Observer(
  //     builder: (context) {
  //       return Container(
  //         child: CustomPrefixIconTextFieldWidget(
  //           focusNode: Platform.isIOS ? numberFocusNode : null,
  //           padding: EdgeInsets.zero,
  //           hintColor: AppColors.hintColor,
  //           hint: AppLocalizations.of(context)
  //               .translate('contact_details_number'),
  //           inputType: TextInputType.number,
  //           icon: Icon(
  //             Icons.call,
  //             color: AppColors.blackColor,
  //           ),
  //           isIcon: true,
  //           prefixText: '+91   ',
  //           maxLength: 10,
  //           iconColor: Colors.black,
  //           textController: _contactNumberController,
  //           inputAction: TextInputAction.done,
  //           autoFocus: false,
  //           onChanged: (value) {
  //             _formStore.formErrorStore.mobile = null;
  //           },
  //           errorText: _formStore.formErrorStore.mobile,
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildAlternateContactField() {
    return Observer(
      builder: (context) {
        return Container(
          /*padding: EdgeInsets.symmetric(
            horizontal: DeviceUtils.getScaledWidth(context, 3.2),
          ),*/
          child: CustomIconTextFieldWidget(
            focusNode: Platform.isIOS ? numberFocusNode : null,
            padding: EdgeInsets.zero,
            hintColor: AppColors.hintColor,
            hint: AppLocalizations.of(context)
                .translate('contact_details_alt_contat'),
            inputType: TextInputType.number,
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
            maxLength: 10,
            iconColor: Colors.black,
            textController: _alternateContactController,
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
              _formStore.formErrorStore.mobile = null;
              // });
            },
            errorText: _formStore.formErrorStore.mobile,
          ),
        );
      },
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _toDateController.dispose();
    _firstNameController.dispose();
    _descController.dispose();
    super.dispose();
  }
}
