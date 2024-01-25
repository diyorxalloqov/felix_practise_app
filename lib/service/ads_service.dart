import 'package:dio/dio.dart';
import 'package:felix_practise_app/core/constants/api.dart';
import 'package:felix_practise_app/model/adsModel.dart';
import 'package:retrofit/http.dart';

part 'ads_service.g.dart';

@RestApi(baseUrl: Api.api)
abstract class AdsService {
  factory AdsService(Dio dio, {String baseUrl}) = _AdsService;

  @POST(Api.ads)
  Future<AdsModel> ads(
      @Field("title") String title,
      @Field("description") String description,
      @Field("lat") String lat,
      @Field("lot") String long);
}
