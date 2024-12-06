class AppFailure {
  final String message;

  AppFailure([this.message = 'sorry, an unexpected error occuured!']);
  @override
  String toString() => 'AppFailure(message: $message)';
}
