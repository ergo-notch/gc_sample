import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sample/core/network/http-client/http_client_service_impl.dart';
import 'package:sample/features/details/di/details_module.dart' as details;
import 'package:sample/features/home/di/home_module.dart' as home;
import '../network/http-client/http_client_service.dart';
import '../network/network_module.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //=======================
  // Network
  //=======================
  sl.registerSingleton<Dio>(NetworkModule.provideDio());

  sl.registerLazySingleton<HttpClientService>(
      () => HttpClientServiceImpl(dio: sl<Dio>()));

  home.initModule();
  details.initModule();
}
