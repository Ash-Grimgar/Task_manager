class SignUpWithEmailAndPasswordFailure {
  final String message;

  const SignUpWithEmailAndPasswordFailure([
    this.message = "An unknown error occurred",
  ]);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is invalid or badly formatted',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email',
        );
      case 'user-not-found':
        return const SignUpWithEmailAndPasswordFailure(
          'No user found for that email',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}
