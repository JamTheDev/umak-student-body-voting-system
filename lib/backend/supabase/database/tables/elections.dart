import 'package:umakvotingapp/supabase/database/row.dart';
import 'package:umakvotingapp/supabase/database/table.dart';


class ElectionsTable extends SupabaseTable<ElectionsRow> {
  @override
  String get tableName => 'elections';

  @override
  ElectionsRow createRow(Map<String, dynamic> data) =>
      ElectionsRow(data);
}

class ElectionsRow extends SupabaseDataRow {
  ElectionsRow(super.data);

  @override
  SupabaseTable get table => ElectionsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  DateTime get startTime => getField<DateTime>('start_time')!;
  set startTime(DateTime value) => setField<DateTime>('start_time', value);

  DateTime get endTime => getField<DateTime>('end_time')!;
  set endTime(DateTime value) => setField<DateTime>('end_time', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

}
