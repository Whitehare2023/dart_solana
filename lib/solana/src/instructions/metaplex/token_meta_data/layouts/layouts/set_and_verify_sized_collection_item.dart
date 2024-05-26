import 'package:dart_solana/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:dart_solana/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataSetAndVerifySizedCollectionItemLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataSetAndVerifySizedCollectionItemLayout();

  factory MetaplexTokenMetaDataSetAndVerifySizedCollectionItemLayout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .setAndVerifySizedCollectionItem.insturction);
    return MetaplexTokenMetaDataSetAndVerifySizedCollectionItemLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .setAndVerifySizedCollectionItem.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
