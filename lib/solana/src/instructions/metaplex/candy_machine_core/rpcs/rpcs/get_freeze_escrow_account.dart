import 'package:solana/solana/src/address/sol_address.dart';
import 'package:solana/solana/src/instructions/metaplex/candy_machine_core/accounts/accounts.dart';
import 'package:solana/solana/src/rpc/rpc.dart';

/// Retrieves the account info from the provided address and deserializes
/// the [FreezeEscrowAccount] from its data.
class SolanaRPCGetFreezeEscrowAccount
    extends SolanaRPCRequest<FreezeEscrowAccount?> {
  const SolanaRPCGetFreezeEscrowAccount({
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
  FreezeEscrowAccount? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return FreezeEscrowAccount.fromBuffer(accountInfo.toBytesData());
  }
}
