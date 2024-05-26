import 'package:dart_solana/solana/src/address/sol_address.dart';
import 'package:dart_solana/solana/src/instructions/spl_token/accounts/accounts/cip_guard.dart';
import 'package:dart_solana/solana/src/rpc/rpc.dart';

class SolanaRPCGetCipGuard extends SolanaRPCRequest<CpiGuard?> {
  const SolanaRPCGetCipGuard({
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
  CpiGuard? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return CpiGuard.fromAccountBytes(accountInfo.toBytesData());
  }
}
