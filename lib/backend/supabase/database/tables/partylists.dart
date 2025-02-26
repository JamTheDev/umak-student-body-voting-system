import 'package:umakvotingapp/supabase/database/row.dart';
import 'package:umakvotingapp/supabase/database/table.dart';

import '../database.dart';

class PartylistsTable extends SupabaseTable<PartylistsRow> {
  @override
  String get tableName => 'partylists';

  @override
  PartylistsRow createRow(Map<String, dynamic> data) =>
      PartylistsRow(data);
}

class PartylistsRow extends SupabaseDataRow {
  PartylistsRow(super.data);

  @override
  SupabaseTable get table => PartylistsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String get abbreviation => getField<String>('abbreviation')!;
  set abbreviation(String value) => setField<String>('abbreviation', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

}
