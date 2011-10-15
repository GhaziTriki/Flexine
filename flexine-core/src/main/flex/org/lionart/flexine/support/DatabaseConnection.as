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
    import flash.net.Responder;

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
        function rollbackToSavepoint( savePoint : String ) : void;
    }
}
