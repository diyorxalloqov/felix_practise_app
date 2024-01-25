// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:felix_practise_app/core/constants/api.dart';
// import 'package:felix_practise_app/model/login_model.dart';
// import 'package:felix_practise_app/model/register_model.dart';

// class AuthService {
//   Future<Either<String, Registermodel>> register(
//       {required String phone,
//       required String password,
//       required String name,
//       required String lastname}) async {
//     try {
//       Response response = await Dio().post(
//         Api.register,
//         data: {
//           "phone": phone,
//           "password": password,
//           "firstname": name,
//           "lastname": lastname
//         },
//       );
//       if (response.statusCode == 201) {
//         print(response.statusCode);
//         return right(Registermodel.fromJson(response.data));
//       } else {
//         return left(response.statusMessage.toString());
//       }
//     } on DioException catch (e) {
//       print(e.message.toString());

//       print("hi");
//       return left(e.message.toString());
//     }
//   }

//   Future<Either<String, Loginmodel>> login(
//       {required String password, required String name}) async {
//     try {
//       Response response = await Dio().post(
//         Api.login,
//         data: {"phone": name, "password": password},
//       );
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         print(response.data);
//         return right(Loginmodel.fromJson(response.data));
//       } else if (response.statusCode == 404) {
//         print("user malumotlari xato");
//         return left("Login yoki parol xato");
//       } else {
//         return left(response.statusMessage.toString());
//       }
//     } on DioException catch (e) {
//       print("hello");
//       return left(e.message.toString());
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:felix_practise_app/core/constants/api.dart';
import 'package:retrofit/retrofit.dart';
import 'package:felix_practise_app/model/login_model.dart';
import 'package:felix_practise_app/model/register_model.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: Api.api)
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST(Api.register)
  Future<Registermodel> register(
      @Field("phone") String phone,
      @Field("password") String password,
      @Field("firstname") String name,
      @Field("lastname") String lastname);

  @POST(Api.login)
  Future<Loginmodel> login(
      @Field("firstname") String firstname, @Field("password") String password);
}
