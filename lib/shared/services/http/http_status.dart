typedef JSON = Map<String, dynamic>;

typedef Response = ({Object data, int? statusCode});

typedef Failure = ({
  Object? exception,
  Object? errorData,
  String? message,
  int? statusCode,
});

class HttpStatus {
  final Response? response;
  final Failure? failure;

  HttpStatus({
    this.response,
    this.failure,
  });
}
