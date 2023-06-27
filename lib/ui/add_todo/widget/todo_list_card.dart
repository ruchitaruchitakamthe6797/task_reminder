import 'package:send_remider_to_user/constants/colors.dart';
import 'package:send_remider_to_user/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TodoListCard extends StatefulWidget {
  final userName, desc, time, googleLink, ontap, remdName;
  const TodoListCard(
      {Key? key,
      this.userName,
      this.desc,
      this.time,
      this.googleLink,
      this.ontap,
      this.remdName})
      : super(key: key);

  @override
  State<TodoListCard> createState() => _TodoListCardState();
}

class _TodoListCardState extends State<TodoListCard> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  String? link;
  loadData() async {
    link = widget.googleLink;
    setState(() {});
  }

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
          onTap: widget.ontap,
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
                        // Container(
                        //     decoration: BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         // color: AppColors.trailingColore,
                        //         border: Border.all(
                        //           color: AppColors.arrowColor,
                        //         )),
                        //     child: Padding(
                        //       padding: EdgeInsets.all(
                        //           DeviceUtils.getScaledWidth(context, 3)),
                        //       child: Icon(
                        //         Icons.perm_identity,
                        //         color: AppColors.violet,
                        //         size: DeviceUtils.getScaledWidth(context, 8),
                        //       ),
                        //     )),
                        SizedBox(
                          width: DeviceUtils.getScaledWidth(context, 4),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTextWidget('Name : ', widget.remdName),
                              SizedBox(
                                height:
                                    DeviceUtils.getScaledHeight(context, .5),
                              ),
                              _buildTextWidget('Task : ', widget.desc),
                              SizedBox(
                                height:
                                    DeviceUtils.getScaledHeight(context, .5),
                              ),
                              _buildTextWidget('Date & Time : ', widget.time),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: DeviceUtils.getScaledWidth(context, 1.5),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> openURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _androidURL() async => await canLaunch(link!)
      ? await launch(link!)
      : throw 'Could not launch $link';
  Widget _buildTextWidget(name, value) {
    return Row(
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
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontSize: DeviceUtils.getScaledWidth(context, 4)),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
