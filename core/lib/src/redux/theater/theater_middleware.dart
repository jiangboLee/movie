import 'dart:async';
import 'package:redux/redux.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:key_value_store/key_value_store.dart';
import 'package:core/src/redux/_common/common_actions.dart';
import 'package:core/src/preloaded_data.dart';
import 'package:core/src/parsers/theater_parser.dart';
import 'package:core/src/models/theater.dart';
import 'package:kt_dart/collection.dart';
import 'package:core/src/redux/theater/theater_state.dart';

class TheaterMiddleware extends MiddlewareClass<AppState> {
  static const String kDefaultTheaterId = 'default_theater_id';

  final KeyValueStore keyValueStore;

  TheaterMiddleware(this.keyValueStore);

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is InitAction) {
      await _init(action, next);
    } else if (action is ChangeCurrentTheaterAction) {
      await _changeCurrentTheater(action, next);
    } else {
      next(action);
    }
  }

  Future<Null> _init(InitAction action, NextDispatcher next) async {
    var theaterXml = PreloadedData.theaters;
    var theaters = TheaterParser.parse(theaterXml);
    var currentTheater = _getDefaultTheater(theaters);

    next(InitCompleteAction(theaters, currentTheater));
  }

  Theater _getDefaultTheater(KtList<Theater> allTheaters) {
    var persistedTheaterId = keyValueStore.getString(kDefaultTheaterId);
    if (persistedTheaterId != null) {
      return allTheaters.single((theater) {
        return theater.id == persistedTheaterId;
      });
    }
    //默认Helsinki
    return allTheaters.singleOrNull((theater) => theater.id == '1033') ?? allTheaters.first;
  }

  Future<Null> _changeCurrentTheater(ChangeCurrentTheaterAction action, NextDispatcher next) async {
    keyValueStore.setString(kDefaultTheaterId, action.selectedTheater.id);
    next(action);
  }

}