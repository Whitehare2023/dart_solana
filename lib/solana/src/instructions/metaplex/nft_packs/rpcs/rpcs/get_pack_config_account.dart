import 'package:dart_solana/solana/src/address/sol_address.dart';
import 'package:dart_solana/solana/src/instructions/metaplex/nft_packs/accounts/accounts.dart';
import 'package:dart_solana/solana/src/rpc/rpc.dart';

/// Retrieves the account info from the provided address and deserializes
/// the [PackConfig] from its data.
class SolanaRPCGetPackConfigAccount extends SolanaRPCRequest<PackConfig?> {
  const SolanaRPCGetPackConfigAccount({
    required this.account,
    Commitment? commitment,
    MinContextSlot? minContextSlot,
  }) : super(commitment: commitment, minContextSlot: minContextSlot);

  @override
  String get method => SolanaRPCMethods.getAccountInfo.value;
  final SolAddress account;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        SolanaRPCEncoding.base64.toJson(),
        minContextSlot?.toJson()
      ])
    ];
  }

  @override
  PackConfig? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return PackConfig.fromBuffer(accountInfo.toBytesData());
  }
}
