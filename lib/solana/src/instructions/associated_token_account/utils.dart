import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:dart_solana/solana/src/address/sol_address.dart';
import 'package:dart_solana/solana/src/instructions/associated_token_account/constant.dart';
import 'package:dart_solana/solana/src/instructions/instructions.dart';
import 'package:dart_solana/solana/src/models/pda/pda.dart';

class AssociatedTokenAccountProgramUtils {
  /// Finds the address of the Associated Token Account.
  static ProgramDerivedAddress associatedTokenAccount({
    required SolAddress mint,
    required SolAddress owner,
    SolAddress programId =
        AssociatedTokenAccountProgramConst.associatedTokenProgramId,
    SolAddress tokenProgramId = SPLTokenProgramConst.tokenProgramId,
    bool allowOwnerOffCurve = false,
  }) {
    if (!allowOwnerOffCurve && !owner.isOnCurve) {
      throw MessageException("Public key address is not valid on the curve.");
    }
    return ProgramDerivedAddress.find(
        seedBytes: [owner.toBytes(), tokenProgramId.toBytes(), mint.toBytes()],
        programId: programId);
  }
}
