/*
   Copyright (C) 2011 Ghazi Triki <ghazi.nocturne@gmail.com>

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
package org.lionart.flexine.db
{
    import mx.collections.IList;

    import org.lionart.commons.lang.StringBuilder;
    import org.lionart.flexine.field.DataType;
    import org.lionart.flexine.field.FieldConverter;
    import org.lionart.flexine.field.FieldType;

    /**
     * Definition of the per-database functionality needed to isolate the differences between the various databases.
     *
     * @author Ghazi Triki
     */
    public interface DatabaseType
    {
        /**
         * Return true if the database URL corresponds to this database type. Usually the URI is in the form jdbc:ddd:...
         * where ddd is the driver url part.
         */
        function isDatabaseUrlThisType( url : String, dbTypePart : String ) : Boolean;

        /**
         * Load the driver class associated with this database so it can wire itself into JDBC.
         *
         * @throws SQLError
         *             If the driver class is not available in the classpath.
         */
        function loadDriver() : void;

        /**
         * Takes a {FieldType} and appends the SQL necessary to create the field to the string builder. The field may
         * also generate additional arguments which go at the end of the insert statement or additional statements to be
         * executed before or afterwards depending on the configurations. The database can also add to the list of queries
         * that will be performed afterward to test portions of the config.
         */
        function appendColumnArg( sb : StringBuilder, fieldType : FieldType, additionalArgs : IList, statementsBefore : IList, statementsAfter : IList, queriesAfter : IList ) : void;

        /**
         * Appends information about primary key field(s) to the additional-args or other lists.
         */
        function addPrimaryKeySql( fieldTypes : Vector.<FieldType>, additionalArgs : IList, statementsBefore : IList, statementsAfter : IList, queriesAfter : IList ) : void;

        /**
         * Appends information about unique field(s) to the additional-args or other lists.
         */
        function addUniqueComboSql( fieldTypes : Vector.<FieldType>, additionalArgs : IList, statementsBefore : IList, statementsAfter : IList, queriesAfter : IList ) : void;

        /**
         * Takes a {@link FieldType} and adds the necessary statements to the before and after lists necessary so that the
         * dropping of the table will succeed and will clear other associated sequences or other database artifacts
         */
        function dropColumnArg( fieldType : FieldType, statementsBefore : IList, statementsAfter : IList ) : void;

        /**
         * Add a entity-name word to the string builder wrapped in the proper characters to escape it. This avoids problems
         * with table, column, and sequence-names being reserved words.
         */
        function appendEscapedEntityName( sb : StringBuilder, word : String ) : void;

        /**
         * Add the word to the string builder wrapped in the proper characters to escape it. This avoids problems with data
         * values being reserved words.
         */
        function appendEscapedWord( sb : StringBuilder, word : String ) : void;

        /**
         * Return the name of an ID sequence based on the tabelName and the fieldType of the id.
         */
        function generateIdSequenceName( tableName : String, idFieldType : FieldType ) : String;

        /**
         * Return the prefix to put at the front of a SQL line to mark it as a comment.
         */
        function getCommentLinePrefix() : String;

        /**
         * Return true if the database needs a sequence when you use generated IDs. Some databases (H2, MySQL) create them
         * auto-magically. This also means that the database needs to query for a sequence value <i>before</i> the object is
         * inserted. For old[er] versions of Postgres, for example, the JDBC call-back stuff to get the just-inserted id
         * value does not work so we have to get the next sequence value by hand, assign it into the object, and then insert
         * the object -- yes two SQL statements.
         */
        function isIdSequenceNeeded() : Boolean;

        /**
         * Return the FieldConverter to associate with the DataType. This allows the database instance to convert a field as
         * necessary before it goes to the database.
         */
        function getFieldConverter( dataType : DataType ) : FieldConverter;

        /**
         * Return true if the database supports the width parameter on VARCHAR fields.
         */
        function isVarcharFieldWidthSupported() : Boolean;

        /**
         * Return true if the database supports the LIMIT SQL command. Otherwise we have to use the
         * {@link PreparedStatement#setMaxRows} instead. See prepareSqlStatement in MappedPreparedQuery.
         */
        function isLimitSqlSupported() : Boolean;

        /**
         * Return true if the LIMIT should be called after SELECT otherwise at the end of the WHERE (the default).
         */
        function isLimitAfterSelect() : Boolean;

        /**
         * Append to the string builder the necessary SQL to limit the results to a certain number. With some database
         * types, the offset is an argument to the LIMIT so the offset value (which could be null or not) is passed in. The
         * database type can choose to ignore it.
         */
        function appendLimitValue( sb : StringBuilder, limit : int, offset : int ) : void;

        /**
         * Return true if the database supports the OFFSET SQL command in some form.
         */
        function isOffsetSqlSupported() : Boolean;

        /**
         * Return true if the database supports the offset as a comma argument from the limit. This also means that the
         * limit _must_ be specified if the offset is specified
         */
        function isOffsetLimitArgument() : Boolean;

        /**
         * Append to the string builder the necessary SQL to start the results at a certain row number.
         */
        function appendOffsetValue( sb : StringBuilder, offset : int ) : void;

        /**
         * Append the SQL necessary to get the next-value from a sequence. This is only necessary if
         * {@link #isIdSequenceNeeded} is true.
         */
        function appendSelectNextValFromSequence( sb : StringBuilder, sequenceName : String ) : void;

        /**
         * Append the SQL necessary to properly finish a CREATE TABLE line.
         */
        function appendCreateTableSuffix( sb : StringBuilder ) : void;

        /**
         * Returns true if a 'CREATE TABLE' statement should return 0. False if > 0.
         */
        function isCreateTableReturnsZero() : Boolean;

        /**
         * Returns true if table and field names should be made uppercase.
         *
         * <p>
         * Turns out that Derby and Hsqldb are doing something wrong (IMO) with entity names. If you create a table with the
         * name "footable" (with the quotes) then it will be created as lowercase footable, case sensitive. However, if you
         * then issue the query 'select * from footable' (without quotes) it won't find the table because it gets promoted
         * to be FOOTABLE and is searched in a case sensitive manner. So for these databases, entity names have to be forced
         * to be uppercase so external queries will also work.
         * </p>
         */
        function isEntityNamesMustBeUpCase() : Boolean;

        /**
         * Returns true if nested savePoints are supported, otherwise false.
         */
        function isNestedSavePointsSupported() : Boolean;

        /**
         * Return an statement that doesn't do anything but which can be used to ping the database by sending it over a
         * database connection.
         */
        function getPingStatement() : String;

        /**
         * Returns true if batch operations should be done inside of a transaction. Default is false in which case
         * auto-commit disabling will be done.
         */
        function isBatchUseTransaction() : Boolean;

        /**
         * Returns true if the table truncate operation is supported.
         */
        function isTruncateSupported() : Boolean;

        /**
         * Returns true if the table creation IF NOT EXISTS syntax is supported.
         */
        function isCreateIfNotExistsSupported() : Boolean;
    }
}


