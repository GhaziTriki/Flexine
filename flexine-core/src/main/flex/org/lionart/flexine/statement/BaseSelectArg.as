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
package org.lionart.flexine.statement
{
    import flash.errors.IllegalOperationError;
    import flash.errors.SQLError;

    import org.lionart.flexine.field.FieldType;

    /**
     * Base class for other select argument classes.
     *
     * @author Ghazi Triki
     */
    public class BaseSelectArg implements ArgumentHolder
    {
        private var _columnName : String = null;
        private var _fieldType : FieldType = null;

        /**
         * Return the stored value.
         */
        protected function getValue() : Object
        {
            throw new SQLError("This method is unvailable directly from BaseSelectArg");
        }

        /**
         * Store the value.
         */
        public function setValue( value : Object ) : void
        {
            throw new SQLError("This method is unvailable directly from BaseSelectArg");
        }

        /**
         * Return true if the value is set.
         */
        protected function isValueSet() : Boolean
        {
            throw new SQLError("This method is unvailable directly from BaseSelectArg");
        }

        /**
         * Return the column-name associated with this argument. The name is set by the package internally.
         */
        public function getColumnName() : String
        {
            if (_columnName == null)
            {
                throw new IllegalOperationError("Column name has not been set");
            }
            else
            {
                return _columnName;
            }
        }

        /**
         * Used internally by the package to set the column-name associated with this argument.
         */
        public function setMetaInfo( columnName : String, fieldType : FieldType ) : void
        {
            if (this._columnName == null)
            {
                // not set yet
            }
            else if (this._columnName == columnName)
            {
                // set to the same value as before
            }
            else
            {
                throw new IllegalOperationError("Column name cannot be set twice from " + this._columnName + " to "
                    + columnName);
            }
            if (this._fieldType == null)
            {
                // not set yet
            }
            else if (this._fieldType == fieldType)
            {
                // set to the same value as before
            }
            else
            {
                throw new IllegalOperationError("FieldType name cannot be set twice from " + this._fieldType + " to "
                    + fieldType);
            }
            this._columnName = columnName;
            this._fieldType = fieldType;
        }

        /**
         * Return the value associated with this argument. The value should be set by the user before it is consumed.
         */
        public function getSqlArgValue() : Object
        {
            if (!isValueSet())
            {
                throw new SQLError("Column value has not been set for " + _columnName);
            }
            var value : Object = getValue();
            if (value == null)
            {
                return null;
            }
            else if (_fieldType == null)
            {
                return value;
            }
           /* else if (_fieldType.isForeign() && _fieldType.getFieldType() == value.getClass())
            {
                var _idFieldType : FieldType = _fieldType.getForeignIdField();
                return idFieldType.extractJavaFieldValue(value);
            }
            else
            {
                return _fieldType.convertJavaFieldToSqlArgValue(value);
            }*/
			return null;
        }

        public function getFieldType() : FieldType
        {
            return _fieldType;
        }

        public function toString() : String
        {
            if (!isValueSet())
            {
                return "[unset]";
            }
            var val : Object;
            try
            {
                val = getSqlArgValue();
                if (val == null)
                {
                    return "[null]";
                }
                else
                {
                    return val.toString();
                }
            }
            catch ( e : Error )
            {
                return "[could not get value: " + e.message + "]";
            }
            return null;
        }
    }
}