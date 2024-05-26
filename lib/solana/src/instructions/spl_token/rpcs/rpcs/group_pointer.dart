import 'package:solana/solana/src/address/sol_address.dart';
import 'package:solana/solana/src/instructions/spl_token/accounts/accounts.dart';
import 'package:solana/solana/src/rpc/rpc.dart';

class SolanaRPCGetGroupPointer extends SolanaRPCRequest<GroupPointer?> {
  const SolanaRPCGetGroupPointer({
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
  GroupPointer? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return GroupPointer.fromBuffer(accountInfo.toBytesData());
  }
}
