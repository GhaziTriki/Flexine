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
package org.lionart.flexine.table
{

    [ExcludeClass]
    /**
     * Metadata that marks a class to be stored in the database. It is only required if you want to mark the class or
     * change its default tableName. You specify this metadata above the classes that you want to persist to the database.
     * For example:
     *
     * <p>
     * <blockquote>
     *
     * <pre>
     * [DatabaseTable(tableName = "accounts")]
     * public class Account {
     *   ...
     * </pre>
     *
     * </blockquote>
     * </p>
     *
     * <p>
     * <b>NOTE:</b> Classes that are persisted using this package <i>must</i> have a no-argument constructor with at least
     * package visibility so objects can be created when you do a query, etc..
     * </p>
     *
     * @author Ghazi Triki
     */
    public class DatabaseTable
    {
        private var _tableName : String;

        /**
         * The name of the column in the database. If not set then the name is taken from the class name lowercased.
         */
        public function get tableName() : String
        {
            return _tableName;
        }

        public function set tableName( value : String ) : void
        {
            _tableName = value;
        }


        private var _daoClass : Class;

        /**
         * The DAO class that corresponds to this class. This is used by the {DaoManager} when it constructs a DAO
         * internally. It is important to use this on devices with minimal memory such as mobile devices.
         */
        public function get daoClass() : Class
        {
            return _daoClass;
        }

        public function set daoClass( value : Class ) : void
        {
            _daoClass = value;
        }

    }
}

