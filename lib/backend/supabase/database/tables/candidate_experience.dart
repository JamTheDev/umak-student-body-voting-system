import 'package:umakvotingapp/supabase/database/row.dart';
import 'package:umakvotingapp/supabase/database/table.dart';

import '../database.dart';

class CandidateExperienceTable extends SupabaseTable<CandidateExperienceRow> {
  @override
  String get tableName => 'candidate_experience';

  @override
  CandidateExperienceRow createRow(Map<String, dynamic> data) =>
      CandidateExperienceRow(data);
}

class CandidateExperienceRow extends SupabaseDataRow {
  CandidateExperienceRow(super.data);

  @override
  SupabaseTable get table => CandidateExperienceTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get candidateId => getField<String>('candidate_id');
  set candidateId(String? value) => setField<String>('candidate_id', value);

  String get organization => getField<String>('organization')!;
  set organization(String value) => setField<String>('organization', value);

  String get position => getField<String>('position')!;
  set position(String value) => setField<String>('position', value);

  String get startDate => getField<String>('start_date')!;
  set startDate(String value) => setField<String>('start_date', value);

  String? get endDate => getField<String>('end_date');
  set endDate(String? value) => setField<String>('end_date', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

}
