import 'package:dart_solana/solana/src/rpc/core/core.dart';
import 'package:dart_solana/solana/src/rpc/core/methods.dart';

/// Returns the lowest slot that the node has information about in its ledger.
/// This value may increase over time if the node is configured to purge older ledger data
/// https://solana.com/docs/rpc/http/minimumledgerslot
class SolanaRPCMinimumLedgerSlot extends SolanaRPCRequest<int> {
  /// minimumLedgerSlot
  @override
  String get method => SolanaRPCMethods.minimumLedgerSlot.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
