import 'package:dart_solana/solana/src/address/sol_address.dart';
import 'package:dart_solana/solana/src/instructions/address_lockup_table/address_lockup.dart';
import 'package:dart_solana/solana/src/rpc/rpc.dart';

class SolanaRPCGetAccountLookupAddres
    extends SolanaRPCRequest<AddressLookupTableAccount?> {
  const SolanaRPCGetAccountLookupAddres({
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
  AddressLookupTableAccount? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return AddressLookupTableAccount.fromBuffer(
        accountKey: account, accountData: accountInfo.toBytesData());
  }
}
