import 'package:dart_solana/solana/src/layout/layout.dart';

abstract class MetaplexNFTPacksProgramLayout extends ProgramLayout {
  const MetaplexNFTPacksProgramLayout();
  @override
  abstract final int instruction;
  static ProgramLayout fromBytes(List<int> data) {
    return UnknownProgramLayout(data);
  }
}
