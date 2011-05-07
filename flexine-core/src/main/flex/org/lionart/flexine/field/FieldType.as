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
package org.lionart.flexine.field
{

    public class FieldType
    {
        
       // private static const AtomicInteger recursionProtection = new AtomicInteger();
        
        /** default suffix added to fields that are id fields of foreign objects */
        public static const FOREIGN_ID_FIELD_SUFFIX :String = "_id";
        public static const MAX_FOREIGN_RECURSE_LEVEL : int = 10;        

        private var _dataTypeConfigObj : Object;
        
        

        private var _fieldConfig : DatabaseFieldConfig;
        /**
         * Return the format of the field.
         */
        public function getFormat() : String
        {
            return _fieldConfig.format;
        }


        public function getDataTypeConfigObj() : Object
        {
            return _dataTypeConfigObj;
        }

    }
}

