import '../app/app_state.dart';
import '../../models/theater.dart';
import 'package:kt_dart/collection.dart';

Theater currentTheaterSelector(AppState state) => state.theaterState.currentTheater;

KtList<Theater> theatersSelector(AppState state) => state.theaterState.theaters;