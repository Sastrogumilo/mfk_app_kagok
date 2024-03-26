class AuthResponse<T> {
  final T response;
  final AuthMetadata metadata;

  AuthResponse({required this.response, required this.metadata});

  factory AuthResponse.fromJson(
      Map<String, dynamic>? json, T Function(dynamic) fromJsonResponse) {
    dynamic response;

    response = fromJsonResponse(json?['response']);

    return AuthResponse(
      response: response,
      metadata: AuthMetadata.fromJson(json?['metadata'] ?? {}),
    );
  }

  @override
  String toString() {
    return 'AuthResponse(response: ${response.toString()}, metadata: $metadata)';
  }
}

class AuthMetadata {
  final String message;
  final int status;

  AuthMetadata({required this.message, required this.status});

  factory AuthMetadata.fromJson(Map<String, dynamic>? json) {
    return AuthMetadata(
      message: json?['message'] ?? 'Unknown error',
      status: json?['status'] ?? 500,
    );
  }

  @override
  String toString() {
    return 'AuthMetadata(message: $message, status: $status)';
  }
}
