// Manages the layout structure for initializing an SPL token mint with a specific instruction.
import 'package:dart_solana/solana/src/address/sol_address.dart';
import 'package:dart_solana/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:dart_solana/solana/src/instructions/spl_token/layouts/layouts/initialize_mint.dart';
import 'package:dart_solana/solana/src/layout/program_layouts/core/program_layout.dart';

/// Initializes a new mint layout
class SPLTokenInitializeMint2Layout extends SPLTokenInitializeMintLayout {
  /// Constructs an SPLTokenInitializeMint2Layout instance.
  SPLTokenInitializeMint2Layout({
    required SolAddress mintAuthority,
    required int decimals,
    SolAddress? freezeAuthority,
  }) : super(
            mintAuthority: mintAuthority,
            decimals: decimals,
            freezeAuthority: freezeAuthority);

  /// Constructs an SPLTokenInitializeMint2Layout instance from buffer.
  factory SPLTokenInitializeMint2Layout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: SPLTokenInitializeMintLayout.staticLayout,
      bytes: bytes,
      instruction: SPLTokenProgramInstruction.initializeMint2.insturction,
    );
    return SPLTokenInitializeMint2Layout(
      freezeAuthority: decode["freezeAuthority"],
      decimals: decode["decimals"],
      mintAuthority: decode["mintAuthority"],
    );
  }

  /// Instruction associated with the layout.
  @override
  int get instruction => SPLTokenProgramInstruction.initializeMint2.insturction;
}
