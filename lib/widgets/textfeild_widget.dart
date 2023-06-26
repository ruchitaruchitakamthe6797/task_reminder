// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:send_remider_to_user/constants/colors.dart';
import 'package:send_remider_to_user/responsive.dart';
import 'package:send_remider_to_user/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomIconTextFieldWidget extends StatelessWidget {
  final Widget? icon;
  final String? hint;
  final String? errorText;
  final bool isObscure;
  final bool isReadOnly;
  final int maxLength;
  final bool isPrefixText;
  final String prefixText;
  final String? suffixText;
  final bool isIcon;
  final TextInputType? inputType;
  final List<TextInputFormatter> inputFormatter;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final double arrowsWidth;
  final double arrowsHeight;
  final FontWeight? fontWeight;
  final FontWeight? textFontWeight;
  final Color? suffixTextColor;
  final Color? textColor;
  final Color iconColor, textfeildBorder;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onChanged;
  final bool autoFocus;
  final TextInputAction? inputAction;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      /* decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          width: 1,
          color: Colors.grey.shade300,
          style: BorderStyle.solid,
        ),
      ),*/
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        readOnly: isReadOnly,
        controller: textController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        autofocus: autoFocus,
        textInputAction: inputAction,
        obscureText: isObscure,
        maxLength: maxLength,
        keyboardType: inputType,
        inputFormatters: inputFormatter,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontWeight: textFontWeight,
            fontSize: DeviceUtils.getScaledWidth(context, 3.5),
            color: textColor),
        //style: Theme.of(context).textTheme.bodyText1,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // contentPadding: Responsive.isTablet(context) && _size.height < 1000
          //     ? EdgeInsets.symmetric(
          //         vertical: DeviceUtils.getScaledHeight(context, 2.2),
          //       )
          //     : Responsive.isTablet(context)
          //         ? EdgeInsets.symmetric(
          //             vertical: DeviceUtils.getScaledHeight(context, 1.7),
          //           )
          //         : _size.width > 500 && _size.height > 1100
          //             ? EdgeInsets.symmetric(
          //                 vertical: DeviceUtils.getScaledHeight(context, 2),
          //               )
          //             : EdgeInsets.zero,

          // contentPadding: EdgeInsets.symmetric(vertical: DeviceUtils.getScaledHeight(context, 1.6)),
          isDense: true,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textfeildBorder, width: 1.0),
            borderRadius: BorderRadius.circular(Responsive.isTablet(context)
                ? DeviceUtils.getScaledWidth(context, 1)
                : 10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textfeildBorder, width: 1.0),
            borderRadius: BorderRadius.circular(Responsive.isTablet(context)
                ? DeviceUtils.getScaledWidth(context, 1)
                : 10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(
                Responsive.isTablet(context)
                    ? DeviceUtils.getScaledWidth(context, 1)
                    : 10.0)),
            borderSide: BorderSide(color: textfeildBorder, width: 1.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(
                Responsive.isTablet(context)
                    ? DeviceUtils.getScaledWidth(context, 1)
                    : 10.0)),
            borderSide: BorderSide(color: textfeildBorder, width: 1.0),
          ),
          errorStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: AppColors.noteColor,
              fontSize: DeviceUtils.getScaledWidth(context, 3)),
          //contentPadding: EdgeInsets.zero,
          /* border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),*/
          suffixIconConstraints: BoxConstraints(
              maxHeight: arrowsHeight + 3, maxWidth: arrowsWidth),
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: hintColor,
              fontWeight: fontWeight,
              fontSize: DeviceUtils.getScaledWidth(context, 3.5)),
          errorText: errorText,
          counterText: '',
          prefixIcon: icon, iconColor: AppColors.blackColor,
          prefixText: prefixText,
          prefixStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: DeviceUtils.getScaledWidth(context, 3.5)),
          // suffixText: suffixText,
          // suffixIcon: Padding(
          //   padding: EdgeInsets.only(
          //       right: DeviceUtils.getScaledWidth(context, 3.5)),
          //   child: Align(
          //     alignment: Alignment.centerRight,
          //     widthFactor: 1.0,
          //     heightFactor: 1.0,
          //     child: Text(
          //       suffixText!.isNotEmpty ? suffixText! : '',
          //       style: Theme.of(context).textTheme.subtitle1!.copyWith(
          //           color: suffixTextColor ?? Colors.transparent,
          //           fontSize: DeviceUtils.getScaledWidth(context, 3.5)),
          //     ),
          //   ),
          // ),
          // suffixStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
          //     color: suffixTextColor,
          //     fontSize: DeviceUtils.getScaledWidth(context, 3.5)),
          //icon: this.isIcon ? Icon(this.icon, color: iconColor) : null
        ),
      ),
    );
  }

  const CustomIconTextFieldWidget({
    Key? key,
    this.icon,
    required this.errorText,
    required this.textController,
    this.inputType,
    this.inputFormatter = const [],
    this.hint,
    this.isObscure = false,
    this.isReadOnly = false,
    this.isPrefixText = false,
    this.prefixText = '',
    this.maxLength = 50,
    this.isIcon = true,
    this.suffixText = '',
    this.fontWeight,
    this.textFontWeight,
    this.suffixTextColor,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = AppColors.hintColor,
    this.textColor = AppColors.blackColor,
    this.iconColor = Colors.grey,
    this.arrowsWidth = 24,
    this.arrowsHeight = kMinInteractiveDimension,
    this.focusNode,
    this.onFieldSubmitted,
    this.textfeildBorder = AppColors.textfeildBorder,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
    TextStyle? style,
  }) : super(key: key);
}
