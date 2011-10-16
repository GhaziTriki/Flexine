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
    import org.lionart.flexine.dao.ObjectCache;
    import org.lionart.flexine.field.FieldType;
    import org.lionart.flexine.statement.GenericRowMapper;
    import org.lionart.flexine.statement.StatementType;

    /**
     * A reduction of the SQL Connection so we can implement its functionality outside of JDBC.
     *
     * @author Ghazi Triki
     */
    public interface DatabaseConnection
    {
        /**
         * Start a save point with a certain name. It can be a noop if savepoints are not supported.
         *
         * @param name
         *            to use for the Savepoint although it can be ignored.
         */
        function setSavepoint( name : String = null ) : void;

        /**
         * Commit all changes since the savepoint was created. If savePoint is null then commit all outstanding changes.
         */
        function commit() : void

        /**
         *  Roll back all outstanding changes.
         */
        function rollback() : void;

        /**
         * Roll back all changes since the savepoint was created.
         */
        function rollbackToSavepoint( savePoint : String = null ) : void;

        /**
         * Compile and prepare the SQL statement for execution.
         */
        function compileStatement( statement : String, type : StatementType, argfieldTypes : Vector.<FieldType> ) : CompiledStatement;

        /**
         * Perform a SQL update while with the associated SQL statement, arguments, and types. This will possibly return
         * generated keys if kyeHolder is not null.
         *
         * @param statement
         *            SQL statement to use for inserting.
         * @param args
         *            Object arguments for the SQL '?'s.
         * @param argfieldTypes
         *            Field types of the arguments.
         * @param keyHolder
         *            The holder that gets set with the generated key value which may be null.
         * @return The number of rows affected by the update. With some database types, this value may be invalid.
         */
        function insert( statement : String, args : Array, argfieldTypes : Vector.<FieldType>, keyHolder : GeneratedKeyHolder ) : int;

        /**
         * Perform a SQL update with the associated SQL statement, arguments, and types.
         *
         * @param statement
         *            SQL statement to use for updating.
         * @param args
         *            Object arguments for the SQL '?'s.
         * @param argfieldTypes
         *            Field types of the arguments.
         * @return The number of rows affected by the update. With some database types, this value may be invalid.
         */
        function update( statement : String, args : Array, argfieldTypes : Vector.<FieldType> ) : int;

        /**
         * Perform a SQL delete with the associated SQL statement, arguments, and types.
         *
         * @param statement
         *            SQL statement to use for deleting.
         * @param args
         *            Object arguments for the SQL '?'s.
         * @param argfieldTypes
         *            Field types of the arguments.
         * @return The number of rows affected by the update. With some database types, this value may be invalid.
         */
        function remove( statement : String, args : Array, argfieldTypes : Vector.<FieldType> ) : int;

        /**
         * Perform a SQL query with the associated SQL statement, arguments, and types and returns a single result.
         *
         * @param statement
         *            SQL statement to use for deleting.
         * @param args
         *            Object arguments for the SQL '?'s.
         * @param argfieldTypes
         *            Field types of the arguments.
         * @param rowMapper
         *            The mapper to use to convert the row into the returned object.
         * @param objectCache
         *            Any object cache associated with the query or null if none.
         * @return The first data item returned by the query which can be cast to <T>, null if none, the object
         *         {@link #MORE_THAN_ONE} if more than one result was found.
         */
        // function queryForOne( statement : String, args : Array, argfieldTypes : Vector.<FieldType>, rowMapper : GenericRowMapper, objectCache : ObjectCache ) : Object;

        /**
         * Perform a query whose result should be a single long-integer value.
         *
         * @param statement
         *            SQL statement to use for the query.
         */
        // function queryForLong( statement : String ) : int;

        /**
         * Close the connection to the database.
         */
        function close() : void;

        /**
         * Return if the connection has been closed either through a call to {@link #close()} or because of a fatal error.
         */
        function isClosed() : Boolean;

        /**
         * Return true if the table exists in the database.
         */
        function isTableExists( tableName : String ) : Boolean;
    }
}
