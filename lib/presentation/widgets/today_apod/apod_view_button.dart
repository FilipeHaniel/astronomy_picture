import 'package:astronomy_picture/custom_colors.dart';
import 'package:flutter/material.dart';

class ApodViewButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Function()? onTap;

  const ApodViewButton({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 205,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: CustomColors.black,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: CustomColors.white.withOpacity(.6)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: CustomColors.white,
              size: 50,
            ),
            Text(
              title,
              style: TextStyle(color: CustomColors.white, fontSize: 22),
            ),
            Text(
              description,
              style: TextStyle(color: CustomColors.white, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
