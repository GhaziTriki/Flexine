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
package org.lionart.flexine.dao
{
    import flash.errors.IllegalOperationError;
    import flash.utils.Dictionary;
    
    import org.lionart.flexine.support.ConnectionSource;

    /**
     * Class which caches created DAOs. Sometimes internal DAOs are used to support such features as auto-refreshing of
     * foreign fields or collections of sub-objects. Since instantiation of the DAO is a bit expensive, this class is used
     * in an attempt to only create a DAO once for each class.
     *
     * <p>
     * <b>NOTE:</b> To use this cache, you should make sure you've added a {DatabaseTable#daoClass()} value to the
     * metadata to the top of your class.
     * </p>
     *
     * @author Ghazi Triki
     */
    public class DaoManager
    {
        private var classMap : Dictionary;
        private var tableMap : Dictionary;
        
        /**
         * Helper method to create a Dao object without having to define a class. This checks to see if the Dao has already
         * been created. If not then it is a call through to {@link BaseDaoImpl#createDao(ConnectionSource, Class)}.
         */
        public function createDao( connectionSource : ConnectionSource, clazz : Class) : Dao
        {
            /*if (connectionSource == null) {
                throw new IllegalOperationError("connectionSource argument cannot be null");
            }
            if (classMap == null) {
                classMap = new Dictionary(true);
            }
            ClazzConnectionSource key = new ClazzConnectionSource(connectionSource, clazz);
            var dao : Dao = classMap.get(key);
            if (dao != null)
            {
                return dao;
            }
            
            var databaseTable : DatabaseTable = clazz.getAnnotation(DatabaseTable.class);
                if (databaseTable == null || databaseTable.daoClass() == Void.class
                    || databaseTable.daoClass() == BaseDaoImpl.class) {
                        @SuppressWarnings("deprecation")
                        Dao<T, ?> daoTmp = BaseDaoImpl.createDao(connectionSource, clazz);
                        dao = daoTmp;
                    } else {
                        Class<?> daoClass = databaseTable.daoClass();
                        Constructor<?> daoConstructor = null;
                        Object[] arguments = null;
                        Constructor<?>[] constructors = daoClass.getConstructors();
                        // look first for the constructor with a class parameter in case it is a generic dao
                        for (Constructor<?> constructor : constructors) {
                            Class<?>[] params = constructor.getParameterTypes();
                            if (params.length == 2 && params[0] == ConnectionSource.class && params[1] == Class.class) {
                                daoConstructor = constructor;
                                arguments = new Object[] { connectionSource, clazz };
                                break;
                            }
                            }
                                // then look first for the constructor with just the ConnectionSource
                                if (daoConstructor == null) {
                                    for (Constructor<?> constructor : constructors) {
                                        Class<?>[] params = constructor.getParameterTypes();
                                        if (params.length == 1 && params[0] == ConnectionSource.class) {
                                            daoConstructor = constructor;
                                            arguments = new Object[] { connectionSource };
                                            break;
                                        }
                                        }
                                        }
                                            if (daoConstructor == null) {
                                                throw new SQLException("Could not find public constructor with ConnectionSource parameter in class "
                                                    + daoClass);
                                            }
                                            try {
                                                dao = (Dao<?, ?>) daoConstructor.newInstance(arguments);
                                            } catch (Exception e) {
                                                throw SqlExceptionUtil.create("Could not call the constructor in class " + daoClass, e);
                                            }
                                            }
                                            
                                            classMap.put(key, dao);
                                            @SuppressWarnings("unchecked")
                                            D castDao = (D) dao;
                                            return castDao;*/
			return null;
        }
    }
}