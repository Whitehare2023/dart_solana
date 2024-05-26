import 'package:solana/solana/src/address/sol_address.dart';
import 'package:solana/solana/src/rpc/core/rpc.dart';
import 'package:solana/solana/src/rpc/models/rpc_models.dart';
import 'package:solana/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Subscribe to a program to receive notifications when the lamports or data
/// for an account owned by the given program changes
/// https://solana.com/docs/rpc/websocket/programsubscribe
class SolanaRPCProgramSubscribe extends SolanaRPCRequest<int> {
  const SolanaRPCProgramSubscribe({
    required this.programId,
    this.filters,
    Commitment? commitment,
    SolanaRPCEncoding? encoding,
  }) : super(commitment: commitment, encoding: encoding);

  /// Pubkey of the program_id
  final SolAddress programId;

  /// programSubscribe
  @override
  String get method => SolanaSubscribeRpcMethods.programSubscribe.value;

  /// filter results
  final List<RPCFilterConfig>? filters;

  @override
  List<dynamic> toJson() {
    return [
      programId.address,
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        {"filters": filters?.map((e) => e.toJson()).toList()},
        encoding?.toJson()
      ])
    ];
  }

  @override
  int onResonse(result) {
    return result;
  }
}
