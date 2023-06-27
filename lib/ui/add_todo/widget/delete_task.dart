import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:send_remider_to_user/constants/colors.dart';
import 'package:send_remider_to_user/utils/device/device_utils.dart';
import 'package:send_remider_to_user/utils/locale/app_localization.dart';

deleteTaskDialog({BuildContext? context, String? remdTitle, final ontap}) {
  showDialog(
    barrierDismissible: false,
    context: context!,
    builder: (context) {
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: DeleteTask(
                ontap: ontap,
                remdTitle: remdTitle,
              )),
        ),
      );
    },
  );
}

class DeleteTask extends StatefulWidget {
  final remdTitle, ontap;
  const DeleteTask({
    Key? key,
    this.remdTitle,
    this.ontap,
  }) : super(key: key);

  @override
  State<DeleteTask> createState() => _DeleteTaskState();
}

class _DeleteTaskState extends State<DeleteTask> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initializing stores
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(20),
      //   // color: Colors.red,
      // ),
      // padding: EdgeInsets.symmetric(horizontal:DeviceUtils.getScaledWidth(context, 10.2)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: DeviceUtils.getScaledWidth(context, 10),
            vertical: DeviceUtils.getScaledHeight(context, 2.2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: DeviceUtils.getScaledHeight(context, 2)),
            Text(
              "Do you want to delete ${widget.remdTitle}",
            ),
            SizedBox(height: DeviceUtils.getScaledHeight(context, 4)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text("No"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Expanded(
                      child: TextButton(
                          child: Text("Yes"), onPressed: widget.ontap)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextWidget(name, value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: DeviceUtils.getScaledWidth(context, 4)),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontSize: DeviceUtils.getScaledWidth(context, 4)),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOk(BuildContext context) {
    return ElevatedButton(
      // style: ElevatedButton.styleFrom(
      //   primary: Colors.black,
      //   minimumSize: const Size.fromHeight(50), // NEW
      // ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        primary: AppColors.appBlue,
        //  minimumSize:  Size.fromWidth(50),
        padding: EdgeInsets.symmetric(
            horizontal: DeviceUtils.getScaledWidth(context, 30),
            vertical: DeviceUtils.getScaledHeight(context, 1.8)),
      ),
      onPressed: () {
        DeviceUtils.hideKeyboard(context);
        Navigator.of(context).pop();
      },
      child: Text(
        AppLocalizations.of(context).translate('address_done'),
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
            color: Colors.white,
            fontSize: DeviceUtils.getScaledWidth(context, 3.5)),
        textAlign: TextAlign.center,
      ),
    );
  }
}
