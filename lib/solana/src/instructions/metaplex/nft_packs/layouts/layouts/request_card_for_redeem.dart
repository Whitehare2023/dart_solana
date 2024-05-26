import 'package:dart_solana/solana/src/instructions/metaplex/nft_packs/layouts/instruction/instruction.dart';
import 'package:dart_solana/solana/src/layout/layout.dart';

class MetaplexNFTPacksRequestCardForRedeemLayout
    extends MetaplexNFTPacksProgramLayout {
  final int index;
  const MetaplexNFTPacksRequestCardForRedeemLayout({required this.index});

  factory MetaplexNFTPacksRequestCardForRedeemLayout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexNFTPacksProgramInstruction
            .requestCardForRedeem.insturction);
    return MetaplexNFTPacksRequestCardForRedeemLayout(index: decode["index"]);
  }

  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.u32("index")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexNFTPacksProgramInstruction.requestCardForRedeem.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"index": index};
  }
}
