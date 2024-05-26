import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:dart_solana/solana/src/instructions/instructions.dart';
import 'package:dart_solana/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout =
      LayoutUtils.struct([LayoutUtils.boolean(property: 'lockCpi')]);

  static int get accountSize => layout.span;

  static Map<String, dynamic> decode(List<int> extensionData) {
    try {
      if (extensionData.length < accountSize) {
        throw MessageException("Account data length is insufficient.",
            details: {"Expected": accountSize, "length": extensionData.length});
      }
      return LayoutSerializable.decode(bytes: extensionData, layout: layout);
    } catch (e) {
      throw MessageException("Invalid extionsion bytes");
    }
  }

  static Map<String, dynamic> decodeFromAccount(List<int> accountBytes) {
    try {
      final extensionBytes =
          SPLToken2022Utils.readExtionsionBytesFromAccountData(
              accountBytes: accountBytes,
              extensionType: ExtensionType.cpiGuard);
      return LayoutSerializable.decode(bytes: extensionBytes, layout: layout);
    } catch (e) {
      throw MessageException("Invalid extionsion bytes");
    }
  }
}

/// CPI Guard extension for Accounts
class CpiGuard extends LayoutSerializable {
  /// Lock privileged token operations from happening via CPI
  final bool lockCpi;
  const CpiGuard({required this.lockCpi});

  factory CpiGuard.fromBuffer(List<int> extensionData) {
    final decode = _Utils.decode(extensionData);
    return CpiGuard(lockCpi: decode["lockCpi"]);
  }
  factory CpiGuard.fromAccountBytes(List<int> accountBytes) {
    final decode = _Utils.decodeFromAccount(accountBytes);
    return CpiGuard(lockCpi: decode["lockCpi"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {"lockCpi": lockCpi};
  }

  @override
  String toString() {
    return "CpiGuard${serialize()}";
  }
}
