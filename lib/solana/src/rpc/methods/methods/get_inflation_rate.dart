import 'package:solana/solana/src/rpc/core/core.dart';
import 'package:solana/solana/src/rpc/core/methods.dart';
import 'package:solana/solana/src/rpc/models/rpc_models.dart';

/// Returns the specific inflation values for the current epoch
/// https://solana.com/docs/rpc/http/getinflationrate
class SolanaRPCGetInflationRate extends SolanaRPCRequest<InflationRate> {
  /// getInflationRate
  @override
  String get method => SolanaRPCMethods.getInflationRate.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  InflationRate onResonse(result) {
    return InflationRate.fromJson(result);
  }
}
