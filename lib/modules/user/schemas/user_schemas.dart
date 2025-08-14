import 'package:zard/zard.dart';

final userCreateSchema = z.map({
  'name': z.string().min(3),
  'email': z.string().email(),
  'password': z.string(),
});

final getUserEmailSchema = z.map({
  'email': z.string().email(),
});
