package org.lionart.flexine.air
{
    import flash.data.SQLConnection;

    import org.lionart.flexine.support.DatabaseConnection;

    public class AirSQLConnection implements DatabaseConnection
    {
        private var _decoratedConnection : SQLConnection;

        public function AirSQLConnection( reference : Object, openMode : String )
        {
            _decoratedConnection = new SQLConnection();
            _decoratedConnection.open(reference, openMode);
        }

        public function setSavepoint( name : String = null ) : void
        {
            _decoratedConnection.setSavepoint(name);
        }

        public function commit() : void
        {
            _decoratedConnection.commit();
        }

        public function rollback() : void
        {
            _decoratedConnection.rollback();
        }

        public function rollbackToSavepoint( savePoint : String ) : void
        {
            _decoratedConnection.rollbackToSavepoint(savePoint);
        }

        public function get connection() : SQLConnection
        {
            return _decoratedConnection;
        }


    }
}
