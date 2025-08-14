import 'package:darto_template/core/errors/error_api.dart';

class UserLengthRequiredException extends LengthRequiredApi {
  UserLengthRequiredException(super.message);
}

class UserException extends ExceptionApi {
  UserException(super.message);
}

class UserUpdateRecognitionException extends UpdateRecognitionApi {
  UserUpdateRecognitionException(super.message);
}

class UserNotFoundException extends NotFoundApi {
  UserNotFoundException(super.message);
}

class UserUnAuthorizedException extends UnAuthorizedApi {
  UserUnAuthorizedException(super.message);
}

class UserAlreadyExistsException extends AlreadyExistsApi {
  UserAlreadyExistsException(super.message);
}

class UserConflictException extends ConflictApi {
  UserConflictException(super.message);
}

class UserNotCreatedException extends NotCreatedApi {
  UserNotCreatedException(super.message);
}

class UserUpdatePasswordNotFoundException extends UpdatePasswordNotFoundApi {
  UserUpdatePasswordNotFoundException(super.message);
}

class UserInternalServerErrorException extends InternalServerErrorApi {
  UserInternalServerErrorException(super.message);
}

class UserTooManyRequestsException extends TooManyRequestsApi {
  UserTooManyRequestsException(super.message);
}

class UserPreconditionException extends PreconditionApi {
  UserPreconditionException(super.message);
}

class UserPreconditionRequiredException extends PreconditionRequiredApi {
  UserPreconditionRequiredException(super.message);
}
