import 'package:flutter_bloc/flutter_bloc.dart';
class SpinnerCubit extends Cubit<bool> {
  SpinnerCubit() : super(false);
  void showSpinner() => emit(true);
  void hideSpinner() => emit(false);
}
