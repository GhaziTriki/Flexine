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
package org.lionart.flexine.field.types
{
    import org.lionart.flexine.field.DataPersister;
    import org.lionart.flexine.field.FieldType;
    import org.lionart.flexine.field.SqlType;
    import org.lionart.flexine.support.DatabaseResults;

    public class BaseDataType implements DataPersister
    {
        public function BaseDataType()
        {
        }

        public function parseDefaultString( fieldType : FieldType, defaultStr : String ) : Object
        {
            return null;
        }

        public function asToSqlArg( fieldType : FieldType, obj : Object ) : Object
        {
            return null;
        }

        public function resultToAs( fieldType : FieldType, results : DatabaseResults, columnPos : int ) : Object
        {
            return null;
        }

        public function getSqlType() : SqlType
        {
            return null;
        }

        public function isStreamType() : Boolean
        {
            return false;
        }
    }
}
