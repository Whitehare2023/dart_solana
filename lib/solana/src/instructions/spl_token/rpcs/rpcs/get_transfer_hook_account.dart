import 'package:solana/solana/src/address/sol_address.dart';
import 'package:solana/solana/src/instructions/spl_token/accounts/accounts/transfer_hook_account.dart';
import 'package:solana/solana/src/rpc/rpc.dart';

class SolanaRPCGetTransferHookAccount
    extends SolanaRPCRequest<TransferHookAccount?> {
  const SolanaRPCGetTransferHookAccount({
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
  TransferHookAccount? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return TransferHookAccount.fromAccountBytes(accountInfo.toBytesData());
  }
}
