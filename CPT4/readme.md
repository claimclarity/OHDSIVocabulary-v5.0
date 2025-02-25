Update of CPT4

Prerequisites:
- Schema DevV5 with copies of tables concept, concept_relationship and concept_synonym from ProdV5, fully indexed. 
- UMLS in SOURCES schema
- SNOMED must be loaded first
- Working directory CPT4


1. Run SELECT devv5.FastRecreateSchema(main_schema_name=>'devv5', include_concept_ancestor=>true, include_deprecated_rels=>true, include_synonyms=>true);

2. Run load_stage.sql (The pVocabularyDate will be automatically retrieved from the UMLS [SOURCES.MRSMAP.vocabulary_date])

3. Run generic_update:
```sql
DO $_$
BEGIN
	PERFORM devv5.GenericUpdate();
END $_$;
```
4. Run basic tables check (should retrieve NULL):
```sql
SELECT * FROM qa_tests.get_checks();
```
5. Work with 'manual work' directory

Repeat steps 1-5

6. Run [manual_checks_after_generic.sql](https://github.com/OHDSI/Vocabulary-v5.0/blob/master/working/manual_checks_after_generic.sql), and interpret the results.

7. Run scripts to get summary, and interpret the results:
```sql
SELECT * FROM qa_tests.get_summary('concept');
```
```sql
SELECT * FROM qa_tests.get_summary('concept_relationship');
```
8. Run scripts to collect statistics, and interpret the results:
```sql
SELECT * FROM qa_tests.get_domain_changes();
```
```sql
SELECT * FROM qa_tests.get_newly_concepts();
```
```sql
SELECT * FROM qa_tests.get_standard_concept_changes();
```
```sql
SELECT * FROM qa_tests.get_newly_concepts_standard_concept_status();
```
```sql
SELECT * FROM qa_tests.get_changes_concept_mapping();
```
9. If no problems, enjoy!

Manual tables directory permalink: https://drive.google.com/drive/u/0/folders/1TWGdyVy95AT-9GfK7KaKY2HQA4rDqxrH

