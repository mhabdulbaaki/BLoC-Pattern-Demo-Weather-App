part of 'network_cubit.dart';

@immutable
abstract class NetworkState {
  const NetworkState();
}

class NetworkInitial extends NetworkState {
  const NetworkInitial();
}

class NetworkConnected extends NetworkState {
  const NetworkConnected();
}

class NetworkDisconnected extends NetworkState {
  const NetworkDisconnected();
}
