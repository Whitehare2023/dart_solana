import 'package:dart_solana/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:dart_solana/solana/src/instructions/metaplex/token_meta_data/types/types/payload.dart';
import 'package:dart_solana/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataMintV1Layout
    extends MetaplexTokenMetaDataProgramLayout {
  final Payload? authorizationData;
  final BigInt amount;
  const MetaplexTokenMetaDataMintV1Layout(
      {this.authorizationData, required this.amount});

  factory MetaplexTokenMetaDataMintV1Layout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction.mintV1.insturction,
        discriminator: discriminator);
    return MetaplexTokenMetaDataMintV1Layout(
        authorizationData: decode["authorizationData"] == null
            ? null
            : Payload.fromJson(decode["authorizationData"]),
        amount: decode["amount"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u8("discriminator"),
    LayoutUtils.u64("amount"),
    LayoutUtils.optional(Payload.staticLayout, property: "authorizationData"),
  ]);
  static const int discriminator = 0;

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.mintV1.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "authorizationData": authorizationData?.serialize(),
      "discriminator": discriminator,
      "amount": amount
    };
  }
}
