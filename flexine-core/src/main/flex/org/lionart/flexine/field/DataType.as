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
package org.lionart.flexine.field
{
    import flash.errors.SQLError;

    import mx.formatters.DateFormatter;

    import org.lionart.commons.lang.Enum;
    import org.lionart.flexine.misc.SqlExceptionUtil;
    import org.lionart.flexine.support.DatabaseResults;

    /**
     * Data type enumeration to provide ActionScript class to/from database mapping.
     *
     * <p>
     * <b>NOTE:</b> If you add types here you will need to add to the various DatabaseType implementors' appendColumnArg()
     * method.
     * </p>
     *
     * <p>
     * Here's a good page about the <a href="http://docs.codehaus.org/display/CASTOR/Type+Mapping" >mapping for a number of
     * database types</a>:
     * </p>
     *
     * @author Ghazi Triki
     */
    public class DataType extends Enum implements FieldConverter
    {
        public static const STRING : DataType = new DataType(SqlType.STRING, new Vector.<Class>(String));
        public static const INTEGER : DataType = new DataType(SqlType.INTEGER, new Vector.<Class>(int));
        public static const NUMBER : DataType = new DataType(SqlType.NUMBER, new Vector.<Class>(Number));
        public static const BOOLEAN : DataType = new DataType(SqlType.BOOLEAN, new Vector.<Class>(Boolean));
        public static const DATE : DataType = new DataType(SqlType.DATE, new Vector.<Class>(Date));
        //public static const DATE_STRING : DataType = new DateStringDataType(SqlType.STRING, new Vector.<Class>(Date));
        public static const OBJECT : DataType = new DataType(SqlType.OBJECT, new Vector.<Class>(Object));
        public static const XML : DataType = new DataType(SqlType.XML, new Vector.<Class>(XML));
        public static const XML_LIST : DataType = new DataType(SqlType.OBJECT, new Vector.<Class>(XMLList));
        public static const NONE : DataType = new DataType(SqlType.NONE, new Vector.<Class>(null));

        public static const DEFAULT_DATE_FORMAT_CONFIG : DateStringFormatConfig = new DateStringFormatConfig("YYYY-MM-DD HH:NN:SS.QQQ");

        private var _sqlType : SqlType;

        private var _classes : Vector.<Class>;

        public function DataType( value : SqlType, classes : Vector.<Class> )
        {
            _sqlType = sqlType;
            // only types which have overridden the convertNumber method can be generated
            _classes = classes;
            _value = value.getValue();
        }

        public function parseDefaultString( fieldType : FieldType, defaultStr : String ) : Object
        {
            if (this.sqlType.equals(SqlType.STRING))
            {
                return defaultStr;
            }
            else if (this.sqlType.equals(SqlType.BOOLEAN))
            {
                return Boolean(defaultStr);
            }
            else if (this.sqlType.equals(SqlType.DATE))
            {
                var dateFormatConfig : DateStringFormatConfig = convertDateStringConfig(fieldType);
                var retrunDate : Date;
                try
                {
                    retrunDate = new Date(parseDateString(dateFormatConfig, defaultStr).getTime());
                }
                catch ( e : SQLError )
                {
                    throw SqlExceptionUtil.create("Problems parsing default date string '" + defaultStr + "' using '" + dateFormatConfig + '\'', e.message);
                }
                return retrunDate;
            }
            else if (this.sqlType.equals(SqlType.INTEGER))
            {
                return parseInt(defaultStr);
            }
            else if (this.sqlType.equals(SqlType.NUMBER))
            {
                return parseFloat(defaultStr);
            }
            else if (this.sqlType.equals(SqlType.XML))
            {
                // TODO
                return defaultStr;
            }
            else if (this.sqlType.equals(SqlType.XML_LIST))
            {
                // TODO
                return defaultStr;
            }
            else if (this.sqlType.equals(SqlType.OBJECT))
            {
                throw new SQLError("Object type cannot have a default value");
            }
            else if (this.sqlType.equals(SqlType.NONE))
            {
                return null;
            }
            throw new SQLError("This method is unvailable directly from DataType");
        }

        public function asToSqlArg( fieldType : FieldType, obj : Object ) : Object
        {
            if (this.sqlType.equals(SqlType.DATE))
            {
                var date : Date = obj as Date;
                return new Date(date.getTime());
            }
            else if (this.sqlType.equals(SqlType.NONE))
            {
                return null;
            }
            return obj;
        }

        public function resultToAs( fieldType : FieldType, results : DatabaseResults, columnPos : int ) : Object
        {
            if (this.sqlType.equals(SqlType.STRING))
            {
                return results.getString(columnPos);
            }
            else if (this.sqlType.equals(SqlType.BOOLEAN))
            {
                return Boolean(results.getBoolean(columnPos));
            }
            else if (this.sqlType.equals(SqlType.DATE))
            {
                var timeStamp : Date = results.getDate(columnPos);
                if (timeStamp == null)
                {
                    return null;
                }
                else
                {
                    return new Date(timeStamp.getTime());
                }
            }
            else if (this.sqlType.equals(SqlType.OBJECT))
            {
                return Object(results.getObject(columnPos));
            }
            else if (this.sqlType.equals(SqlType.INTEGER))
            {
                return results.getInteger(columnPos) as int;
            }
            else if (this.sqlType.equals(SqlType.NUMBER))
            {
                return results.getNumber(columnPos) as Number;
            }
            else if (this.sqlType.equals(SqlType.XML))
            {
                return results.getXML(columnPos);
            }
            else if (this.sqlType.equals(SqlType.XML_LIST))
            {
                return results.getXMLList(columnPos);
            }
            else if (this.sqlType.equals(SqlType.NONE))
            {
                return null;
            }
            throw new SQLError("This method is unvailable directly from DataType");
        }

        private var sqlType : SqlType;

        public function getSqlType() : SqlType
        {
            return sqlType;
        }

        public function isStreamType() : Boolean
        {
            return false;
        }

        /**
         * Convert a {Number} object to its primitive object suitable for assigning to an ID field.
         */
        public function convertIdNumber( number : Number ) : Object
        {
            // by default the type cannot convert an id number
            if (!this.sqlType.equals(SqlType.INTEGER))
            {
                return null;
            }
            return int(number);
        }

        /**
         * Return true if this type can be auto-generated by the database. Probably only numbers will return true.
         */
        public function isValidGeneratedType() : Boolean
        {
            if (!this.sqlType.equals(SqlType.INTEGER))
            {
                return false;
            }
            return true;
        }

        /**
         * Return true if the fieldClass is appropriate for this enum.
         */
        public function isValidForType( fieldClass : Class ) : Boolean
        {
            // by default this is a noop
            return true;
        }

        /**
         * Return whether this field's default value should be escaped in SQL.
         */
        public function isEscapedDefaultValue() : Boolean
        {
            // default is to not escape the type if it is a number
            return isEscapedValue();
        }

        /**
         * Return whether this field is a number.
         */
        public function isEscapedValue() : Boolean
        {
            if (this.sqlType.equals(SqlType.BOOLEAN) || this.sqlType.equals(SqlType.INTEGER)
                || this.sqlType.equals(SqlType.NUMBER) || this.sqlType.equals(SqlType.XML)
                || this.sqlType.equals(SqlType.XML_LIST) || this.sqlType.equals(SqlType.NONE))
            {
                return false;
            }
            return true;
        }

        /**
         * Return whether this field is a primitive type or not. This is used to know if we should throw if the field value
         * is null.
         */
        public function isPrimitive() : Boolean
        {
            if (this.sqlType.equals(SqlType.BOOLEAN) || this.sqlType.equals(SqlType.INTEGER) &&
                this.sqlType.equals(SqlType.NUMBER) || this.sqlType.equals(SqlType.STRING))
            {
                return true;
            }
            return false;
        }

        /**
         * Return true if this data type be compared in SQL statements.
         */
        public function isComparable() : Boolean
        {
            if (!this.sqlType.equals(SqlType.NONE))
            {
                return true;
            }
            return false;
        }

        /**
         * Return true if this data type can be an id column in a class.
         */
        public function isAppropriateId() : Boolean
        {
            if (!this.sqlType.equals(SqlType.NONE) && !this.sqlType.equals(SqlType.OBJECT) && !this.sqlType.equals(SqlType.BOOLEAN))
            {
                return true;
            }
            return false;
        }

        /**
         * Must use SelectArg when querying for values of this type.
         */
        public function isSelectArgRequired() : Boolean
        {
            if (this.sqlType.equals(SqlType.DATE) && this.sqlType.equals(SqlType.OBJECT))
            {
                return true;
            }
            return false;
        }

        /**
         * Return true if this type creates its own generated ids else false to have the database do it.
         */
        public function isSelfGeneratedId() : Boolean
        {
            return false;
        }

        /**
         * Return a generated id if appropriate or null if none.
         */
        public function generatedId() : Object
        {
            return null;
        }

        protected function parseDateString( formatConfig : DateStringFormatConfig, dateStr : String ) : Date
        {
            var resultDate : Date = DateFormatter.parseDateString(dateStr);
            if (resultDate == null)
            {
                throw new SQLError("String value is malformed, it cannot be transformed to Date");
            }
            return resultDate;
        }

        /**
         * This makes a configuration object for the data-type or returns null if none. The object can be accessed later via
         * {FieldType#getDataTypeConfigObj()}.
         */
        public function makeConfigObject( fieldType : FieldType ) : Object
        {
            if (this.sqlType.equals(SqlType.DATE))
            {
                var format : String = fieldType.getFormat();
                if (format == null)
                {
                    return DEFAULT_DATE_FORMAT_CONFIG;
                }
                else
                {
                    return new DateStringFormatConfig(format);
                }
            }
            throw new SQLError("This method is unvailable directly from DataType");
        }


        protected static function convertDateStringConfig( fieldType : FieldType ) : DateStringFormatConfig
        {
            if (fieldType == null)
            {
                return DEFAULT_DATE_FORMAT_CONFIG;
            }
            var configObj : DateStringFormatConfig = DateStringFormatConfig(fieldType.getDataTypeConfigObj());
            if (configObj == null)
            {
                return DEFAULT_DATE_FORMAT_CONFIG
            }
            else
            {
                return DateStringFormatConfig(configObj);
            }
        }

        protected static function normalizeDateString( formatConfig : DateStringFormatConfig, dateStr : String ) : String
        {
            var dateFormatter : DateFormatter = formatConfig.getDateFormatter();
            var date : Date = DateFormatter.parseDateString(dateStr);
            if (date == null)
            {
                throw new SQLError("String value is malformed, it cannot be transformed to Date");
            }
            return dateFormatter.format(date);
        }

        protected static function formatDate( formatConfig : DateStringFormatConfig, date : Date ) : String
        {
            var dateFormat : DateFormatter = formatConfig.getDateFormatter();
            return dateFormat.format(date);
        }

    }

}

