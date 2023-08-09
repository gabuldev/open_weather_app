typedef JSON = Map<String, dynamic>;

typedef Success = ({Object? data, int? statusCode});

typedef Failure = ({
  Object? exception,
  Object? errorData,
  String? message,
  int? statusCode,
});

class HttpStatus {
  final Success? success;
  final Failure? failure;

  HttpStatus({
    this.success,
    this.failure,
  });
}
