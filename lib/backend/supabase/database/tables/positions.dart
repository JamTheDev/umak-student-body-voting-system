import 'package:umakvotingapp/supabase/database/row.dart';
import 'package:umakvotingapp/supabase/database/table.dart';

import '../database.dart';

class PositionsTable extends SupabaseTable<PositionsRow> {
  @override
  String get tableName => 'positions';

  @override
  PositionsRow createRow(Map<String, dynamic> data) =>
      PositionsRow(data);
}

class PositionsRow extends SupabaseDataRow {
  PositionsRow(super.data);

  @override
  SupabaseTable get table => PositionsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get electionId => getField<String>('election_id');
  set electionId(String? value) => setField<String>('election_id', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  int get prio => getField<int>('prio')!;
  set prio(int value) => setField<int>('prio', value);

  String? get order => getField<String>('order');
  set order(String? value) => setField<String>('order', value);

}
