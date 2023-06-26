// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:send_remider_to_user/responsive.dart';
import 'package:send_remider_to_user/utils/device/device_utils.dart';
import 'package:send_remider_to_user/widgets/back_button_widget.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final text, back, ontap;
  const TitleWidget({Key? key, required this.text, this.back, this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Row(
      children: [
        BackButtonWidget(back: back, ontap: ontap),
        SizedBox(
          width: DeviceUtils.getScaledWidth(context, 5),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: Responsive.isTablet(context)
                    ? DeviceUtils.getScaledWidth(context, 5.25)
                    : DeviceUtils.getScaledWidth(context, 6.25),
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
