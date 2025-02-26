import 'package:umakvotingapp/supabase/database/row.dart';
import 'package:umakvotingapp/supabase/database/table.dart';

import '../database.dart';

class StudentsTable extends SupabaseTable<StudentsRow> {
  @override
  String get tableName => 'students';

  @override
  StudentsRow createRow(Map<String, dynamic> data) =>
      StudentsRow(data);
}

class StudentsRow extends SupabaseDataRow {
  StudentsRow(super.data);

  @override
  SupabaseTable get table => StudentsTable();

  String get studentId => getField<String>('student_id')!;
  set studentId(String value) => setField<String>('student_id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

}
