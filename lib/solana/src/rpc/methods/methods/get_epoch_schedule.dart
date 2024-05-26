import 'package:solana/solana/src/rpc/core/core.dart';
import 'package:solana/solana/src/rpc/core/methods.dart';
import 'package:solana/solana/src/rpc/models/rpc_models.dart';

/// Returns the epoch schedule information from this cluster's genesis config
/// https://solana.com/docs/rpc/http/getepochschedule
class SolanaRPCGetEpochSchedule extends SolanaRPCRequest<EpochSchedule> {
  @override
  String get method => SolanaRPCMethods.getEpochSchedule.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  EpochSchedule onResonse(result) {
    return EpochSchedule.fromJson(result);
  }
}
