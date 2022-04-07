part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}




class GetCategoriesSuccessStat extends CategoryState {
  final List<Category> list ;
  GetCategoriesSuccessStat(this.list);
}

class GetCategoriesErrorStat extends CategoryState {
  final String error;
  GetCategoriesErrorStat(this.error);
}

class GetCategoriesLoadStat extends CategoryState {}

class DeleteCategoriesLoadStat extends CategoryState {}
class DeleteCategoriesSuccessStat extends CategoryState {
  final String success;

  DeleteCategoriesSuccessStat(this.success);
}
class DeleteCategoriesErrorStat extends CategoryState {

  final String error;

  DeleteCategoriesErrorStat(this.error);
}

// update
class UpdateCategoriesLoadStat extends CategoryState {}

class UpdateCategoriesSuccessStat extends CategoryState {
  final String success;

  UpdateCategoriesSuccessStat(this.success);
}
class UpdateCategoriesErrorStat extends CategoryState {

  final String error;

  UpdateCategoriesErrorStat(this.error);
}


//Add Category

class AddCategoriesLoadStat extends CategoryState {}

class AddCategoriesSuccessStat extends CategoryState {
  final String success;

  AddCategoriesSuccessStat(this.success);
}
class AddCategoriesErrorStat extends CategoryState {

  final String error;

 AddCategoriesErrorStat(this.error);
}



//upload image
class UpdateCategoriesLoadImageStat extends CategoryState {}
class UpdateCategoriesLoadedImageStat extends CategoryState {
  final String image;

  UpdateCategoriesLoadedImageStat(this.image);
}
class UpdateCategoriesLoadErrorImageStat extends CategoryState {}


// sub Category
class GetSubCategoriesSuccessStat extends CategoryState {
  final List<SubCategory> list ;
  GetSubCategoriesSuccessStat(this.list);
}

class GetSubCategoriesErrorStat extends CategoryState {
  final String error;
  GetSubCategoriesErrorStat(this.error);
}

class GetSubCategoriesLoadStat extends CategoryState {}

class DeleteSubCategoriesLoadStat extends CategoryState {}
class DeleteSubCategoriesSuccessStat extends CategoryState {
  final String success;

  DeleteSubCategoriesSuccessStat(this.success);
}
class DeleteSubCategoriesErrorStat extends CategoryState {

  final String error;

  DeleteSubCategoriesErrorStat(this.error);
}

// update
class UpdateSubCategoriesLoadStat extends CategoryState {}

class UpdateSubCategoriesSuccessStat extends CategoryState {
  final String success;

  UpdateSubCategoriesSuccessStat(this.success);
}
class UpdateSubCategoriesErrorStat extends CategoryState {

  final String error;

  UpdateSubCategoriesErrorStat(this.error);
}


//Add Category

class AddSubCategoriesLoadStat extends CategoryState {}

class AddSubCategoriesSuccessStat extends CategoryState {
  final String success;

  AddSubCategoriesSuccessStat(this.success);
}
class AddSubCategoriesErrorStat extends CategoryState {

  final String error;

  AddSubCategoriesErrorStat(this.error);
}



//upload image
class UpdateSubCategoriesLoadImageStat extends CategoryState {}
class UpdateSubCategoriesLoadedImageStat extends CategoryState {
  final String image;

  UpdateSubCategoriesLoadedImageStat(this.image);
}
class UpdateSubCategoriesLoadErrorImageStat extends CategoryState {}


class ChangeValueSubCategory extends CategoryState {}