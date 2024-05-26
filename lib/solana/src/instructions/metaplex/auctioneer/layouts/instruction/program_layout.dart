import 'package:dart_solana/solana/src/layout/layout.dart';

abstract class MetaplexAuctioneerProgramLayout extends ProgramLayout {
  const MetaplexAuctioneerProgramLayout();
  @override
  abstract final List<int> instruction;
  static ProgramLayout fromBytes(List<int> data) {
    return UnknownProgramLayout(data);
  }

  static Map<String, dynamic> decodeAndValidateStruct({
    required Structure layout,
    required List<int> bytes,
    required List<int> instruction,
  }) {
    return LayoutSerializable.decode(
        bytes: bytes, layout: layout, validator: {"instruction": instruction});
  }
}
