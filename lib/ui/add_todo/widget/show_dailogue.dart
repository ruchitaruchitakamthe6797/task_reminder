import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:send_remider_to_user/constants/assets.dart';
import 'package:send_remider_to_user/constants/colors.dart';
import 'package:send_remider_to_user/utils/device/device_utils.dart';
import 'package:send_remider_to_user/utils/locale/app_localization.dart';
import 'package:url_launcher/url_launcher.dart';

detailsDialog(
    {BuildContext? context,
    String? userName,
    String? desc,
    String? googleLink,
    String? date,
    String? remdName,
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
            child: DetailsContent(
                userName: userName,
                googleLink: googleLink,
                document: document,
                date: date,
                desc: desc,
                remdName: remdName),
          ),
        ),
      );
    },
  );
}

class DetailsContent extends StatefulWidget {
  final userName, desc, googleLink, document, date, remdName;
  const DetailsContent(
      {Key? key,
      this.userName,
      this.desc,
      this.googleLink,
      this.document,
      this.remdName,
      this.date})
      : super(key: key);

  @override
  State<DetailsContent> createState() => _DetailsContentState();
}

class _DetailsContentState extends State<DetailsContent> {
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextWidget('Task Name : ', widget.remdName),
              SizedBox(height: DeviceUtils.getScaledHeight(context, 2)),
              _buildTextWidget('User Name : ', widget.userName),
              SizedBox(height: DeviceUtils.getScaledHeight(context, 2)),
              _buildTextWidget('Task Details : ', widget.desc),

              SizedBox(height: DeviceUtils.getScaledHeight(context, 2)),
              _buildTextWidget('Date & Time : ', widget.date),

              SizedBox(height: DeviceUtils.getScaledHeight(context, 2)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Google Link : ',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: DeviceUtils.getScaledWidth(context, 4)),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          openURL(widget.googleLink);
                        },
                        child: Text(
                          widget.googleLink,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  fontSize:
                                      DeviceUtils.getScaledWidth(context, 4),
                                  color: Colors.blue),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: DeviceUtils.getScaledHeight(context, 2)),
              // Text(
              //   widget.document,
              //   style: Theme.of(context)
              //       .textTheme
              //       .headline6!
              //       .copyWith(fontSize: DeviceUtils.getScaledWidth(context, 4)),
              //   textAlign: TextAlign.center,
              // ),
              widget.document != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          //to show image, you type like this.
                          File(widget.document!),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(height: DeviceUtils.getScaledHeight(context, 2)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildOk(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    final Uri url = Uri.parse(widget.googleLink);
    // if (!await launchUrl(url)) {
    //   throw Exception('Could not launch $url');
    // }
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // can't launch url
    }
  }

  launchURL() async {
    // await _analytics?.logEvent(name: "foxpe_location_merchant");
    final String url = widget.googleLink;

    final String encodedURl = Uri.encodeFull(url);

    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      print('Could not launch $encodedURl');
      throw 'Could not launch $encodedURl';
    }
  }

  Future<void> openURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
