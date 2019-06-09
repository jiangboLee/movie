import 'package:meta/meta.dart';

class Theater {
  Theater({
    @required this.id,
    @required this.name,
  });

  final String id;
  final String name;

  @override
  bool operator ==(other) {
    // TODO: implement ==
    return identical(this, other) || other is Theater && runtimeType == other.runtimeType && id == other.id && name == other.name;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => id.hashCode ^ name.hashCode;
}
