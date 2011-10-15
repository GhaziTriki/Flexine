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
package org.lionart.flexine.statement
{
    import org.lionart.flexine.dao.CloseableIterator;

    public class SelectIterator implements CloseableIterator
    {
        public function SelectIterator()
        {
        }

        public function close() : void
        {
        }

        public function hasNext() : Boolean
        {
            return false;
        }

        public function next() : Object
        {
            return null;
        }

        public function remove() : void
        {
        }

        public function first() : void
        {
            // TODO Auto-generated method stub
        }

        public function last() : void
        {
            // TODO Auto-generated method stub
        }
    }
}
