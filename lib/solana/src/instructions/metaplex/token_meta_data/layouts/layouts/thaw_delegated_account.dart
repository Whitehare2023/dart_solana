import 'package:solana/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:solana/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataThawDelegatedAccountLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataThawDelegatedAccountLayout();

  factory MetaplexTokenMetaDataThawDelegatedAccountLayout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .thawDelegatedAccount.insturction);
    return MetaplexTokenMetaDataThawDelegatedAccountLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.thawDelegatedAccount.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
