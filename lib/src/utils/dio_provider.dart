import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Dio> dio(Ref ref) async {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3000', // Android Emulator localhost
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  final appDocDir = await getApplicationDocumentsDirectory();
  final cookieJar = PersistCookieJar(storage: FileStorage("${appDocDir.path}/.cookies/"));
  
  dio.interceptors.add(CookieManager(cookieJar));
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  return dio;
}
