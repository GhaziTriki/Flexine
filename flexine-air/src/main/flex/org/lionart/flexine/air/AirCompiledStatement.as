package org.lionart.flexine.air
{
    import flash.data.SQLStatement;

    import org.lionart.flexine.support.CompiledStatement;

    public class AirCompiledStatement implements CompiledStatement
    {

        private var _decoratedStatement : SQLStatement;

        //private var _type : StatementType;

        public function AirCompiledStatement( sql : String, connection : AirSQLConnection /*, type : StatementType */ )
        {
            _decoratedStatement = new SQLStatement();
            _decoratedStatement.sqlConnection = connection.connection;
            _decoratedStatement.text = sql;
            //_type = type;
        }

    }
}
