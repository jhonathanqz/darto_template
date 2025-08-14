// ignore_for_file: library_private_types_in_public_api

import 'package:darto/darto.dart';
import '/core/errors/error_api.dart';

abstract class ResultHandler {
  static _Success? _success;
  static _Error? _error;
  //Success responses
  static _Success get success {
    _success ??= _Success();
    return _success!;
  }

  //Errors response
  static _Error get error {
    _error ??= _Error();
    return _error!;
  }

  static void errorHanlder(Response res, Object exception) {
    switch (exception) {
      case LengthRequiredApi e:
        error.lengthRequired(res, e.message);
        break;
      case ExceptionApi e:
        error.badRequest(res, e.message);
        break;
      case UpdateRecognitionApi e:
        error.badRequest(res, e.message);
        break;
      case NotFoundApi e:
        error.notFound(res, e.message);
        break;
      case UnAuthorizedApi e:
        error.unauthorized(res, e.message);
        break;
      case AlreadyExistsApi e:
        error.alreadyExists(res, e.message);
        break;
      case ConflictApi e:
        error.conflict(res, e.message);
        break;
      case NotCreatedApi e:
        error.notFound(res, e.message);
        break;
      case UpdatePasswordNotFoundApi e:
        error.notFound(res, e.message);
        break;
      case InternalServerErrorApi e:
        error.internalServerError(res, e.message);
        break;
      case TooManyRequestsApi e:
        error.tooManyRequests(res, e.message);
        break;
      case PreconditionApi e:
        error.preconditionFailed(res, e.message);
        break;
      case PreconditionRequiredApi e:
        error.preconditionRequired(res, e.message);
        break;
      default:
        error.internalServerError(res, 'Internal Server Error');
    }
  }
}

class _Success {
  void ok(Response res, dynamic message) {
    return res.status(OK).json(message);
  }

  void emptyOk(Response res) {
    return res.status(OK).send();
  }

  void created(Response res, dynamic message) {
    return res.status(CREATED).json(message);
  }

  void accepted(Response res, dynamic message) {
    return res.status(ACCEPTED).json(message);
  }

  void noContent(Response res) {
    return res.status(NO_CONTENT).send();
  }

  void alreadyReported(Response res, dynamic message) {
    return res.status(ALREADY_REPORTED).json(message);
  }
}

class _Error {
  void badRequest(Response res, dynamic message) {
    return res.status(BAD_REQUEST).error(message);
  }

  void notFound(Response res, dynamic message) {
    return res.status(NOT_FOUND).error(message);
  }

  void notAcceptable(Response res, dynamic message) {
    return res.status(NOT_ACCEPTABLE).error(message);
  }

  void unauthorized(Response res, dynamic message) {
    return res.status(UNAUTHORIZED).error(message);
  }

  void forbidden(Response res, dynamic message) {
    return res.status(FORBIDDEN).error(message);
  }

  void alreadyExists(Response res, dynamic message) {
    return res.status(CONFLICT).error(message);
  }

  void conflict(Response res, dynamic message) {
    return res.status(CONFLICT).error(message);
  }

  void lengthRequired(Response res, dynamic message) {
    return res.status(LENGTH_REQUIRED).error(message);
  }

  void tooManyRequests(Response res, dynamic message) {
    return res.status(TOO_MANY_REQUESTS).error(message);
  }

  void expectationFailed(Response res, dynamic message) {
    return res.status(EXPECTATION_FAILED).error(message);
  }

  void preconditionFailed(Response res, dynamic message) {
    return res.status(PRECONDITION_FAILED).error(message);
  }

  void preconditionRequired(Response res, dynamic message) {
    return res.status(PRECONDITION_REQUIRED).error(message);
  }

  void internalServerError(Response res, dynamic message) {
    return res.status(INTERNAL_SERVER_ERROR).error(message);
  }

  void notImplemented(Response res, dynamic message) {
    return res.status(NOT_IMPLEMENTED).error(message);
  }

  void badGateway(Response res, dynamic message) {
    return res.status(BAD_GATEWAY).error(message);
  }
}
