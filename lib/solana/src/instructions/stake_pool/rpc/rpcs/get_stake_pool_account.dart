import 'package:dart_solana/solana/src/address/sol_address.dart';
import 'package:dart_solana/solana/src/instructions/stake_pool/accounts/accounts/stake_pool.dart';
import 'package:dart_solana/solana/src/rpc/rpc.dart';

/// Retrieves and deserializes a StakePool account.
class SolanaRPCGetStakePoolAccount extends SolanaRPCRequest<StakePoolAccount?> {
  const SolanaRPCGetStakePoolAccount({
    required this.address,
    Commitment? commitment,
    MinContextSlot? minContextSlot,
  }) : super(commitment: commitment, minContextSlot: minContextSlot);

  @override
  String get method => SolanaRPCMethods.getAccountInfo.value;
  final SolAddress address;

  @override
  List<dynamic> toJson() {
    return [
      address.address,
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        SolanaRPCEncoding.base64.toJson(),
        minContextSlot?.toJson()
      ])
    ];
  }

  @override
  StakePoolAccount? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return StakePoolAccount.fromBuffer(
        data: accountInfo.toBytesData(), address: address);
  }
}
