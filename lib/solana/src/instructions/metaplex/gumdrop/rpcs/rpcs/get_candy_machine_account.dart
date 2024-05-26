import 'package:solana/solana/src/address/sol_address.dart';
import 'package:solana/solana/src/instructions/metaplex/gumdrop/accounts/accounts.dart';
import 'package:solana/solana/src/rpc/rpc.dart';

/// Retrieves the account info from the provided address and deserializes
/// the [GumdropCandyMachine] from its data.
class SolanaRPCGetGumdropCandyMachineAccount
    extends SolanaRPCRequest<GumdropCandyMachine?> {
  const SolanaRPCGetGumdropCandyMachineAccount({
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
  GumdropCandyMachine? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return GumdropCandyMachine.fromBuffer(accountInfo.toBytesData());
  }
}
