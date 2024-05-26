import 'package:solana/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:solana/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataUnverifySizedCollectionItemLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataUnverifySizedCollectionItemLayout();

  factory MetaplexTokenMetaDataUnverifySizedCollectionItemLayout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .unverifySizedCollectionItem.insturction);
    return MetaplexTokenMetaDataUnverifySizedCollectionItemLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .unverifySizedCollectionItem.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
