import 'package:easy_localization/easy_localization.dart';
import 'package:felix_practise_app/core/constants/app_images.dart';
import 'package:felix_practise_app/core/utils/size.dart';
import 'package:felix_practise_app/core/utils/status.dart';
import 'package:felix_practise_app/view/auth/login_page.dart';
import 'package:felix_practise_app/view/pages/map_page.dart';
import 'package:felix_practise_app/view_model/bloc/practise_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;

  bool passwordVisibile = true;
  bool passconfirmVisible = true;

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a password";
    }

    if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
      return "Parolda kamida bitta harf qatnashishi kerak";
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Parolda kamida bitta son qatnashishi kerak";
    }

    return null;
  }

  @override
  void initState() {
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(AppImages.back)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'name'.tr(),
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
                        controller: _nameController,
                        decoration: InputDecoration(
                            hintText: 'name_prop'.tr(),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6))),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'lastname'.tr(),
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
                        controller: _lastNameController,
                        decoration: InputDecoration(
                            hintText: 'lastname_prop'.tr(),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6))),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'phone'.tr(),
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
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          MaskTextInputFormatter(
                            mask: '+000 00 000 00 00',
                            filter: {'0': RegExp(r'[0-9]')},
                          )
                        ],
                        decoration: InputDecoration(
                          hintText: 'phone_prop'.tr(),
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                style: BorderStyle.solid, width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'pass'.tr(),
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
                        controller: _passwordController,
                        obscureText: passwordVisibile,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                            suffixIcon: Visibility(
                                child: IconButton(
                                    onPressed: () {
                                      passwordVisibile = !passwordVisibile;
                                      setState(() {});
                                    },
                                    icon: passwordVisibile
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility))),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF949CA9),
                            ),
                            hintText: "pass_prop".tr()),
                        validator: (value) {
                          String? passwordError = validatePassword(value);
                          if (value == null) {
                            return "isEmpty_prop".tr();
                          } else if (value.length < 4) {
                            return "pass_prop".tr();
                          } else if (passwordError != null) {
                            return passwordError;
                          } else if (value.length > 16) {
                            return "pass_yaroqsiz".tr();
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'pass_confirm'.tr(),
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
                        controller: _passwordConfirmController,
                        obscureText: passconfirmVisible,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                            suffixIcon: Visibility(
                                child: IconButton(
                                    onPressed: () {
                                      passconfirmVisible = !passconfirmVisible;
                                      setState(() {});
                                    },
                                    icon: passconfirmVisible
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility))),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF949CA9),
                            ),
                            hintText: "pass_confirm_prop".tr()),
                      ),
                    ),
                    const SizedBox(height: 5),
                    BlocListener<PractiseBloc, PractiseState>(
                      listener: (context, state) {
                        if (state.registerMessage.isNotEmpty) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MapsPage()),
                              (route) => false);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.registerMessage)));
                        }
                      },
                      child: ElevatedButton(
                          onPressed: () {
                            context.read<PractiseBloc>().add(RegisteEvent(
                                name: _nameController.text,
                                lastName: _lastNameController.text,
                                phone:
                                    _phoneController.text.replaceAll(' ', ''),
                                password: _passwordController.text));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xAD00001F)),
                          child: Center(
                            child: context.read<PractiseBloc>().state.status ==
                                    ActionStatus.isLoading
                                ? const CircularProgressIndicator.adaptive()
                                : Text(
                                    'save'.tr(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily:
                                          GoogleFonts.mulish().fontFamily,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          )),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: Center(
                          child: Text('accaunt_prop'.tr()),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
