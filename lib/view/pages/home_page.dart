import 'package:easy_localization/easy_localization.dart';
import 'package:felix_practise_app/core/constants/app_icons.dart';
import 'package:felix_practise_app/core/constants/app_images.dart';
import 'package:felix_practise_app/core/utils/size.dart';
import 'package:felix_practise_app/view/auth/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.height * .1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcons.location),
                const SizedBox(width: 10),
                Text(
                  "findsport".tr(),
                  style: TextStyle(
                      fontSize: 36,
                      fontFamily: GoogleFonts.k2d().fontFamily,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: context.height * .1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    "lang".tr(),
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: GoogleFonts.mulish().fontFamily,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                ExpansionTile(
                  title: Text('lang_ch'.tr()),
                  tilePadding: const EdgeInsets.symmetric(horizontal: 50),
                  leading: Image.asset(AppImages.uzb),
                  shape: const RoundedRectangleBorder(side: BorderSide.none),
                  children: [
                    TextButton(
                        onPressed: () {
                          context.setLocale(const Locale('uz'));
                        },
                        child: Text('ozbek'.tr())),
                    TextButton(
                        onPressed: () {
                          context.setLocale(const Locale('ru'));
                        },
                        child: Text('rus'.tr())),
                    TextButton(
                        onPressed: () {
                          context.setLocale(const Locale('ru', 'Cyrl'));
                        },
                        child: Text('kiril'.tr()))
                  ],
                ),
              ],
            ),
            SizedBox(height: context.height * 0.05),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
              shape: const OvalBorder(),
              backgroundColor: Colors.black,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()));
              },
              child: const Icon(Icons.arrow_forward, color: Colors.white)),
          SizedBox(
            height: context.bottom + 30,
          )
        ],
      ),
    );
  }
}
