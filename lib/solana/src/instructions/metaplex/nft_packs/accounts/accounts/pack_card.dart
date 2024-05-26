import 'package:dart_solana/solana/src/address/sol_address.dart';
import 'package:dart_solana/solana/src/instructions/metaplex/nft_packs/types/types/account_type.dart';
import 'package:dart_solana/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.u8("accountType"),
    LayoutUtils.publicKey("packSet"),
    LayoutUtils.publicKey("master"),
    LayoutUtils.publicKey("metadata"),
    LayoutUtils.publicKey("tokenAccount"),
    LayoutUtils.u32("maxSupply"),
    LayoutUtils.u16("weight"),
  ]);
}

class PackCard extends LayoutSerializable {
  static int get size => _Utils.layout.span;
  final NFTPacksAccountType accountType;
  final SolAddress packSet;
  final SolAddress master;
  final SolAddress metadata;
  final SolAddress tokenAccount;
  final int maxSupply;
  final int weight;

  const PackCard(
      {required this.accountType,
      required this.packSet,
      required this.master,
      required this.metadata,
      required this.tokenAccount,
      required this.maxSupply,
      required this.weight});
  factory PackCard.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return PackCard(
        accountType: NFTPacksAccountType.fromValue(decode["accountType"]),
        packSet: decode["packSet"],
        master: decode["master"],
        metadata: decode["metadata"],
        tokenAccount: decode["tokenAccount"],
        maxSupply: decode["maxSupply"],
        weight: decode["weight"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "accountType": accountType.value,
      "packSet": packSet,
      "master": master,
      "metadata": metadata,
      "tokenAccount": tokenAccount,
      "maxSupply": maxSupply,
      "weight": weight
    };
  }

  @override
  String toString() {
    return "PackCard${serialize()}";
  }
}
