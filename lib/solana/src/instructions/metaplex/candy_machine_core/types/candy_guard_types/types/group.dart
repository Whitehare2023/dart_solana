import 'package:dart_solana/solana/src/instructions/metaplex/candy_machine_core/types/candy_guard_types/types/guard_set.dart';
import 'package:dart_solana/solana/src/layout/layout.dart';

class Group extends LayoutSerializable {
  final String label;
  final GuardSet guards;

  const Group({required this.label, required this.guards});
  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(label: json["label"], guards: json["guards"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.string("label"),
    GuardSet.staticLayout,
  ], "group");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"label": label, "guards": guards.serialize()};
  }

  @override
  String toString() {
    return "Group${serialize()}";
  }
}
