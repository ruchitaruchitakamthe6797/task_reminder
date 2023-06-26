import 'package:send_remider_to_user/constants/colors.dart';
import 'package:send_remider_to_user/utils/device/device_utils.dart';
import 'package:send_remider_to_user/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

class TodoListCard extends StatelessWidget {
  final firstName, lastName, mobile, address, ontap;
  const TodoListCard(
      {Key? key,
      this.firstName,
      this.lastName,
      this.mobile,
      this.address,
      this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        color: AppColors.locationBGColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(DeviceUtils.getScaledWidth(context, 2)),
        ),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.addressListCardColor,
                borderRadius: BorderRadius.circular(
                    DeviceUtils.getScaledWidth(context, 2))),
            child: Padding(
              padding: EdgeInsets.all(DeviceUtils.getScaledWidth(context, 3)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // color: AppColors.trailingColore,
                                border: Border.all(
                                  color: AppColors.arrowColor,
                                )),
                            child: Padding(
                              padding: EdgeInsets.all(
                                  DeviceUtils.getScaledWidth(context, 3)),
                              child: Icon(
                                Icons.perm_identity,
                                color: AppColors.violet,
                                size: DeviceUtils.getScaledWidth(context, 8),
                              ),
                            )),
                        SizedBox(
                          width: DeviceUtils.getScaledWidth(context, 4),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$firstName $lastName',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        fontSize: DeviceUtils.getScaledWidth(
                                            context, 4),
                                        fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height:
                                    DeviceUtils.getScaledHeight(context, .5),
                              ),
                              Text(
                                address,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        fontSize: DeviceUtils.getScaledWidth(
                                            context, 3.5)),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height:
                                    DeviceUtils.getScaledHeight(context, .5),
                              ),
                              Text(
                                mobile.toString().isEmpty
                                    ? '${AppLocalizations.of(context).translate('contact')} +91 '
                                    : '${AppLocalizations.of(context).translate('contact')} +91 ${mobile.substring(0, 5)} ${mobile.substring(5, 10)}',
                                // overflow: TextOverflow.ellipsis,
                                // maxLines: 4,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        fontSize: DeviceUtils.getScaledWidth(
                                            context, 3.5)),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: DeviceUtils.getScaledWidth(context, 1.5),
                  ),
                  InkWell(
                    onTap: ontap,
                    // splashColor: Theme.of(context).primaryColorLight,
                    child: Ink(
                      child: Icon(
                        Icons.edit,
                        color: AppColors.violet,
                        size: DeviceUtils.getScaledWidth(context, 8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
