import 'package:zard/zard.dart';

Future<dynamic> checkSchema(
  ZMap schema,
  dynamic data,
) async {
  final result = schema.safeParse(data);
  if (!result.success) {
    return result.error?.messages ?? data.toString();
  }
  return result.data;
}
