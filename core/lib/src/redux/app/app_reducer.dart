import 'package:core/src/redux/theater/theater_reducer.dart';
import 'package:core/src/redux/app/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    theaterState: theaterReducer(state.theaterState, action),
  );
}