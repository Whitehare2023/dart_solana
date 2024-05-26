import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/spl_token_swap/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class SPLTokenSwapAccountUtils {
  static Structure layout = LayoutUtils.struct([
    LayoutUtils.u8('version'),
    LayoutUtils.boolean(property: 'isInitialized'),
    LayoutUtils.u8('bumpSeed'),
    LayoutUtils.publicKey('poolTokenProgramId'),
    LayoutUtils.publicKey('tokenAccountA'),
    LayoutUtils.publicKey('tokenAccountB'),
    LayoutUtils.publicKey('tokenPool'),
    LayoutUtils.publicKey('mintA'),
    LayoutUtils.publicKey('mintB'),
    LayoutUtils.publicKey('feeAccount'),
    TokenSwapFees.staticLayout,
    LayoutUtils.u8('curveType'),
    LayoutUtils.blob(32, property: 'curveParameters'),
  ]);
  static int get size => layout.span;
}

class SPLTokenSwapAccount extends LayoutSerializable {
  final int version;

  /// Is the swap initialized, with data written to it
  final bool isInitialized;

  /// Bump seed used to generate the program address / authority
  final int bumpSeed;

  /// Token program ID associated with the swap
  final SolAddress poolTokenProgramId;

  /// Address of token A liquidity account
  final SolAddress tokenAccountA;

  /// Address of token B liquidity account
  final SolAddress tokenAccountB;

  /// Address of pool token mint
  final SolAddress tokenPool;

  /// Address of token A mint
  final SolAddress mintA;

  /// Address of token B mint
  final SolAddress mintB;

  /// Address of pool fee account
  final SolAddress feeAccount;

  final TokenSwapFees fees;

  /// Curve associated with swap
  final SPLTokenSwapCurveType curveType;
  final List<int> curveParameters;

  SPLTokenSwapAccount({
    required this.version,
    required this.isInitialized,
    required this.bumpSeed,
    required this.poolTokenProgramId,
    required this.tokenAccountA,
    required this.tokenAccountB,
    required this.tokenPool,
    required this.mintA,
    required this.mintB,
    required this.feeAccount,
    required this.fees,
    required this.curveType,
    required List<int> curveParameters,
  }) : curveParameters =
            BytesUtils.toBytes(curveParameters, unmodifiable: true);
  factory SPLTokenSwapAccount.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data, layout: SPLTokenSwapAccountUtils.layout);
    return SPLTokenSwapAccount.fromJson(decode);
  }
  factory SPLTokenSwapAccount.fromJson(Map<String, dynamic> json) {
    return SPLTokenSwapAccount(
      version: json['version'],
      isInitialized: json['isInitialized'],
      bumpSeed: json['bumpSeed'],
      poolTokenProgramId: json['poolTokenProgramId'],
      tokenAccountA: json['tokenAccountA'],
      tokenAccountB: json['tokenAccountB'],
      tokenPool: json['tokenPool'],
      mintA: json['mintA'],
      mintB: json['mintB'],
      feeAccount: json['feeAccount'],
      fees: TokenSwapFees.fromJson(json["fees"]),
      curveType: SPLTokenSwapCurveType.fromValue(json['curveType']),
      curveParameters: (json['curveParameters'] as List).cast(),
    );
  }

  @override
  Structure get layout => SPLTokenSwapAccountUtils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'version': version,
      'isInitialized': isInitialized,
      'bumpSeed': bumpSeed,
      'poolTokenProgramId': poolTokenProgramId,
      'tokenAccountA': tokenAccountA,
      'tokenAccountB': tokenAccountB,
      'tokenPool': tokenPool,
      'mintA': mintA,
      'mintB': mintB,
      'feeAccount': feeAccount,
      'fees': fees.serialize(),
      'curveType': curveType.value,
      'curveParameters': curveParameters,
    };
  }

  @override
  String toString() {
    return "SPLTokenSwapAccount${serialize()}";
  }
}
