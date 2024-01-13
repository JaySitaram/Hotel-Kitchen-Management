import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_bloc_state.dart';

class DashboardBlocCubit extends Cubit<DashboardBlocState> {
  DashboardBlocCubit() : super(DashboardBlocInitial());
}
