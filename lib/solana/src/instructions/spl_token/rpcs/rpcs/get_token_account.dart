import 'package:dart_solana/solana/src/address/sol_address.dart';
import 'package:dart_solana/solana/src/instructions/spl_token/accounts/accounts/token_account.dart';
import 'package:dart_solana/solana/src/rpc/rpc.dart';

class SolanaRPCGetTokenAccount extends SolanaRPCRequest<SolanaTokenAccount?> {
  const SolanaRPCGetTokenAccount({
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
  SolanaTokenAccount? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return SolanaTokenAccount.fromBuffer(
        address: account, data: accountInfo.toBytesData());
  }
}
