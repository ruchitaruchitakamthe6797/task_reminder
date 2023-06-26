import 'package:flutter/cupertino.dart';
import 'package:send_remider_to_user/utils/device/device_utils.dart';

class InputDoneView extends StatelessWidget {
  const InputDoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: CupertinoColors.extraLightBackgroundGray,
        child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                  top: DeviceUtils.getScaledWidth(context, .8),
                  bottom: DeviceUtils.getScaledWidth(context, .8)),
              child: CupertinoButton(
                padding: EdgeInsets.only(
                    right: DeviceUtils.getScaledWidth(context, 6.4),
                    top: DeviceUtils.getScaledWidth(context, 1.3),
                    bottom: DeviceUtils.getScaledWidth(context, 1.3)),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: const Text("Done",
                    style: TextStyle(
                      color: CupertinoColors.activeBlue,
                    )),
              ),
            )));
  }
}
