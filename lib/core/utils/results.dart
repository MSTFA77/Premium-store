/// Small alternative to bringing in a whole functional-programming package
/// just to represent "this either worked or it didn't". Dart 3's sealed
/// classes + pattern matching cover it fine on their own.
sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

final class ResultFailure<T> extends Result<T> {
  const ResultFailure(this.message);
  final String message;
}
