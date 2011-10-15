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

    /**
     * Metadata that identifies a {ForeignCollection} field in a class that corresponds to objects in a foreign
     * table that match the foreign-id of the current class.
     *
     * <p>
     * <blockquote>
     *
     * <pre>
     * [ForeignCollection(id = true)]
     * private ForeignCollection&lt;Order&gt; orders;
     * </pre>
     *
     * </blockquote>
     * </p>
     *
     * @author Ghazi Triki
     */
    public final class ForeignCollectionField
    {
        public static const NAME : String = "ForeignCollectionField";

        // FIXME : add type
        private var _eager : Boolean = false;

        /**
         * Set to true if the collection is a an eager collection where all of the results should be retrieved when the
         * parent object is retrieved. Default is false (lazy) when the results will not be retrieved until you ask for the
         * iterator from the collection.
         *
         * <p>
         * <b>NOTE:</b> If this is false (i.e. we have a lazy collection) then a connection is held open to the database as
         * you iterate through the collection. This means that you need to make sure it is closed when you finish. See
         * {@link LazyForeignCollection#iterator()} for more information.
         * </p>
         */
        public function get eager() : Boolean
        {
            return _eager;
        }

        public function set eager( value : Boolean ) : void
        {
            _eager = value;
        }


    }
}