import flash.errors.SQLError;

import mx.formatters.DateFormatter;

import org.lionart.flexine.field.DataType;
import org.lionart.flexine.field.FieldType;
import org.lionart.flexine.field.SqlType;
import org.lionart.flexine.misc.SqlExceptionUtil;
import org.lionart.flexine.support.DatabaseResults;

/**
 * Persists the Date primitive.
 */
/*internal class DateStringDataType extends DataType
   {
   public function DateStringDataType( value : SqlType, classes : Vector.<Class> )
   {
   super(value, classes);
   }

   override public function resultToAs( fieldType : FieldType, results : DatabaseResults, columnPos : int ) : Object
   {
   var dateStr : String = results.getString(columnPos);
   var returnDate : Date;
   if (dateStr == null)
   {
   return null;
   }
   var formatConfig : DateStringFormatConfig = convertDateStringConfig(fieldType);
   try
   {
   returnDate = parseDateString(formatConfig, dateStr);
   }
   catch ( e : SQLError )
   {
   throw SqlExceptionUtil.create("Problems with column " + columnPos + " parsing date-string '" + dateStr + "' using '" + formatConfig + "'", e.message);
   }
   return returnDate;
   }

   override public function parseDefaultString( fieldType : FieldType, defaultStr : String ) : Object
   {
   var formatConfig : DateStringFormatConfig = convertDateStringConfig(fieldType);
   var returnSrt : String;
   try
   {
   // we parse to make sure it works and then format it again
   returnSrt = normalizeDateString(formatConfig, defaultStr);
   }
   catch ( e : SQLError )
   {
   throw SqlExceptionUtil.create("Problems with field " + fieldType + " parsing default date-string '" + defaultStr + "' using '" + formatConfig + "'", e.message);
   }
   return returnSrt;
   }

   override public function asToSqlArg( fieldType : FieldType, obj : Object ) : Object
   {
   var date : Date = obj as Date;
   return formatDate(convertDateStringConfig(fieldType), date);
   }

 }*/

