import 'package:solana/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:solana/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataBurnEditionNftLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataBurnEditionNftLayout();

  factory MetaplexTokenMetaDataBurnEditionNftLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexTokenMetaDataProgramInstruction.burnEditionNft.insturction);
    return MetaplexTokenMetaDataBurnEditionNftLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.burnEditionNft.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
