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

    /**
     * Internal class handling the SQL 'ORDER BY' operation. Used by {@link StatementBuilder#orderBy}.
     *
     * @author Ghazi Triki
     */
    public class OrderBy
    {
        private var _columnName : String;
        private var _ascending : Boolean;

        public function OrderBy( columnName : String, ascending : Boolean )
        {
            this._columnName = columnName;
            this._ascending = ascending;
        }

        /**
         * Return the associated column-name.
         */
        public function getColumnName() : String
        {
            return _columnName;
        }

        /**
         * Are we ordering in ascending order. False is descending.
         */
        public function isAscending() : Boolean
        {
            return _ascending;
        }
    }
}

