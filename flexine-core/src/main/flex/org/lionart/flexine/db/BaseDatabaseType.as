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

    import org.lionart.commons.lang.StringBuilder;
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
        /*var className : String = getDriverClassName();
           if (className != null) {
           // this instantiates the driver class which wires in the JDBC glue
           try
           {
           Class.forName(className);
           }
           catch (ClassNotFoundException e)
           {
           throw SqlExceptionUtil.create("Driver class was not found for " + getDatabaseName()
           + " database.  Missing jar with class " + className + ".", e);
           }
         }*/
        }

        public function appendColumnArg( sb : StringBuilder, fieldType : FieldType, additionalArgs : IList, statementsBefore : IList, statementsAfter : IList, queriesAfter : IList ) : void
        {
        /*sb.append(' ');
           var fieldWidth:int;
           switch (fieldType.getDataType()) {

           case DataType.STRING :
           case UUID :
           fieldWidth = fieldType.getWidth();
           if (fieldWidth == 0) {
           fieldWidth = getDefaultVarcharWidth();
           }
           appendStringType(sb, fieldWidth);
           break;

           case LONG_STRING :
           appendLongStringType(sb);
           break;

           case STRING_BYTES :
           appendByteArrayType(sb);
           break;

           case BOOLEAN :
           case BOOLEAN_OBJ :
           appendBooleanType(sb);
           break;

           case DATE :
           case JAVA_DATE :
           fieldWidth = fieldType.getWidth();
           if (fieldWidth == 0) {
           fieldWidth = DEFAULT_DATE_STRING_WIDTH;
           }
           appendDateType(sb, fieldWidth);
           break;

           case DATE_LONG :
           case JAVA_DATE_LONG :
           appendDateLongType(sb);
           break;

           case DATE_STRING :
           case JAVA_DATE_STRING :
           fieldWidth = fieldType.getWidth();
           if (fieldWidth == 0) {
           fieldWidth = DEFAULT_DATE_STRING_WIDTH;
           }
           appendDateStringType(sb, fieldWidth);
           break;

           case CHAR :
           case CHAR_OBJ :
           appendCharType(sb);
           break;

           case BYTE :
           case BYTE_OBJ :
           appendByteType(sb);
           break;

           case BYTE_ARRAY :
           appendByteArrayType(sb);
           break;

           case SHORT :
           case SHORT_OBJ :
           appendShortType(sb);
           break;

           case INTEGER :
           case INTEGER_OBJ :
           appendIntegerType(sb);
           break;

           case LONG :
           case LONG_OBJ :
           appendLongType(sb);
           break;

           case FLOAT :
           case FLOAT_OBJ :
           appendFloatType(sb);
           break;

           case DOUBLE :
           case DOUBLE_OBJ :
           appendDoubleType(sb);
           break;

           case SERIALIZABLE :
           appendSerializableType(sb);
           break;

           case ENUM_STRING :
           appendEnumStringType(sb, fieldType);
           break;

           case ENUM_INTEGER :
           appendEnumIntType(sb, fieldType);
           break;

           case UNKNOWN :
           default :
           // shouldn't be able to get here unless we have a missing case
           throw new IllegalArgumentException("Unknown field type " + fieldType.getDataType());
           }
           sb.append(' ');

           /*
         * NOTE: the configure id methods must be in this order since isGeneratedIdSequence is also isGeneratedId and
         * isId. isGeneratedId is also isId.
         */
        /*if (fieldType.isGeneratedIdSequence() && !fieldType.isSelfGeneratedId()) {
           configureGeneratedIdSequence(sb, fieldType, statementsBefore, additionalArgs, queriesAfter);
           } else if (fieldType.isGeneratedId() && !fieldType.isSelfGeneratedId()) {
           configureGeneratedId(sb, fieldType, statementsBefore, additionalArgs, queriesAfter);
           } else if (fieldType.isId()) {
           configureId(sb, fieldType, statementsBefore, additionalArgs, queriesAfter);
           }
           // if we have a generated-id then neither the not-null nor the default make sense and cause syntax errors
           if (!fieldType.isGeneratedId()) {
           Object defaultValue = fieldType.getDefaultValue();
           if (defaultValue != null) {
           sb.append("DEFAULT ");
           appendDefaultValue(sb, fieldType, defaultValue);
           sb.append(' ');
           }
           if (fieldType.isCanBeNull()) {
           appendCanBeNull(sb, fieldType);
           } else {
           sb.append("NOT NULL ");
           }
           if (fieldType.isUnique()) {
           appendUniqueAfterField(sb, fieldType, statementsAfter);
           }
         }*/
        }

        public function addPrimaryKeySql( fieldTypes : Vector.<FieldType>, additionalArgs : IList, statementsBefore : IList, statementsAfter : IList, queriesAfter : IList ) : void
        {
        }

        public function addUniqueSql( fieldTypes : Vector.<FieldType>, additionalArgs : IList, statementsBefore : IList, statementsAfter : IList, queriesAfter : IList ) : void
        {
        }

        public function dropColumnArg( fieldType : FieldType, statementsBefore : IList, statementsAfter : IList ) : void
        {
        }

        public function appendEscapedEntityName( sb : StringBuilder, word : String ) : void
        {
        }

        public function appendEscapedWord( sb : StringBuilder, word : String ) : void
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

        public function appendLimitValue( sb : StringBuilder, limit : int, offset : int ) : void
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

        public function appendOffsetValue( sb : StringBuilder, offset : int ) : void
        {
        }

        public function appendSelectNextValFromSequence( sb : StringBuilder, sequenceName : String ) : void
        {
        }

        public function appendCreateTableSuffix( sb : StringBuilder ) : void
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


