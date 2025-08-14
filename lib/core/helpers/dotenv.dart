import 'package:dotenv/dotenv.dart';

String dotenv(String key) {
  final env = DotEnv();
  env.load();
  return env.getOrElse(key, () => throw (Exception('Variable $key not found')));
}
