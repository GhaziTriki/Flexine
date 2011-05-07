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
    import org.lionart.flexine.field.FieldType;

    /**
     * An argument to a select SQL statement. After the query is constructed, the caller can set the value on this argument
     * and run the query. Then the argument can be set again and the query re-executed. This is equivalent in SQL to a ?
     * argument.
     *
     * @author Ghazi Triki
     */
    public interface ArgumentHolder
    {
        /**
         * Return the column-name associated with this argument. The name is set by the package internally.
         */
        function getColumnName() : String;

        /**
         * Used internally by the package to set the column-name associated with this argument.
         */
        function setMetaInfo( columnName : String, fieldType : FieldType ) : void;

        /**
         * Set the value associated with this argument. The value should be set by the user after the query has been built
         * but before it has been executed.
         */
        function setValue( value : Object ) : void;

        /**
         * Return the value associated with this argument suitable for passing to SQL. The value should be set by the user
         * before it is consumed.
         */
        function getSqlArgValue() : Object;

        /**
         * Return the field type associated with this class.
         */
        function getFieldType() : FieldType;
    }
}

