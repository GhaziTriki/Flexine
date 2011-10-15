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
package org.lionart.flexine.statement.query
{
    import org.as3commons.lang.StringBuffer;
    import org.lionart.flexine.db.DatabaseType;
    import org.lionart.flexine.statement.ArgumentHolder;

    /**
     * Internal interfaces which define a comparison operation.
     *
     * @author Ghazi Triki
     */
    public interface Comparison extends Clause
    {
        /**
         * Return the column-name associated with the comparison.
         */
        function getColumnName() : String;

        /**
         * Add the operation used in this comparison to the string builder.
         */
        function appendOperation( sb : StringBuffer ) : StringBuffer;

        /**
         * Add the value of the comparison to the string builder.
         */
        function appendValue( databaseType : DatabaseType, sb : StringBuffer, selectArgList : Vector.<ArgumentHolder> ) : StringBuffer;
    }
}
