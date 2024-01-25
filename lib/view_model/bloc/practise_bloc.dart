import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:felix_practise_app/core/constants/keys.dart';
import 'package:felix_practise_app/core/utils/status.dart';
import 'package:felix_practise_app/model/adsModel.dart';
import 'package:felix_practise_app/model/register_model.dart';
import 'package:felix_practise_app/service/ads_service.dart';
import 'package:felix_practise_app/service/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'practise_event.dart';
part 'practise_state.dart';

class PractiseBloc extends Bloc<PractiseEvent, PractiseState> {
  final AuthService authService;
  final AdsService adsService;
  PractiseBloc(this.authService, this.adsService)
      : super(const PractiseState()) {
    on<LoginEvent>(_login);
    on<RegisteEvent>(_register);
    on<SendApiAdress>(_getdata);
    on<SaveLatLongDb>(_savelatlong);
  }

  FutureOr<void> _login(LoginEvent event, Emitter<PractiseState> emit) async {
    try {
      // const FlutterSecureStorage().write(key: Keys.token, value: res.token);
      emit(state.copyWith(isLoggedin: true));
    } on DioException catch (e) {
      print('Error occurred during login: ${e.message}');
      emit(state.copyWith(isLoggedin: false, error: e.message.toString()));
    }
  }

  FutureOr<void> _register(
      RegisteEvent event, Emitter<PractiseState> emit) async {
    try {
      emit(state.copyWith(status: ActionStatus.isLoading));
      Registermodel res = await authService.register(
          event.phone, event.password, event.name, event.lastName);
      print(res);
      emit(state.copyWith(
          status: ActionStatus.isSuccess, registerMessage: res.message));
    } on DioException catch (e) {
      emit(state.copyWith(
          status: ActionStatus.isError, error: e.message.toString()));

      print('Error occurred during registration: $e');
    }
  }

  FutureOr<void> _getdata(
      SendApiAdress event, Emitter<PractiseState> emit) async {
    try {
      emit(state.copyWith(status: ActionStatus.isLoading));
      AdsModel res = await adsService.ads(
          event.title, event.description, event.lat, event.long);
      emit(state.copyWith(latitude: event.lat, longtitude: event.long));
    } on DioException catch (e) {
      emit(state.copyWith(status: ActionStatus.isError, error: e.message));
    }
  }

  FutureOr<void> _savelatlong(
      SaveLatLongDb event, Emitter<PractiseState> emit) {
    if (state.latitude.isNotEmpty && state.longtitude.isNotEmpty) {
      const FlutterSecureStorage()
          .write(key: Keys.longtitude, value: state.longtitude);
      const FlutterSecureStorage()
          .write(key: Keys.latitude, value: state.latitude);
    }
  }
}
