import 'package:core/src/redux/theater/theater_state.dart';
import 'package:meta/meta.dart';
import 'package:kt_dart/collection.dart';

class AppState {
  AppState({
      @required this.theaterState,
  });
  final TheaterState theaterState;

  factory AppState.initial() {
    return AppState(
      theaterState: TheaterState.initial(),
    );
  }

  AppState copyWith({
    TheaterState theaterState
  }) {
    return AppState(
      theaterState: theaterState ?? this.theaterState,
    );
  }
}