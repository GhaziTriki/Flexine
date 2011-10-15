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
    import org.as3commons.lang.IIterator;


    /**
     * Extension to Iterator to provide a close() method. This should be in the JDK.
     *
     * <p>
     * <b>NOTE:</b> You must call {CloseableIterator#close()} method when you are done otherwise the underlying SQL
     * statement and connection may be kept open.
     * </p>
     *
     * @author Ghazi Triki
     */
    public interface CloseableIterator extends IIterator
    {
        /**
         * Close any underlying SQL statements.
         */
        function close() : void;
    }
}
