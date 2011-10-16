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
    import flash.data.SQLConnection;
    import flash.data.SQLStatement;
    import flash.errors.SQLError;

    import org.lionart.flexine.field.FieldType;
    import org.lionart.flexine.flexine_internal;
    import org.lionart.flexine.misc.SqlExceptionUtil;
    import org.lionart.flexine.statement.StatementType;
    import org.lionart.flexine.support.CompiledStatement;
    import org.lionart.flexine.support.DatabaseConnection;
    import org.lionart.flexine.support.GeneratedKeyHolder;

    use namespace flexine_internal;

    public class AirSQLConnection implements DatabaseConnection
    {
        private var _decoratedConnection : SQLConnection;

        public function AirSQLConnection( reference : Object, openMode : String )
        {
            _decoratedConnection = new SQLConnection();
            super.open(reference, openMode);
        }

        public function setSavepoint( name : String = null ) : void
        {
            _decoratedConnection.setSavepoint(name);
        }

        public function commit() : void
        {
            _decoratedConnection.commit();
        }

        public function rollback() : void
        {
            _decoratedConnection.rollback();
        }

        public function rollbackToSavepoint( savePoint : String = null ) : void
        {
            _decoratedConnection.rollbackToSavepoint(savePoint);
        }

        public function compileStatement( statement : String, type : StatementType, argfieldTypes : Vector.<FieldType> ) : CompiledStatement
        {
            var stmt : CompiledStatement = new AirCompiledStatement(statement, this, type);
            return stmt;
        }

        public function insert( statement : String, args : Array, argfieldTypes : Vector.<FieldType>, keyHolder : GeneratedKeyHolder ) : int
        {
            var stmt : SQLStatement = null;
            try
            {
                stmt.sqlConnection = _decoratedConnection;
                stmt.execute();
                bindArgs(stmt, args, argfieldTypes);
                stmt.execute();
                var rowId : int = parseInt(stmt.getResult()[0]);
                if (keyHolder != null)
                {
                    keyHolder.addKey(rowId);
                }
                return 1;
            }
            catch ( e : SQLError )
            {
                throw SqlExceptionUtil.create("inserting to database failed: " + statement, e.message);
            }
            finally
            {
                if (stmt != null)
                {
                    stmt.clearParameters();
                    stmt = null;
                }
            }
            // FIXME : return finally the correct value
            return 1;
        }

        public function update( statement : String, args : Array, argfieldTypes : Vector.<FieldType> ) : int
        {
            var stmt : SQLStatement = null;
            try
            {
                stmt.sqlConnection = _decoratedConnection;
                bindArgs(stmt, args, argfieldTypes);
                stmt.execute();
                return 1;
            }
            catch ( e : SQLError )
            {
                throw SqlExceptionUtil.create("updating database failed: " + statement, e.message);
            }
            finally
            {
                if (stmt != null)
                {
                    stmt.clearParameters();
                    stmt = null;
                }
            }
            // FIXME : return finally the correct value
            return 1;
        }

        public function remove( statement : String, args : Array, argfieldTypes : Vector.<FieldType> ) : int
        {
            return update(statement, args, argfieldTypes);
        }

        public function close() : void
        {
            try
            {
                _decoratedConnection.close();
            }
            catch ( e : SQLError )
            {
                throw SqlExceptionUtil.create("problems closing the database connection", e.message);
            }
        }

        public function isClosed() : Boolean
        {
            try
            {
                return !_decoratedConnection.connected;
            }
            catch ( e : SQLError )
            {
                throw SqlExceptionUtil.create("problems detecting if the database is closed", e.message);
            }
            return null;
        }

        public function isTableExists( tableName : String ) : Boolean
        {
            // NOTE: it is non trivial to do this check since the helper will auto-create if it doesn't exist
            return true;
        }

        // Internal
        flexine_internal function getSQLConnection() : SQLConnection
        {
            return _decoratedConnection;
        }


        // Private
        private function bindArgs( stmt : SQLStatement, args : Array, argFieldTypes : Vector.<FieldType> ) : void
        {
            if (args == null)
            {
                return;
            }
            for (var i : int = 0; i < args.length; i++)
            {
                var arg : Object = args[i];
                stmt.parameters[i + 1] = arg;
                    // throw new SQLException("Unknown sql argument type " + argFieldTypes[i].getSqlType());
            }
        }


    }
}
