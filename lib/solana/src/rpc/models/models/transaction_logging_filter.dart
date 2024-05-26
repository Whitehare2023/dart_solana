import 'package:dart_solana/solana/src/address/sol_address.dart';

/// filter criteria for the logs to receive results by account type.
class SubscribeTransactionLogsFilter {
  const SubscribeTransactionLogsFilter._(this.name, this.mentions);
  final List<SolAddress>? mentions;
  final String name;

  /// subscribe to all transactions except for simple vote transactions
  factory SubscribeTransactionLogsFilter.all() {
    return SubscribeTransactionLogsFilter._("all", null);
  }

  /// subscribe to all transactions, including simple vote transactions
  factory SubscribeTransactionLogsFilter.allWithVotes() {
    return SubscribeTransactionLogsFilter._("allWithVotes", null);
  }

  /// subscribe to only transactions mentioning this address
  factory SubscribeTransactionLogsFilter.mentions(SolAddress account) {
    return SubscribeTransactionLogsFilter._("mentions", [account]);
  }

  dynamic toJson() {
    if (mentions != null) {
      return {"mentions": mentions!.map((e) => e.address).toList()};
    }
    return name;
  }
}
