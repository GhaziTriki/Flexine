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

    import org.lionart.flexine.support.DatabaseConnection;

    public class AirSQLConnection implements DatabaseConnection
    {
        private var _decoratedConnection : SQLConnection;

        public function AirSQLConnection( reference : Object, openMode : String )
        {
            _decoratedConnection = new SQLConnection();
            _decoratedConnection.open(reference, openMode);
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

        public function rollbackToSavepoint( savePoint : String ) : void
        {
            _decoratedConnection.rollbackToSavepoint(savePoint);
        }

        public function get connection() : SQLConnection
        {
            return _decoratedConnection;
        }


    }
}
