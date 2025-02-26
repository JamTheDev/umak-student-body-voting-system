import 'package:umakvotingapp/supabase/database/row.dart';
import 'package:umakvotingapp/supabase/database/table.dart';

import '../database.dart';

class CollegesTable extends SupabaseTable<CollegesRow> {
  @override
  String get tableName => 'colleges';

  @override
  CollegesRow createRow(Map<String, dynamic> data) =>
      CollegesRow(data);
}

class CollegesRow extends SupabaseDataRow {
  CollegesRow(super.data);

  @override
  SupabaseTable get table => CollegesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get acronym => getField<String>('acronym')!;
  set acronym(String value) => setField<String>('acronym', value);

  String get fullName => getField<String>('full_name')!;
  set fullName(String value) => setField<String>('full_name', value);

  String? get logoUrl => getField<String>('logo_url');
  set logoUrl(String? value) => setField<String>('logo_url', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

}
