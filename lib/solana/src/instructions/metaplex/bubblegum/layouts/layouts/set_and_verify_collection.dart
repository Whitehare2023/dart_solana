import 'package:blockchain_utils/binary/utils.dart';
import 'package:solana/solana/src/address/sol_address.dart';
import 'package:solana/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:solana/solana/src/instructions/metaplex/bubblegum/types/types/meta_data.dart';
import 'package:solana/solana/src/layout/layout.dart';

class MetaplexBubblegumSetAndVerifyCollectionLayout
    extends MetaplexBubblegumProgramLayout {
  final List<int> root;
  final List<int> dataHash;
  final List<int> creatorHash;
  final BigInt nonce;
  final int index;
  final MetaData message;
  final SolAddress collection;
  MetaplexBubblegumSetAndVerifyCollectionLayout(
      {required List<int> root,
      required List<int> dataHash,
      required List<int> creatorHash,
      required this.nonce,
      required this.index,
      required this.message,
      required this.collection})
      : root = BytesUtils.toBytes(root, unmodifiable: true),
        dataHash = BytesUtils.toBytes(dataHash, unmodifiable: true),
        creatorHash = BytesUtils.toBytes(creatorHash, unmodifiable: true);

  factory MetaplexBubblegumSetAndVerifyCollectionLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexBubblegumProgramInstruction
            .setAndVerifyCollection.insturction);
    return MetaplexBubblegumSetAndVerifyCollectionLayout(
        root: decode["root"],
        dataHash: decode["dataHash"],
        creatorHash: decode["creatorHash"],
        nonce: decode["nonce"],
        index: decode["index"],
        message: MetaData.fromJson(decode["metaData"]),
        collection: decode["collection"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.blob(32, property: "root"),
    LayoutUtils.blob(32, property: "dataHash"),
    LayoutUtils.blob(32, property: "creatorHash"),
    LayoutUtils.u64("nonce"),
    LayoutUtils.u32("index"),
    MetaData.staticLayout,
    LayoutUtils.publicKey("collection")
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexBubblegumProgramInstruction.setAndVerifyCollection.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "root": root,
      "dataHash": dataHash,
      "creatorHash": creatorHash,
      "nonce": nonce,
      "index": index,
      "metaData": message.serialize(),
      "collection": collection
    };
  }
}
