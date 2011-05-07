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
package org.lionart.flexine.misc
{
    import org.lionart.flexine.dao.Dao;

    /**
     * Base class that your data elements can extend which allow them to refresh, update, etc. themselves. ORMLite will
     * automagically set the appropriate {Dao} on the class if it is received by a query but if you are trying to
     * create the class, you will need to either create it through the DAO or set the dao on it directly with
     * {#setDao(Dao)}.
     *
     * <p>
     * <b>NOTE:</b> The default pattern is to use the {Dao} classes to operate on your data classes. This will allow
     * your data classes to have their own hierarchy and isolates the database code in the Daos. However, you are free to
     * use this base class if you prefer this pattern.
     * </p>
     *
     * <p>
     * <b>NOTE:</b> The internal Dao field has been marked with transient so that it won't be serialized (thanks jc). If you
     * do de-serialize on these classes, you will need to refresh it with the Dao to get it to work again.
     * </p>
     *
     * @author Ghazi Triki
     */
    public class BaseDaoEnabled
    {

        protected var _dao : Dao;

        /**
         * Set the {Dao} on the object. For the {@link #create()} call to work, this must be done beforehand by the
         * caller. If the object has been received from a query call to the Dao then this should have been set
         * automagically.
         */
        public function setDao( dao : Dao ) : void
        {
            this._dao = dao;
        }
    }
}