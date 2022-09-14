import 'package:flutter/material.dart';
import 'package:ritase/shared/theme.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.title,
    this.subTitle = 'Subs',
    this.back = false,
  }) : super(key: key);

  final String title;

  final String subTitle;

  final bool back;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 30,
          left: 24,
          bottom: 24,
        ),
        color: Colors.white,
        child: Row(
          mainAxisAlignment:
              back ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
          children: [
            (back
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  )
                : const SizedBox()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: tPrimaryText.copyWith(
                    fontSize: 22,
                    fontWeight: medium,
                  ),
                ),
                Text(
                  subTitle,
                  style: tGreyText.copyWith(
                    fontWeight: light,
                  ),
                ),
              ],
            ),
            back
                ? SizedBox(width: MediaQuery.of(context).size.width * 0.15)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
