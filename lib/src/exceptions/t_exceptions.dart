class TExceptions implements Exception {
  // The associated error message
  final String message ;

  const TExceptions([this.message="An unknown exception occurred "]);



  //Create an authentication message
  //from a firebase error code
  factory TExceptions.fromCode(String code)
  {
    switch (code){
      case "email already in use" :
        return const TExceptions ("Email already in use");
        case "invalid email" :
        return const TExceptions ("Invalid email");
        case "wrong password" :
        return const TExceptions ("Wrong password");
        case "user not found" :
        return const TExceptions ("User not found");
        case "user disabled" :
        return const TExceptions ("User disabled");
        case "too many requests" :
        return const TExceptions ("Too many requests");
        case "operation not allowed" :
        return const TExceptions ("Operation not allowed");
        default :
        return const TExceptions ("An unknown exception occurred");
    }
  }

}


