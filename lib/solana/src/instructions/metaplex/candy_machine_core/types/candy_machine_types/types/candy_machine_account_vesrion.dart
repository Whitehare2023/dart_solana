import 'package:blockchain_utils/exception/exception.dart';
import 'package:dart_solana/solana/src/layout/layout.dart';

class CandyMachineAccountVersion extends LayoutSerializable {
  final String name;
  const CandyMachineAccountVersion._(this.name);
  static const CandyMachineAccountVersion v1 =
      CandyMachineAccountVersion._("V1");
  static const CandyMachineAccountVersion v2 =
      CandyMachineAccountVersion._("V2");

  static const List<CandyMachineAccountVersion> values = [v1, v2];
  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum(
        values.map((e) => LayoutUtils.none(e.name)).toList(), LayoutUtils.u8(),
        property: "candyMachineAccountVersion")
  ]);

  static CandyMachineAccountVersion fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw MessageException(
          "No CandyMachineAccountVersion found matching the specified value",
          details: {"value": value}),
    );
  }

  factory CandyMachineAccountVersion.fromJson(Map<String, dynamic> json) {
    return fromName(json["candyMachineAccountVersion"]["key"]);
  }

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "candyMachineAccountVersion": {name: null}
    };
  }

  @override
  String toString() {
    return "CandyMachineAccountVersion.$name";
  }
}
