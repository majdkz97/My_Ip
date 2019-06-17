import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './bloc.dart';
import 'package:my_ip/repositories/ip_repositories.dart';
import 'package:my_ip/models/models.dart';
class DataBloc extends Bloc<DataEvent, DataState> {
  final Ip_Repositories ip_repositories;
  
  DataBloc({@required this.ip_repositories})
      : assert(ip_repositories != null);

  @override
  DataState get initialState => DataEmpty();

  @override
  Stream<DataState> mapEventToState(
    DataEvent event,
  ) async* {
    // TODO: Add Logic
    if(event is FetchData)
      {
        yield DataLoading();
        try
            {
              final Info info = await ip_repositories.getData();
              yield DataLoaded(info: info);
            }
            catch(_){
          yield DataError();
            }
      }
    if (event is RefreshData) {
      try {
        final Info info = await ip_repositories.getData();
        yield DataLoaded(info: info);
      } catch (_) {
        yield DataError();
      }
    }


  }
}

