import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_ip/models/models.dart';
@immutable
abstract class DataState extends Equatable {
  DataState([List props = const []]) : super(props);
}


class DataEmpty extends DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final  Info info;

  DataLoaded({@required this.info})
      : assert(info != null),
        super([info]);
}

class DataError extends DataState {}