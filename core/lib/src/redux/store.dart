import 'package:redux/redux.dart';
import 'package:http/http.dart';
import 'package:key_value_store/key_value_store.dart';
import './app/app_state.dart';
import 'package:core/src/redux/app/app_reducer.dart';
import 'package:core/src/redux/theater/theater_middleware.dart';

Store<AppState> createStore(Client client, KeyValueStore keyValueStore) {
  return Store(
    appReducer,
    initialState: AppState.initial(),
    distinct: true,
    middleware: [
      TheaterMiddleware(keyValueStore),
    ],
  );
}
