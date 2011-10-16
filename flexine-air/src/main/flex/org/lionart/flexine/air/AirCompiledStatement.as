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
package org.lionart.flexine.air
{
    import flash.data.SQLStatement;

    import org.lionart.flexine.flexine_internal;
    import org.lionart.flexine.statement.StatementType;
    import org.lionart.flexine.support.CompiledStatement;

    use namespace flexine_internal;

    public class AirCompiledStatement extends SQLStatement implements CompiledStatement
    {

        private var _decoratedStatement : SQLStatement;

        private var _type : StatementType;

        public function AirCompiledStatement( sql : String, connection : AirSQLConnection, type : StatementType )
        {
            _decoratedStatement = new SQLStatement();
            _decoratedStatement.sqlConnection = connection.getSQLConnection();
            _decoratedStatement.text = sql;
            _type = type;
        }

    }
}
