import 'package:core/src/models/theater.dart';
import 'package:kt_dart/collection.dart';

class InitAction{}

class InitCompleteAction {

  final KtList<Theater> theaters;
  final Theater selectedTheater;

  InitCompleteAction(this.theaters, this.selectedTheater);
}

class ChangeCurrentTheaterAction {
  final Theater selectedTheater;

  ChangeCurrentTheaterAction(this.selectedTheater);
}