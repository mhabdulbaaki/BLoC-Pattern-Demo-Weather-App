import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit({@required this.connectivity}) : super(NetworkInitial()) {
    streamSubscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.mobile) {
        emitNetworkConnected();
      } else {
        emitNetworkDisconnected();
      }
    });
  }

  void emitNetworkConnected() => emit(NetworkConnected());
  void emitNetworkDisconnected() => emit(NetworkDisconnected());

  StreamSubscription streamSubscription;
  final Connectivity connectivity;

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
