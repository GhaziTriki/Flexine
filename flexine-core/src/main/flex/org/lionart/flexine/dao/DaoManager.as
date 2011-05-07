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
    }
}