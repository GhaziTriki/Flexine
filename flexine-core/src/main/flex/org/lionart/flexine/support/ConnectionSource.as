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
    import org.lionart.flexine.db.DatabaseType;

    /**
     * A reduction of the SQL DataSource so we can implement its functionality outside of JDBC.
     *
     * @author Ghazi Triki
     */
    public interface ConnectionSource
    {
        /**
         * Return a database connection suitable for read-only operations. After you are done, you should call
         * {@link #releaseConnection(DatabaseConnection)}.
         */
        function getReadOnlyConnection() : DatabaseConnection;

        /**
         * Return a database connection suitable for read or write operations. After you are done, you should call
         * {@link #releaseConnection(DatabaseConnection)}.
         */
        function getReadWriteConnection() : DatabaseConnection;

        /**
         * Release a database connection previously returned by {@link #getReadOnlyConnection()} or
         * {@link #getReadWriteConnection()}.
         */
        function releaseConnection( connection : DatabaseConnection ) : void;

        /**
         * Save this connection and return it for all calls to {@link #getReadOnlyConnection()} and
         * {@link #getReadWriteConnection()} unless the {@link #clearSpecialConnection(DatabaseConnection)} method is
         * called, all This is used by the transaction mechanism since since all operations within a transaction must
         * operate on the same connection. It is also used by the Android code during initialization.
         *
         * <p>
         * <b> NOTE: </b> This should be a read-write connection since transactions and Android need it to be so.
         * </p>
         *
         * <p>
         * <b> NOTE: </b> Saving a connection is usually accomplished using ThreadLocals so multiple threads should not be
         * using connections in this scenario.
         * </p>
         *
         * @return True if the connection was saved or false if we were already inside of a saved connection.
         */
        function saveSpecialConnection( connection : DatabaseConnection ) : Boolean;

        /**
         * Clear the saved connection.
         */
        function clearSpecialConnection( connection : DatabaseConnection ) : void;

        /**
         * Return the currently saved connection or null if none.
         */
        function getSpecialConnection() : DatabaseConnection;

        /**
         * Close any outstanding database connections.
         */
        function close() : void;

        /**
         * Return the DatabaseTypre associated with this connection.
         */
        function getDatabaseType() : DatabaseType;

        /**
         * Return true if the connection source is open. Once {@link #close()} has been called, this should return false.
         */
        function isOpen() : Boolean;
    }
}