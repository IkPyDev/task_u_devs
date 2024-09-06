part of 'detail_event_bloc.dart';

class DetailEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class DetailLoadEvent extends DetailEvent {
  final int id;

  DetailLoadEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class DetailDeleteEvent extends DetailEvent {
  final int id;

  DetailDeleteEvent(this.id);

  @override
  List<Object?> get props => [id];
}


