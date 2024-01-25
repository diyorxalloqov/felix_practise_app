import 'package:easy_localization/easy_localization.dart';
import 'package:felix_practise_app/core/constants/app_icons.dart';
import 'package:felix_practise_app/core/utils/size.dart';
import 'package:felix_practise_app/view/pages/google_map.dart';
import 'package:felix_practise_app/view_model/bloc/practise_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        leading:
            IconButton(onPressed: () {}, icon: SvgPicture.asset(AppIcons.x)),
        title: Text(
          'ads'.tr(),
          style: TextStyle(
            fontSize: 16,
            fontFamily: GoogleFonts.mulish().fontFamily,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<PractiseBloc>().add(SaveLatLongDb());
              },
              icon: SvgPicture.asset(AppIcons.right))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'title'.tr(),
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: GoogleFonts.mulish().fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: context.height * 0.06,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'product_title'.tr(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6))),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'des'.tr(),
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: GoogleFonts.mulish().fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: 'des_prop'.tr(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Colors.black,
                          height: 10,
                          endIndent: 20,
                        ),
                      ),
                      Text(
                        "ch_location".tr(),
                        style: TextStyle(
                          color: const Color(0xFF01001F),
                          fontSize: 12,
                          fontFamily: GoogleFonts.mulish().fontFamily,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Colors.black,
                          height: 10,
                          indent: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'addres'.tr(),
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: GoogleFonts.mulish().fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: context.height * 0.07,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'address_prop'.tr(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6))),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                    height: context.height * 0.34,
                    width: context.width,
                    child: GoogleMapPage(
                        description: _descriptionController.text,
                        title: _titleController.text))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
