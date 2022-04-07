part of 'add_cubit.dart';

@immutable
abstract class AddState {}

class AddInitial extends AddState {}

class ChangeValueAdd extends AddState {}


class GetAddsHomeLoadState extends AddState {}
class GetAddsHomeSuccessState extends AddState {
  final ResponseAdds responseAdds;

  GetAddsHomeSuccessState(this.responseAdds);
}
class GetAddsHomeErrorState extends AddState {}
//get

class GetAddsLoadState extends AddState {}
class GetAddsSuccessState extends AddState {
  final List<Add> list;

  GetAddsSuccessState(this.list);
}
class GetAddsErrorState extends AddState {}


//update
class UpdateAddsLoadState extends AddState {}
class UpdateAddsSuccessState extends AddState {}
class UpdateAddsErrorState extends AddState {}