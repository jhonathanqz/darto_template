abstract class ErrorApi implements Exception {
  final String message;

  ErrorApi(this.message);
}

class InternalServerErrorApi extends ErrorApi {
  InternalServerErrorApi(super.message);
}

class LengthRequiredApi extends ErrorApi {
  LengthRequiredApi(super.message);
}

class ExceptionApi extends ErrorApi {
  ExceptionApi(super.message);
}

class UpdateRecognitionApi extends ErrorApi {
  UpdateRecognitionApi(super.message);
}

class NotFoundApi extends ErrorApi {
  NotFoundApi(super.message);
}

class UnAuthorizedApi extends ErrorApi {
  UnAuthorizedApi(super.message);
}

class AlreadyExistsApi extends ErrorApi {
  AlreadyExistsApi(super.message);
}

class ConflictApi extends ErrorApi {
  ConflictApi(super.message);
}

class NotCreatedApi extends ErrorApi {
  NotCreatedApi(super.message);
}

class UpdatePasswordNotFoundApi extends ErrorApi {
  UpdatePasswordNotFoundApi(super.message);
}

class TooManyRequestsApi extends ErrorApi {
  TooManyRequestsApi(super.message);
}

class PreconditionApi extends ErrorApi {
  PreconditionApi(super.message);
}

class PreconditionRequiredApi extends ErrorApi {
  PreconditionRequiredApi(super.message);
}
