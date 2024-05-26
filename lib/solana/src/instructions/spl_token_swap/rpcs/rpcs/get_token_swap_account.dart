import 'package:blockchain_utils/exception/exception.dart';
import 'package:solana/solana/src/address/sol_address.dart';
import 'package:solana/solana/src/instructions/spl_token_swap/accounts/accounts.dart';
import 'package:solana/solana/src/rpc/rpc.dart';

class SolanaRPCSPLTokenSwapAccount
    extends SolanaRPCRequest<SPLTokenSwapAccount?> {
  const SolanaRPCSPLTokenSwapAccount({
    required this.account,
    this.ownerProgramAddress,
    Commitment? commitment,
    MinContextSlot? minContextSlot,
  }) : super(commitment: commitment, minContextSlot: minContextSlot);

  @override
  String get method => SolanaRPCMethods.getAccountInfo.value;
  final SolAddress account;
  final SolAddress? ownerProgramAddress;

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
  SPLTokenSwapAccount? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    if (ownerProgramAddress != null &&
        accountInfo.owner.address != ownerProgramAddress?.address) {
      throw MessageException("Invalid program address owner.", details: {
        "Excepted": ownerProgramAddress,
        "owner": accountInfo.owner.address
      });
    }
    return SPLTokenSwapAccount.fromBuffer(accountInfo.toBytesData());
  }
}
