import 'package:dart_solana/solana/src/address/sol_address.dart';
import 'package:dart_solana/solana/src/rpc/models/rpc_models.dart';

/// Accounts configuration object
class RPCAccountConfig {
  const RPCAccountConfig({required this.addresses, required this.encoding});

  /// An array of accounts to return, as base-58 encoded strings
  final List<SolAddress> addresses;

  /// encoding for returned Account data
  final SolanaRPCEncoding encoding;
  Map<String, dynamic> toJson() {
    return {
      "accounts": {
        "addresses": addresses.map((e) => e.address).toList(),
        ...encoding.toJson(),
      }
    };
  }
}
