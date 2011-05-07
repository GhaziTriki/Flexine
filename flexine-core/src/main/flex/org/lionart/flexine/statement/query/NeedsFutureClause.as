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
package org.lionart.flexine.statement.query
{

    /**
     * Internal interface which defines a clause that consumes a future clause. This allows us to do:
     *
     * <p>
     *
     * <pre>
     * where.not();
     * where.eq(&quot;id&quot;, 1234);
     * </pre>
     *
     * and
     *
     * <pre>
     * where.eq(&quot;id&quot;, 1234);
     * where.and();
     * where.gt(&quot;age&quot;, 44);
     * </pre>
     *
     * </p>
     *
     * @author Ghazi Triki
     */
    public interface NeedsFutureClause extends Clause
    {
        /**
         * Set the right side of the binary operation.
         */
        function setMissingClause( right : Clause ) : void;
    }
}

