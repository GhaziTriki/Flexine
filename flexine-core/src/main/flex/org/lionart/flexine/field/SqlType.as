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
    import org.as3commons.lang.Enum;

    /**
     * The SQL data types that are supported. These are basically an enumeration of the column affinities.
     * Look at <a href="http://help.adobe.com/en_US/as3/dev/WSd47bd22bdd97276f2aceae3b1262b7f2d43-8000.html">Data type support</a>
     *
     * @author Ghazi Triki
     */
    public final class SqlType extends Enum
    {
        public static const STRING : SqlType = new SqlType("string");
        public static const TEXT : SqlType = new SqlType("text"); // Same as String
        public static const NUMERIC : SqlType = new SqlType("numeric");
        public static const INTEGER : SqlType = new SqlType("integer");
        public static const INT : SqlType = new SqlType("int"); // Same as Integer
        public static const NUMBER : SqlType = new SqlType("number");
        public static const REAL : SqlType = new SqlType("real"); // Same as Number
        public static const BOOLEAN : SqlType = new SqlType("boolean");
        public static const DATE : SqlType = new SqlType("date");
        public static const XML : SqlType = new SqlType("xml");
        public static const XML_LIST : SqlType = new SqlType("xmllist");
        public static const OBJECT : SqlType = new SqlType("object");
        public static const NONE : SqlType = new SqlType("none");

        public function SqlType( value : String )
        {
            super(value);
        }

    }
}

