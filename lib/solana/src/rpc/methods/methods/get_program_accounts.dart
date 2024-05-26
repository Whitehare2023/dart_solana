import 'package:dart_solana/solana/src/address/sol_address.dart';
import 'package:dart_solana/solana/src/rpc/core/core.dart';
import 'package:dart_solana/solana/src/rpc/core/methods.dart';
import 'package:dart_solana/solana/src/rpc/models/rpc_models.dart';
import 'package:dart_solana/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns all accounts owned by the provided program Pubkey
/// https://solana.com/docs/rpc/http/getprogramaccounts
class SolanaRPCGetProgramAccounts
    extends SolanaRPCRequest<List<SolanaAccountInfo>> {
  const SolanaRPCGetProgramAccounts(
      {required this.account,
      this.withContext,
      this.dataSlice,
      this.filters,
      Commitment? commitment,
      MinContextSlot? minContextSlot,
      SolanaRPCEncoding? encoding = SolanaRPCEncoding.base64})
      : super(
            commitment: commitment,
            minContextSlot: minContextSlot,
            encoding: encoding);

  /// getProgramAccounts
  @override
  String get method => SolanaRPCMethods.getProgramAccounts.value;

  /// Pubkey of program, as base-58 encoded string
  final SolAddress account;

  /// wrap the result in an RpcResponse JSON object
  final bool? withContext;

  /// Request a slice of the account's data.
  final RPCDataSliceConfig? dataSlice;

  /// filter results using up to 4 filter objects
  /// The resultant account(s) must meet ALL filter criteria to be included in the returned results
  final List<RPCFilterConfig>? filters;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        minContextSlot?.toJson(),
        {"withContext": withContext},
        encoding?.toJson(),
        dataSlice?.toJson(),
        {"filters": filters?.map((e) => e.toJson()).toList()}
      ])
    ];
  }

  @override
  List<SolanaAccountInfo> onResonse(result) {
    return (result as List)
        .map((e) => SolanaAccountInfo.fromJson(e["account"]))
        .toList();
  }
}
