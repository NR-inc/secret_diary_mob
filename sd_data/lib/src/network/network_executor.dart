import 'package:dio/dio.dart';
import 'package:sddomain/core/error_handler.dart';
import 'package:sddomain/exceptions/network_exception.dart';

class NetworkExecutor {
  ErrorHandler _errorHandler;

  NetworkExecutor(this._errorHandler);

  Stream<dynamic> makeRequest(Dio dio) async* {
    Response response;
    try {
      response = await dio.post('');
      if (response.data != null) {
        final data = response.data['data'];
        if (data != null) {
          yield data;
        } else {
          _errorHandler.handleError(response.data);
        }
      } else {
        throw NetworkException(
            statusCode: response.statusCode);
      }
    } on dynamic catch (ex) {
      _errorHandler.handleNetworkError(ex);
    }
  }
}
