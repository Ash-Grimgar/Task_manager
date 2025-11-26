import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/text-strings.dart';
class FileMenuWidget extends StatelessWidget {
  const FileMenuWidget({
    super.key,
    required this.title,
    this.textColor,
    required this.OnPress,
    required this.icon,
    this.endIcon = true,
  });

  final String title;
  final IconData icon;
  final VoidCallback OnPress;
  final Color? textColor;
  final bool endIcon;

  @override
  Widget build(BuildContext context) {

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? tPrimaryColor : tAccentColorDark;

    return ListTile(
      onTap: OnPress,
      leading: Container(
        width: 30,
        height: 40,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        tMenu1,
        style: Theme.of(context).textTheme.bodyMedium?.apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(
          LineAwesomeIcons.angle_right_solid,
          size: 10.0,
          color: Colors.grey,
        ),
      )
          : null,
    );
  }
}
