import 'package:blockchain_utils/binary/utils.dart';
import 'package:dart_solana/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:dart_solana/solana/src/instructions/metaplex/bubblegum/types/types/meta_data.dart';
import 'package:dart_solana/solana/src/layout/layout.dart';

class MetaplexBubblegumUnverifyCreatorLayout
    extends MetaplexBubblegumProgramLayout {
  final List<int> root;
  final List<int> dataHash;
  final List<int> creatorHash;
  final BigInt nonce;
  final int index;
  final MetaData message;
  MetaplexBubblegumUnverifyCreatorLayout(
      {required List<int> root,
      required List<int> dataHash,
      required List<int> creatorHash,
      required this.nonce,
      required this.index,
      required this.message})
      : root = BytesUtils.toBytes(root, unmodifiable: true),
        dataHash = BytesUtils.toBytes(dataHash, unmodifiable: true),
        creatorHash = BytesUtils.toBytes(creatorHash, unmodifiable: true);

  factory MetaplexBubblegumUnverifyCreatorLayout.fromBuffer(List<int> data) {
    final decode = MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexBubblegumProgramInstruction.unverifyCreator.insturction);
    return MetaplexBubblegumUnverifyCreatorLayout(
        root: decode["root"],
        dataHash: decode["dataHash"],
        creatorHash: decode["creatorHash"],
        nonce: decode["nonce"],
        index: decode["index"],
        message: MetaData.fromJson(decode["metaData"]));
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.blob(32, property: "root"),
    LayoutUtils.blob(32, property: "dataHash"),
    LayoutUtils.blob(32, property: "creatorHash"),
    LayoutUtils.u64("nonce"),
    LayoutUtils.u32("index"),
    MetaData.staticLayout,
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexBubblegumProgramInstruction.unverifyCreator.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "root": root,
      "dataHash": dataHash,
      "creatorHash": creatorHash,
      "nonce": nonce,
      "index": index,
      "metaData": message.serialize()
    };
  }
}
