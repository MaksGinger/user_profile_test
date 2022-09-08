import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:user_profile_test/bloc/app_bloc_observer.dart';
import 'package:user_profile_test/ui/app.dart';

void main() {
  runZonedGuarded(
    () {
      Bloc.observer = AppBlocObserver();
      runApp(const App());
    },
    (error, stackTrace) => log('$error $stackTrace'),
  );
}
