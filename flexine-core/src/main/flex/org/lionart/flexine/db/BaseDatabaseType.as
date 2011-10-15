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
    import flash.errors.IllegalOperationError;
    import flash.utils.getQualifiedClassName;

    import mx.collections.IList;

    import org.as3commons.lang.StringBuffer;
    import org.lionart.flexine.field.DataType;
    import org.lionart.flexine.field.FieldConverter;
    import org.lionart.flexine.field.FieldType;

    /**
     * Base class for all of the {DatabaseType} classes that provide the per-database type functionality to create
     * tables and build queries.
     *
     * <p>
     * Here's a good page which shows some of the <a href="http://www.1keydata.com/sql/sql-primary-key.html" >differences
     * between SQL versions</a>.
     * </p>
     *
     * @author Ghazi Triki
     */
    public class BaseDatabaseType implements DatabaseType
    {
        protected static const DEFAULT_VARCHAR_WIDTH : int = 255;

        protected static const DEFAULT_DATE_STRING_WIDTH : int = 50;

        protected static const DEFAULT_SEQUENCE_SUFFIX : String = "_id_seq";

        public function BaseDatabaseType()
        {
            if (getQualifiedClassName(this) == "org.lionart.flexine.db::BaseDatabaseType")
            {
                throw new IllegalOperationError("A is abstract, you can't instanciate it directly.");
            }
        }

        /**
         * Return the name of the driver class associated with this database type.
         */
        protected function getDriverClassName() : String
        {
            if (getQualifiedClassName(this) == "org.lionart.flexine.db::BaseDatabaseType")
            {
                throw new IllegalOperationError("A is abstract, this method must be overidden");
            }
            return null;
        }

        /**
         * Return the name of the database for logging purposes.
         */
        protected function getDatabaseName() : String
        {
            if (getQualifiedClassName(this) == "org.lionart.flexine.db::BaseDatabaseType")
            {
                throw new IllegalOperationError("A is abstract, this method must be overidden");
            }
            return null;
        }

        public function isDatabaseUrlThisType( url : String, dbTypePart : String ) : Boolean
        {
            return false;
        }

        /**
         * Not used for AS3
         */
        public function loadDriver() : void
        {
        }

        public function appendColumnArg( sb : StringBuffer, fieldType : FieldType, additionalArgs : IList, statementsBefore : IList, statementsAfter : IList, queriesAfter : IList ) : void
        {
        }

        public function addPrimaryKeySql( fieldTypes : Vector.<FieldType>, additionalArgs : IList, statementsBefore : IList, statementsAfter : IList, queriesAfter : IList ) : void
        {
        }

        public function addUniqueComboSql( fieldTypes : Vector.<FieldType>, additionalArgs : IList, statementsBefore : IList, statementsAfter : IList, queriesAfter : IList ) : void
        {
        }

        public function dropColumnArg( fieldType : FieldType, statementsBefore : IList, statementsAfter : IList ) : void
        {
        }

        public function appendEscapedEntityName( sb : StringBuffer, word : String ) : void
        {
        }

        public function appendEscapedWord( sb : StringBuffer, word : String ) : void
        {
        }

        public function generateIdSequenceName( tableName : String, idFieldType : FieldType ) : String
        {
            return null;
        }

        public function getCommentLinePrefix() : String
        {
            return null;
        }

        public function isIdSequenceNeeded() : Boolean
        {
            return false;
        }

        public function getFieldConverter( dataType : DataType ) : FieldConverter
        {
            return null;
        }

        public function isVarcharFieldWidthSupported() : Boolean
        {
            return false;
        }

        public function isLimitSqlSupported() : Boolean
        {
            return false;
        }

        public function isLimitAfterSelect() : Boolean
        {
            return false;
        }

        public function appendLimitValue( sb : StringBuffer, limit : int, offset : int ) : void
        {
        }

        public function isOffsetSqlSupported() : Boolean
        {
            return false;
        }

        public function isOffsetLimitArgument() : Boolean
        {
            return false;
        }

        public function appendOffsetValue( sb : StringBuffer, offset : int ) : void
        {
        }

        public function appendSelectNextValFromSequence( sb : StringBuffer, sequenceName : String ) : void
        {
        }

        public function appendCreateTableSuffix( sb : StringBuffer ) : void
        {
        }

        public function isCreateTableReturnsZero() : Boolean
        {
            return false;
        }

        public function isEntityNamesMustBeUpCase() : Boolean
        {
            return false;
        }

        public function isNestedSavePointsSupported() : Boolean
        {
            return false;
        }

        public function getPingStatement() : String
        {
            return null;
        }

        public function isBatchUseTransaction() : Boolean
        {
            return false;
        }

        public function isTruncateSupported() : Boolean
        {
            return false;
        }

        public function isCreateIfNotExistsSupported() : Boolean
        {
            return false;
        }
    }
}


