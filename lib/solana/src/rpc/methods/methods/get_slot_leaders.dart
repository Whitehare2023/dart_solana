import 'package:dart_solana/solana/src/address/sol_address.dart';
import 'package:dart_solana/solana/src/rpc/core/core.dart';
import 'package:dart_solana/solana/src/rpc/core/methods.dart';

/// Returns the slot leaders for a given slot range
/// https://solana.com/docs/rpc/http/getslotleaders
class SolanaRPCGetSlotLeaders extends SolanaRPCRequest<List<SolAddress>> {
  const SolanaRPCGetSlotLeaders({required this.startSlot, required this.limit});

  /// getSlotLeaders
  @override
  String get method => SolanaRPCMethods.getSlotLeaders.value;

  /// Start slot, as u64 integer
  final int startSlot;

  /// Limit, as u64 integer (between 1 and 5,000)
  final int limit;
  @override
  List<dynamic> toJson() {
    return [startSlot, limit];
  }

  @override
  List<SolAddress> onResonse(result) {
    return (result as List).map((e) => SolAddress.uncheckCurve(e)).toList();
  }
}
