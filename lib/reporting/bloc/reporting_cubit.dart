import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reporting_state.dart';

class ReportingCubit extends Cubit<ReportingState> {
  ReportingCubit() : super(ReportingInitial());
}
