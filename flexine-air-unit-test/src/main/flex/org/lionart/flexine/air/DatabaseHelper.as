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
    import flash.filesystem.File;

    public class DatabaseHelper
    {
        /**
         * The name of the database for our application.
         */
        private static const DATABASE_NAME : String = "test.db";

        /**
         * The version number of the database. This allows us to do conversions from various older versions to newer.
         */
        private static const DATABASE_VERSION : int = 1;

        public static function getDatabaseFile() : Object
        {
            var appDirPath : String = File.applicationDirectory.nativePath;
            var dbFile : File = new File(appDirPath + File.separator + DATABASE_NAME);
            return dbFile;
        }
    }
}
