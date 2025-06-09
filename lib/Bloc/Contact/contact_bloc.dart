import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple/Api/apiProvider.dart';

abstract class ContactDentalEvent {}

class ContactDental extends ContactDentalEvent {}

class EventDental extends ContactDentalEvent {}

class ContactDentalBloc extends Bloc<ContactDentalEvent, dynamic> {
  ContactDentalBloc() : super(dynamic) {
    on<ContactDental>((event, emit) async {
      await ApiProvider().getContactAPI().then((value) {
        emit(value);
      }).catchError((error) {
        emit(error);
      });
    });
    on<EventDental>((event, emit) async {
      await ApiProvider().getEventAPI().then((value) {
        emit(value);
      }).catchError((error) {
        emit(error);
      });
    });
  }
}
