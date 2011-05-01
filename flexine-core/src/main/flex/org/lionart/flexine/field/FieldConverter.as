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
    import org.lionart.flexine.support.DatabaseResults;

    /**
     * Convert an ActionScript object into the appropriate argument to a SQL statement and then back from the result set to the ActionScript
     * object. This allows databases to configure per-type conversion. This is used by the
     * {BaseDatabaseType#getFieldConverter(DataType)} method to find the converter for a particular database type.
     * Databases can then override the default data conversion mechanisms as necessary.
     *
     * @author Ghazi Triki
     */
    public interface FieldConverter
    {
        /**
         * Convert a default string object and return the appropriate argument to a SQL insert or update statement.
         */
        function parseDefaultString( fieldType : FieldType, defaultStr : String ) : Object; //throws SQLException;

        /**
         * Convert an ActionScript object and return the appropriate argument to a SQL insert or update statement.
         */
        function asToSqlArg( fieldType : FieldType, obj : Object ) : Object; //throws SQLException;

        /**
         * Return the object extracted from the results associated with column in position columnPos.
         *
         * @throws SQLException
         *             If there is a problem accessing the results data.
         * @param fieldType
         *            Associated FieldType which may be null.
         */
        function resultToAs( fieldType : FieldType, results : DatabaseResults, columnPos : int ) : Object; //throws SQLException;

        /**
         * Return the SQL type that is stored in the database for this argument.
         */
        function getSqlType() : SqlType;

        /**
         * Return whether or not this is a SQL "stream" object. Cannot get certain stream objects from the SQL results more
         * than once. If true, the converter has to protect itself against null values.
         */
        function isStreamType() : Boolean;
    }
}

