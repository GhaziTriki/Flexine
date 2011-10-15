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
    import org.lionart.flexine.support.ConnectionSource;

    /**
     * Provides basic transaction support for a {@link ConnectionSource}.
     *
     * <p>
     * <b>NOTE:</b> For transactions to work, the database being used must support the functionality.
     * </p>
     *
     * <p>
     * <b> NOTE: </b> If you are using the Spring type wiring in Java, {@link #initialize} should be called after all of the
     * set methods. In Spring XML, init-method="initialize" should be used.
     * </p>
     *
     * <p>
     * You can call this as an instance with a new TransactionManager(dataSource); or you can call it as a static like the
     * below example:
     *
     * <blockquote>
     *
     * <pre>
     * TransactionManager.callInTransaction(dataSource, new Callable&lt;Void&gt;() {
     * 	public Void call() throws Exception {
     * 		// delete both objects but make sure that if either one fails, the transaction is rolled back
     * 		// and both objects are &quot;restored&quot; to the database
     * 		fooDao.delete(foo);
     * 		barDao.delete(bar);
     * 		return null;
     * 	}
     * });
     * </pre>
     *
     * </blockquote>
     *
     * <p>
     * For Spring wiring of a Transaction Manager bean, we would do something like the following:
     * </p>
     *
     * <blockquote>
     *
     * <pre>
     * &lt;bean id="transactionManager" class="com.j256.ormlite.misc.TransactionManager" init-method="initialize"&gt;
     * 	&lt;property name="dataSource" ref="dataSource" /&gt;
     * &lt;/bean&gt;
     * </pre>
     *
     * </blockquote>
     *
     * @author Ghazi Triki
     */
    public class TransactionManager
    {
        public function TransactionManager( connectionSource : ConnectionSource = null)
        {
        }
    }
}