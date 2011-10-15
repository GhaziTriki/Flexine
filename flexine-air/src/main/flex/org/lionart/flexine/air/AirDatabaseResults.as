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
    import org.lionart.flexine.support.DatabaseResults;

    public class AirDatabaseResults implements DatabaseResults
    {
        public function AirDatabaseResults()
        {
        }

        public function getColumnCount() : int
        {
            return 0;
        }

        public function next() : Boolean
        {
            return false;
        }

        public function findColumn( columnName : String ) : int
        {
            return 0;
        }

        public function getString( columnIndex : int ) : String
        {
            return null;
        }

        public function getInteger( columnIndex : int ) : int
        {
            return 0;
        }

        public function getNumber( columnIndex : int ) : Number
        {
            return 0;
        }

        public function getBoolean( columnIndex : int ) : Boolean
        {
            return false;
        }

        public function getDate( columnIndex : int ) : Date
        {
            return null;
        }

        public function getXML( columnIndex : int ) : XML
        {
            return null;
        }

        public function getXMLList( columnIndex : int ) : XMLList
        {
            return null;
        }

        public function getObject( columnIndex : int ) : Object
        {
            return null;
        }

        public function wasNull( columnIndex : int ) : Boolean
        {
            return false;
        }
    }
}
