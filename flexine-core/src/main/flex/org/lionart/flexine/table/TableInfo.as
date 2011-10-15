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
    import org.as3commons.lang.ClassUtils;
    import org.as3commons.reflect.Constructor;
    import org.lionart.flexine.dao.Dao;
    import org.lionart.flexine.field.FieldType;
    import org.lionart.flexine.misc.BaseDaoEnabled;
    import org.lionart.flexine.misc.SqlExceptionUtil;

    /**
     * Information about a database table including the associated tableName, class, constructor, and the included fields.
     *
     * @author Ghazi Triki
     */
    public class TableInfo
    {
        /**
         * The class that the code will be operating on.
         */
        private static var _dataClass : Class;

        private var _dao : Dao;

        private var _fieldTypes : Vector.<FieldType>;
        private var _tableName : String;
        private var _idField : FieldType;
        private var _constructor : Constructor;
        private var _fieldNameMap:Vector.<String, FieldType>;

        /**
         * Create and return an object of this type using our reflection constructor.
         */
        public function createObjectInstance() : *
        {
            return createObject(_constructor, _dao);
        }

        public static function createObject( constructor : Constructor, dao : Dao ) : *
        {
            try
            {
                // create our instance
                var instance : * = ClassUtils.newInstance(constructor.declaringType.clazz) as _dataClass;
                if (instance is BaseDaoEnabled)
                {
                    var daoEnabled : BaseDaoEnabled = BaseDaoEnabled(instance);
                    daoEnabled.setDao(dao);
                }
                return instance;
            }
            catch ( e : Error )
            {
                throw SqlExceptionUtil.create("Could not create object for " + constructor.declaringType.clazz, e.message);
            }
        }


        /**
         * Return true if we can update this object via its ID.
         */
        public function isUpdatable() : Boolean
        {
            // to update we must have an id field and there must be more than just the id field
            return (_idField != null && _fieldTypes.length > 1);
        }
    }
}
