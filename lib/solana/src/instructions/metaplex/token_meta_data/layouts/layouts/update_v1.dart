import 'package:solana/solana/src/address/sol_address.dart';
import 'package:solana/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:solana/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:solana/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataUpdateV1Layout
    extends MetaplexTokenMetaDataUpdateProgramLayout {
  final SolAddress? newUpdateAuthority;
  final MetaDataData? data;
  final bool? primarySaleHappened;
  final bool? isMutable;
  final CollectionToggle collection;
  final CollectionDetailsToggle collectionDetails;
  final UsesToggle uses;
  final RuleSetToggle ruleSet;
  final Payload? authorizationData;
  static int discriminator = 0;
  const MetaplexTokenMetaDataUpdateV1Layout(
      {this.newUpdateAuthority,
      this.data,
      this.primarySaleHappened,
      this.isMutable,
      required this.collection,
      required this.collectionDetails,
      required this.uses,
      required this.ruleSet,
      this.authorizationData});

  factory MetaplexTokenMetaDataUpdateV1Layout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexTokenMetaDataProgramInstruction.updateV1.insturction,
        discriminator: discriminator);
    return MetaplexTokenMetaDataUpdateV1Layout(
        collection: CollectionToggle.fromJson(decode["collection"]),
        collectionDetails:
            CollectionDetailsToggle.fromJson(decode["collectionDetails"]),
        uses: UsesToggle.fromJson(decode["uses"]),
        ruleSet: RuleSetToggle.fromJson(decode["ruleSet"]),
        authorizationData: decode["authorizationData"] == null
            ? null
            : Payload.fromJson(decode["authorizationData"]),
        data: decode["data"] == null
            ? null
            : MetaDataData.fromJson(decode["data"]),
        isMutable: decode["isMutable"],
        newUpdateAuthority: decode["newUpdateAuthority"],
        primarySaleHappened: decode["primarySaleHappened"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u8("discriminator"),
    LayoutUtils.optionPubkey(property: "newUpdateAuthority"),
    LayoutUtils.optional(MetaDataData.staticLayout, property: "data"),
    LayoutUtils.optional(LayoutUtils.boolean(),
        property: "primarySaleHappened"),
    LayoutUtils.optional(LayoutUtils.boolean(), property: "isMutable"),
    LayoutUtils.wrap(CollectionToggle.staticLayout, property: "collection"),
    LayoutUtils.wrap(CollectionDetailsToggle.staticLayout,
        property: "collectionDetails"),
    LayoutUtils.wrap(UsesToggle.staticLayout, property: "uses"),
    LayoutUtils.wrap(RuleSetToggle.staticLayout, property: "ruleSet"),
    LayoutUtils.optional(Payload.staticLayout, property: "authorizationData"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.updateV1.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": discriminator,
      "newUpdateAuthority": newUpdateAuthority,
      "data": data?.serialize(),
      "primarySaleHappened": primarySaleHappened,
      "isMutable": isMutable,
      "collection": collection.serialize(),
      "collectionDetails": collectionDetails.serialize(),
      "uses": uses.serialize(),
      "ruleSet": ruleSet.serialize(),
      "authorizationData": authorizationData?.serialize()
    };
  }
}
