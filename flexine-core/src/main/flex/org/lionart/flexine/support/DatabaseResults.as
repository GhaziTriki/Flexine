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
package org.lionart.flexine.support
{
    import flash.filesystem.FileStream;
    import flash.utils.ByteArray;

    public interface DatabaseResults
    {
        /**
         * Returns the number of columns in these results.
         */
        function getColumnCount() : int;

        /**
         * Moves to the next result.
         *
         * @return true if there are more results to be processed.
         */
        function next() : Boolean;

        /**
         * Return the column index associated with the column name.
         *
         * @throws SQLException
         *             if the column was not found in the results.
         */
        function findColumn( columnName : String ) : int;

        /**
         * Returns the string from the results at the column index.
         */
        function getString( columnIndex : int ) : String;

        /**
         * Returns the integer value from the results at the column index.
         */
        function getInteger( columnIndex : int ) : int;

        /**
         * Returns the number value from the results at the column index.
         */
        function getNumber( columnIndex : int ) : Number;

        /**
         * Returns the boolean value from the results at the column index.
         */
        function getBoolean( columnIndex : int ) : Boolean;

        /**
         * Returns the date from the results at the column index.
         */
        function getDate( columnIndex : int ) : Date;

        /**
         * Returns the xml from the results at the column index.
         */
        function getXML( columnIndex : int ) : XML;

        /**
         * Returns the xmllist from the results at the column index.
         */
        function getXMLList( columnIndex : int ) : XMLList;

        /**
         * Returns the byte array value from the results at the column index.
         */
        function getObject( columnIndex : int ) : Object;

        /**
         * Returns true if the last object returned with the column index is null.
         */
        function wasNull( columnIndex : int ) : Boolean;
    }
}

