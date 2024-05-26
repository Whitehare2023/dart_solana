// Manages the layout structure for setting authority in SPL tokens.
import 'package:solana/solana/src/address/sol_address.dart';
import 'package:solana/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';
import 'package:solana/solana/src/instructions/spl_token/types/types.dart';
import 'package:solana/solana/src/layout/layout.dart';

/// Sets a new authority of a mint or account layout.
class SPLTokenSetAuthorityLayout extends SPLTokenProgramLayout {
  /// The new authority
  final SolAddress? newAuthority;

  /// The type of authority to update.
  final AuthorityType authorityType;

  /// Constructs an SPLTokenSetAuthorityLayout instance.
  SPLTokenSetAuthorityLayout({required this.authorityType, this.newAuthority});

  /// Structure structure for setting authority in SPL tokens.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u8("authorityType"),
    LayoutUtils.optionPubkey(property: "newAuthority", keepSize: true)
  ]);

  /// Constructs an SPLTokenSetAuthorityLayout instance from buffer.
  factory SPLTokenSetAuthorityLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: SPLTokenProgramInstruction.setAuthority.insturction);
    return SPLTokenSetAuthorityLayout(
        authorityType: AuthorityType.fromValue(decode["authorityType"]),
        newAuthority: decode["newAuthority"]);
  }

  /// Returns the layout structure.
  @override
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction = SPLTokenProgramInstruction.setAuthority.insturction;

  /// Serializes the layout data.
  @override
  Map<String, dynamic> serialize() {
    return {"authorityType": authorityType.value, "newAuthority": newAuthority};
  }
}
