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
    import org.lionart.flexine.field.SqlType;

    /**
     * An internal reduction of the SQL PreparedStatment so we can implement its functionality outside of JDBC.
     *
     * @author Ghazi Triki
     */
    public interface CompiledStatement
    {
    /**
     * Returns the number of columns in this statement.
     */
         // function getColumnCount() : int;

    /**
     * Get the designated column's name.
     */
         // function getColumnName( columnIndex : int ) : String;

    /**
     * Run the prepared update statement returning the number of rows affected.
     */
         // function runUpdate() : int;

    /**
     * Run the prepared query statement returning the results.
     */
         // function runQuery() : DatabaseResults;

    /**
     * Run the prepared execute statement returning the number of rows affected.
     */
         // function runExecute() : int;

    /**
     * Get the generated key results.
     */
         // function getGeneratedKeys() : DatabaseResults;

    /**
     * Close the statement.
     */
         // function close() : void;

    /**
     * Set the parameter specified by the index and type to be null.
     *
     * @param parameterIndex
     *            Index of the parameter with 0 being the first parameter, etc..
     * @param sqlType
     *            SQL type of the parameter.
     */
         // function setNull( parameterIndex : int, sqlType : SqlType ) : void;

    /**
     * Set the parameter specified by the index and type to be an object.
     *
     * @param parameterIndex
     *            Index of the parameter with 0 being the first parameter, etc..
     * @param obj
     *            Object that we are setting.
     * @param sqlType
     *            SQL type of the parameter.
     */
         // function setObject( parameterIndex : int, obj : Object, sqlType : SqlType ) : void;

    /**
     * Set the number of rows to return in the results.
     */
         // function setMaxRows( max : int ) : void;
    }
}
