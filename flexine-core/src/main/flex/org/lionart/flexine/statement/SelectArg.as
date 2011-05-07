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
    /**
     * An argument to a select SQL statement. After the query is constructed, the caller can set the value on this argument
     * and run the query. Then the argument can be set again and the query re-executed. This is equivalent in JDBC to a ?
     * type argument.
     * 
     * <p>
     * NOTE: If the argument has not been set by the time the query is executed, an exception will be thrown.
     * </p>
     * 
     * <p>
     * NOTE: For protections sake, the object cannot be reused with different column names.
     * </p>
     * 
     * <blockquote>
     * 
     * <pre>
     * // build a query using the Account DAO
     * QueryBuilder&lt;Account, String&gt; qb = accountDao.queryBuilder();
     * 
     * // create an argument which will be set later
     * SelectArg passwordSelectArg = new SelectArg();
     * qb.where().eq(Account.PASSWORD_FIELD_NAME, passwordSelectArg);
     * // prepare the query
     * PreparedQuery&lt;Account&gt; preparedQuery = qb.prepareQuery();
     * // ...
     * 
     * // some time later we set the value and run the query 
     * passwordSelectArg.setValue(&quot;_secret&quot;);
     * List&lt;Account&gt; results = accountDao.query(preparedQuery);
     * // we can then re-set the value and re-run the query 
     * passwordSelectArg.setValue(&quot;qwerty&quot;);
     * List&lt;Account&gt; results = accountDao.query(preparedQuery);
     * </pre>
     * 
     * </blockquote>
     * 
     * @author Ghazi Triki
     */
    public class SelectArg
    {
        public function SelectArg()
        {
        }
    }
}