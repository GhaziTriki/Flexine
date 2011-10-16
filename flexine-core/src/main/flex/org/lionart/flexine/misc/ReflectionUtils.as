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
    import flash.utils.Dictionary;

    import org.as3commons.reflect.Metadata;
    import org.as3commons.reflect.MetadataArgument;

    /**
     *
     * @author Ghazi Triki
     *
     */
    public class ReflectionUtils extends Object
    {
        private static var _cache : Dictionary = new Dictionary(false);

        /**
         * Creates an instance of a given class from metadataAnnotation. The values of keys
         * in metadataAnnotation are copied to clazz instance properties.
         *
         * @param metadataAnnotation MetaDataAnnotation description to parse.
         * @param clazz the class to instanciate.
         * @return instance on clazz filled with metadata properties.
         *
         */
        public static function fillFromMetada( metadataAnnotation : Metadata, clazz : Class ) : Object
        {
            if (metadataAnnotation.arguments && metadataAnnotation.arguments.length > 0)
            {
                var instance : * = new clazz();
                for each (var arg : MetadataArgument in metadataAnnotation.arguments)
                {
                    instance[arg.key] = arg.value;
                }
                return instance;
            }
            return null;
        }

    }
}


