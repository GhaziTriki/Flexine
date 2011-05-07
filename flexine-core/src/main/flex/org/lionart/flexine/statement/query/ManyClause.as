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
    import org.lionart.commons.lang.StringBuilder;
    import org.lionart.flexine.db.DatabaseType;
    import org.lionart.flexine.statement.ArgumentHolder;

    /**
     * For operations with a number of them in a row.
     *
     * @author Ghazi Triki
     */
    public class ManyClause implements NeedsFutureClause
    {
        public static const AND_OPERATION : String = "AND";
        public static const OR_OPERATION : String = "OR";

        private var _first : Clause;
        private var _second : Clause;
        private var _others : Vector.<Clause>;
        private var _startOthersAt : int;
        private var _operation : String;

        public function ManyClause( first : Clause = null, second : Clause = null, others : Vector.<Clause> = null, operation : String = null )
        {
            if (first != null || second != null)
            {
                this._first = first;
                this._second = second;
                this._others = others;
                this._startOthersAt = 0;
                this._operation = operation;
            }
            else
            {
                this._first = others[0];
                if (others.length < 2)
                {
                    this._second = null;
                    this._startOthersAt = others.length;
                }
                else
                {
                    this._second = others[1];
                    this._startOthersAt = 2;
                }
                this._others = others;
                this._operation = operation;
            }
        }

        public function appendSql( databaseType : DatabaseType, sb : StringBuilder, selectArgList : Vector.<ArgumentHolder> ) : void
        {
            sb.append("(");
            _first.appendSql(databaseType, sb, selectArgList);
            if (_second != null)
            {
                sb.append(_operation);
                sb.append(' ');
                _second.appendSql(databaseType, sb, selectArgList);
            }
            if (_others != null)
            {
                for (var i : int = _startOthersAt; i < _others.length; i++)
                {
                    sb.append(_operation);
                    sb.append(' ');
                    _others[i].appendSql(databaseType, sb, selectArgList);
                }
            }
            sb.append(") ");
        }

        public function setMissingClause( right : Clause ) : void
        {
            _second = right;
        }
    }
}