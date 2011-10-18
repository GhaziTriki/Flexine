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
    import flash.data.SQLMode;

    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import org.lionart.flexine.db.DatabaseType;
    import org.lionart.flexine.db.SqliteAirDatabaseType;
    import org.lionart.flexine.support.BaseConnectionSource;
    import org.lionart.flexine.support.ConnectionSource;
    import org.lionart.flexine.support.DatabaseConnection;

    public class AirConnectionSource extends BaseConnectionSource implements ConnectionSource
    {
        private static const logger : ILogger = getLogger(AirConnectionSource);
        private var sqliteDatabase : Object;
        private var connection : DatabaseConnection = null;
        private var databaseType : DatabaseType = new SqliteAirDatabaseType();
        private var _isOpen : Boolean = true;

        public function AirConnectionSource( database : Object = null )
        {
            sqliteDatabase = database;
        }

        override public function getReadWriteConnection() : DatabaseConnection
        {
            var conn : DatabaseConnection = getSavedConnection();
            if (conn != null)
            {
                return conn;
            }
            if (connection == null)
            {
                if (sqliteDatabase == null)
                {
                    connection = new AirSQLConnection(sqliteDatabase, SQLMode.CREATE);
                }
                else
                {
                    connection = new AirSQLConnection(sqliteDatabase, SQLMode.UPDATE);
                }
            }
            return connection;
        }

        override public function close() : void
        {
            connection.close();
            _isOpen = false;
        }

        override public function isOpen() : Boolean
        {
            return _isOpen;
        }
    }
}
