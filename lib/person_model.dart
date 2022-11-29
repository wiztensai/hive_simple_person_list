import 'package:hive_flutter/hive_flutter.dart';
part 'person_model.g.dart';

@HiveType(typeId: 1)
class PersonModel {
  @HiveField(0)
  var name = '';

  @HiveField(1)
  var address = '';

  PersonModel(this.name, this.address);
}
