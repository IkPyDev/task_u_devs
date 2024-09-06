

import 'package:get_it/get_it.dart';
import 'package:task_u_devs/shared/data/repository/database_repository_impl.dart';
import 'package:task_u_devs/shared/data/src/database_helper.dart';

import '../domain/repository/database_repository.dart';

final di = GetIt.instance;

void setup() {

  final databaseHelper = DatabaseHelper();

  di.registerSingleton<DatabaseRepository>(DatabaseRepositoryImpl(databaseHelper));

}
  // di.registerFactory(() => AddEventBloc());
  // di.registerFactory(() => CalendarBloc());
  // di.registerFactory(() => EventBloc());
  // di.registerFactory(() => HomeBloc());
  // di.registerFactory(() => SettingBloc());
  // di.registerFactory(() => SplashBloc());
  // di.registerFactory(() => TaskBloc());
  // di.registerFactory(() => TaskDetail
  // Bloc());