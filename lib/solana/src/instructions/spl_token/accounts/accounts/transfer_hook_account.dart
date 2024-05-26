import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:solana/solana/src/instructions/instructions.dart';
import 'package:solana/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout =
      LayoutUtils.struct([LayoutUtils.boolean(property: 'transferring')]);

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
              extensionType: ExtensionType.transferHookAccount);
      return LayoutSerializable.decode(bytes: extensionBytes, layout: layout);
    } catch (e) {
      throw MessageException("Invalid extionsion bytes");
    }
  }
}

/// Indicates that the tokens from this account belong to a mint with a transfer
/// hook
class TransferHookAccount extends LayoutSerializable {
  /// Flag to indicate that the account is in the middle of a transfer
  final bool transferring;
  const TransferHookAccount({required this.transferring});

  factory TransferHookAccount.fromBuffer(List<int> extensionData) {
    final decode = _Utils.decode(extensionData);
    return TransferHookAccount(transferring: decode["transferring"]);
  }
  factory TransferHookAccount.fromAccountBytes(List<int> accountBytes) {
    final decode = _Utils.decodeFromAccount(accountBytes);
    return TransferHookAccount(transferring: decode["transferring"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {"transferring": transferring};
  }

  @override
  String toString() {
    return "TransferHookAccount${serialize()}";
  }
}
