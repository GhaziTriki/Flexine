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

    public class BaseConnectionSource implements ConnectionSource
    {
        protected var usedSpecialConnection : Boolean = false;
        private var specialConnection : NestedConnection = new NestedConnection(null);

        /**
         * Returns the connection that has been saved or null if none.
         */
        protected function getSavedConnection() : DatabaseConnection
        {
            if (!usedSpecialConnection)
            {
                return null;
            }
            var nested : NestedConnection = specialConnection;
            if (nested == null)
            {
                return null;
            }
            else
            {
                return nested.connection;
            }
        }

        public function getReadOnlyConnection() : DatabaseConnection
        {
            return null;
        }

        public function getReadWriteConnection() : DatabaseConnection
        {
            return null;
        }

        public function releaseConnection( connection : DatabaseConnection ) : void
        {
        }

        public function saveSpecialConnection( connection : DatabaseConnection ) : Boolean
        {
            return false;
        }

        public function clearSpecialConnection( connection : DatabaseConnection ) : void
        {
        }

        public function getSpecialConnection() : DatabaseConnection
        {
            return null;
        }

        public function close() : void
        {
        }

        public function getDatabaseType() : DatabaseType
        {
            return null;
        }

        public function isOpen() : Boolean
        {
            return false;
        }
    }
}
import org.lionart.flexine.support.DatabaseConnection;

internal class NestedConnection
{
    public var connection : DatabaseConnection;
    private var nestedC : int;

    public function NestedConnection( connection : DatabaseConnection )
    {
        this.connection = connection;
        this.nestedC = 1;
    }

    public function increment() : void
    {
        this.nestedC++;
    }

    public function decrementAndGet() : int
    {
        this.nestedC--;
        return this.nestedC;
    }
}
