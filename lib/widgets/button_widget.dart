// ignore_for_file: deprecated_member_use

import 'package:send_remider_to_user/constants/colors.dart';
import 'package:send_remider_to_user/utils/device/device_utils.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final text, onPressed,borderRadius;

  //final Function? onTap;

  const ButtonWidget({
    Key? key,
    this.text,
    this.onPressed,this.borderRadius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius:borderRadius??
                BorderRadius.circular(DeviceUtils.getScaledWidth(context, 4))),
        primary: AppColors.newButtonColor,
        padding: EdgeInsets.symmetric(
            horizontal: DeviceUtils.getScaledWidth(context, 1),
            vertical: DeviceUtils.getScaledHeight(context, 1.8)),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              text /*AppLocalizations.of(context).translate('intro_get_started')*/,
              overflow: TextOverflow.ellipsis, maxLines: 1,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                  fontSize: DeviceUtils.getScaledWidth(context, 4.5)),
              textAlign: TextAlign.center,
              //  TextStyle(
              //     fontFamily: FontFamily.roboto,
              //     color: Colors.white,
              //     fontWeight: FontWeight.w400,
              //     fontSize: DeviceUtils.getScaledWidth(context, 3.5)),
              // textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
