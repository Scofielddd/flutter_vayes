import 'package:flutter_vayes/pages/side_pages/account_page.dart';
import 'package:flutter_vayes/pages/side_pages/gallery_page.dart';

import 'package:flutter_vayes/pages/home_page.dart';
import 'package:flutter_vayes/photo_bloc/photo_page.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors = <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor;
}

class ClassBuilder {
  static void registerClasses() {
    register<HomePage>(() => HomePage());
    register<AccountPage>(() => AccountPage());
    register<GalleryPage>(() => GalleryPage());
    register<PhotoPage>(() => PhotoPage());
    
  }

  static dynamic fromString(String type) {
    return _constructors[type]();
  }
}