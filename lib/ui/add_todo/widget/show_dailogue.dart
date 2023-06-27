import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:send_remider_to_user/constants/assets.dart';
import 'package:send_remider_to_user/constants/colors.dart';
import 'package:send_remider_to_user/utils/device/device_utils.dart';
import 'package:send_remider_to_user/utils/locale/app_localization.dart';

showOfferPaymentDialog(
    {BuildContext? context,
    String? userName,
    String? desc,
    String? googleLink,
    String? date,
    String? document}) {
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
            child: PaymentContent(
              userName: userName,
              googleLink: googleLink,
              document: document,
              date: date,
              desc: desc,
            ),
          ),
        ),
      );
    },
  );
}

class PaymentContent extends StatefulWidget {
  final userName, desc, googleLink, document, date;
  const PaymentContent(
      {Key? key,
      this.userName,
      this.desc,
      this.googleLink,
      this.document,
      this.date})
      : super(key: key);

  @override
  State<PaymentContent> createState() => _PaymentContentState();
}

class _PaymentContentState extends State<PaymentContent> {
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
            vertical: DeviceUtils.getScaledHeight(context, 2.2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.userName,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: DeviceUtils.getScaledWidth(context, 4)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: DeviceUtils.getScaledHeight(context, 2)),
            Text(
              widget.desc,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: DeviceUtils.getScaledWidth(context, 4)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: DeviceUtils.getScaledHeight(context, 2)),
            Text(
              widget.googleLink,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: DeviceUtils.getScaledWidth(context, 4)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: DeviceUtils.getScaledHeight(context, 2)),
            Text(
              widget.document,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: DeviceUtils.getScaledWidth(context, 4)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: DeviceUtils.getScaledHeight(context, 2)),
            _buildOk(context),
          ],
        ),
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
