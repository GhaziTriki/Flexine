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
     * The definition of the Database Access Objects that handle the reading and writing a class from the database. Kudos to
     * Robert A. for the general concept of this hierarchy.
     * 
     * @param T
     *            The class that the code will be operating on.
     * @param ID
     *            The class of the ID column associated with the class. The T class does not require an ID field. The class
     *            needs an ID parameter however so you can use Void or Object to satisfy the compiler.
     * @author Ghazi Triki
     */
    public interface Dao
    {

    }
}