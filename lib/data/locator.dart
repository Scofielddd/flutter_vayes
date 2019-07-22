import 'package:flutter_vayes/data/photo/photo_repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator =GetIt();

void setupLocator(){
  locator.registerLazySingleton(() => PhotoRepository());
}