import 'package:dart_solana/solana/src/address/sol_address.dart';
import 'package:dart_solana/solana/src/instructions/metaplex/fixed_price_sale/accounts/accounts.dart';
import 'package:dart_solana/solana/src/rpc/rpc.dart';

/// Retrieves the account info from the provided address and deserializes
/// the [Store] from its data.
class SolanaRPCGetStoreAccount extends SolanaRPCRequest<Store?> {
  const SolanaRPCGetStoreAccount({
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
  Store? onResonse(result) {
    if (result == null) return null;
    final accountInfo = SolanaAccountInfo.fromJson(result);
    return Store.fromBuffer(accountInfo.toBytesData());
  }
}
