part of 'admin_cubit.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}


//get
class GetAdminsLoad extends AdminState {}

class GetAdminsSuccess extends AdminState {}

class GetAdminsError extends AdminState {}


//get
class GetUsersLoad extends AdminState {}

class GetUsersSuccess extends AdminState {}

class GetUsersError extends AdminState {}


//add
class AddAdminLoad extends AdminState {}

class AddAdminSuccess extends AdminState {}

class AddAdminError extends AdminState {}



//delete
class DeleteAdminLoad extends AdminState {}

class DeleteAdminSuccess extends AdminState {}

class DeleteAdminError extends AdminState {}



//Update
class UpdateAdminLoad extends AdminState {}

class UpdateAdminSuccess extends AdminState {}

class UpdateAdminError extends AdminState {}

class ChangeValuePermission extends AdminState {}
