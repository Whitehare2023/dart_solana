import 'package:on_chain/solana/src/rpc/core/rpc.dart';

/// Unsubscribe notifications
/// https://solana.com/docs/rpc/websocket/votesubscribe
class SolanaRPCUnSubscribe extends SolanaRPCRequest<bool> {
  SolanaRPCUnSubscribe(
      {required this.subscribeId, required SolanaUnSubscribeRpcMethods method})
      : method = method.value;

  /// id of the Subscription to cancel
  final int subscribeId;

  /// Subscription method
  @override
  final String method;
  @override
  List<dynamic> toJson() {
    return [subscribeId];
  }

  @override
  bool onResonse(result) {
    return result;
  }
}
