DO $_$
DECLARE
z text;
BEGIN
  z:=$FUNCTIONBODY$
    CREATE OR REPLACE FUNCTION vocabulary_download.get_cdm_prepare (iPath text, iFilename text)
    RETURNS void AS
    $BODY$#!/bin/bash
    #set permissions=775 by default
    umask 002 && \
    cd "$1/work" && \
    unzip -oqjC "$2" "*/PostgreSQL/*ddl*" -d .
    
    #move result to original folder
    cd "$1"
    rm -f *.*
    mv work/*.sql "PostgreSQL_DDL.sql"
    $BODY$
    LANGUAGE 'plsh'
    SECURITY DEFINER;
  $FUNCTIONBODY$;
  --convert CRLF to LF for bash
  EXECUTE REPLACE(z,E'\r','');
END $_$;