import 'package:dart_solana/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:dart_solana/solana/src/instructions/metaplex/token_meta_data/types/types/payload.dart';
import 'package:dart_solana/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataDelegateCollectionV1Layout
    extends MetaplexTokenMetaDataDelegateProgramLayout {
  final Payload? authorizationData;
  static const int discriminator = 0;
  const MetaplexTokenMetaDataDelegateCollectionV1Layout(
      {this.authorizationData});

  factory MetaplexTokenMetaDataDelegateCollectionV1Layout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .delegateCollectionV1.insturction,
        discriminator: discriminator);
    return MetaplexTokenMetaDataDelegateCollectionV1Layout(
        authorizationData: decode["authorizationData"] == null
            ? null
            : Payload.fromJson(decode["authorizationData"]));
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u8("discriminator"),
    LayoutUtils.optional(Payload.staticLayout, property: "authorizationData"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.delegateCollectionV1.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "authorizationData": authorizationData?.serialize(),
      "discriminator": discriminator
    };
  }
}
