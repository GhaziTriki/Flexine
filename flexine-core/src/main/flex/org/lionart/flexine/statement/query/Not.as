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
    import flash.errors.IllegalOperationError;

    import org.as3commons.lang.StringBuffer;
    import org.lionart.flexine.db.DatabaseType;
    import org.lionart.flexine.statement.ArgumentHolder;

    /**
     * Internal class handling the SQL 'NOT' boolean comparison operation. Used by {@link Where#not}.
     *
     * @author Ghazi Triki
     */
    public class Not implements NeedsFutureClause
    {
        private var _comparison : Comparison = null;
        private var _exists : Exists = null;

        /**
         * In this case we will consume a future clause.
         */
        public function Not( clause : Clause = null )
        {
            if (clause)
            {
                setMissingClause(clause);
            }
        }

        public function setMissingClause( clause : Clause ) : void
        {
            if (this._comparison != null)
            {
                throw new IllegalOperationError("NOT operation already has a comparison set");
            }
            if (clause is Comparison)
            {
                this._comparison = Comparison(clause);
            }
            else
            {
                throw new IllegalOperationError("NOT operation can only work with comparison SQL clauses, not " + clause);
            }
        }

        public function appendSql( databaseType : DatabaseType, sb : StringBuffer, selectArgList : Vector.<ArgumentHolder> ) : void
        {
            if (_comparison == null && _exists == null)
            {
                throw new IllegalOperationError("Clause has not been set in NOT operation");
            }
            // this generates: (NOT 'x' = 123 )
            if (_comparison == null)
            {
                sb.append("(NOT ");
                _exists.appendSql(databaseType, sb, selectArgList);
            }
            else
            {
                sb.append("(NOT ");
                databaseType.appendEscapedEntityName(sb, _comparison.getColumnName());
                sb.append(' ');
                _comparison.appendOperation(sb);
                _comparison.appendValue(databaseType, sb, selectArgList);
            }
            sb.append(") ");
        }

        public function toString() : String
        {
            if (_comparison == null)
            {
                return "NOT without comparison";
            }
            else
            {
                return "NOT comparison " + _comparison;
            }
        }
    }
}
