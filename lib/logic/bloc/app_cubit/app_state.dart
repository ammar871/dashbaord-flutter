import 'package:flutter/cupertino.dart';
import 'package:flutter_web_dashboard/Models/general.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AppChangeModeState extends AppState {}

class AppChangeLangState extends AppState {}

class GetCountersSuccessStat extends AppState {
 final General general ;
  GetCountersSuccessStat(this.general);
}

class GetCountersErrorStat extends AppState {
  final String error;
  GetCountersErrorStat(this.error);
}

class GetCountersLoadStat extends AppState {}

class ChangeValueAdd extends AppState {}
