import 'package:umakvotingapp/supabase/database/row.dart';
import 'package:umakvotingapp/supabase/database/table.dart';

import '../database.dart';

class VotesTable extends SupabaseTable<VotesRow> {
  @override
  String get tableName => 'votes';

  @override
  VotesRow createRow(Map<String, dynamic> data) =>
      VotesRow(data);
}

class VotesRow extends SupabaseDataRow {
  VotesRow(super.data);

  @override
  SupabaseTable get table => VotesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get electionId => getField<String>('election_id');
  set electionId(String? value) => setField<String>('election_id', value);

  String? get studentId => getField<String>('student_id');
  set studentId(String? value) => setField<String>('student_id', value);

  String? get candidateId => getField<String>('candidate_id');
  set candidateId(String? value) => setField<String>('candidate_id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

}
