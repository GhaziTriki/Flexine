package org.lionart.flexine.air
{
    import flash.filesystem.File;

    import flexunit.framework.Assert;

    import org.lionart.flexine.db.SqliteAirDatabaseType;

    public class TestAirConnectionSource
    {

        private static var connectionSource : AirConnectionSource;

        [Before]
        public function setUp() : void
        {
        }

        [After]
        public function tearDown() : void
        {
        }

        [BeforeClass]
        public static function setUpBeforeClass() : void
        {
            var dbFile : File = DatabaseHelper.getDatabaseFile() as File;
            if (dbFile.exists)
            {
                dbFile.deleteFile();
            }
        }

        [AfterClass]
        public static function tearDownAfterClass() : void
        {
        }

        [Test(order = 1)]
        public function testAirConnectionSource() : void
        {
            connectionSource = new AirConnectionSource(DatabaseHelper.getDatabaseFile());
            Assert.assertNotNull(connectionSource);
        }

        [Test(order = 2)]
        public function testIsOpen() : void
        {
            Assert.assertTrue(connectionSource.isOpen());
        }

        [Test(order = 3)]
        public function testGetReadWriteConnection() : void
        {
            var readWriteConnecton = connectionSource.getReadWriteConnection();
            Assert.assertNotNull(readWriteConnecton);
        }

        [Test(order = 4)]
        public function testGetReadOnlyConnection() : void
        {
            var readConnecton = connectionSource.getReadOnlyConnection();
            Assert.assertNotNull(readConnecton);
        }

        [Test(order = 5)]
        public function testGetDatabaseType() : void
        {
            var dbType = connectionSource.getDatabaseType();
            Assert.assertTrue(dbType is SqliteAirDatabaseType);
        }

        [Test(order = 6)]
        public function testGetSpecialConnection() : void
        {
            var specialConnecton = connectionSource.getSpecialConnection();
            Assert.assertNotNull(specialConnecton);
        }

        [Test(order = 7)]
        public function testSaveSpecialConnection() : void
        {
            Assert.fail("Test method Not yet implemented");
        }

        [Test(order = 100)]
        public function testClearSpecialConnection() : void
        {
            // FIXME
            connectionSource.clearSpecialConnection(connectionSource.getReadOnlyConnection());
            Assert.assertNull(connectionSource.getSpecialConnection());
        }

        [Test(order = 190)]
        public function testReleaseConnection() : void
        {
            connectionSource.releaseConnection(connectionSource.getReadOnlyConnection());
            Assert.fail("Test method Not yet implemented");
        }

        [Test(order = 200)]
        public function testClose() : void
        {
            connectionSource.close();
            Assert.assertFalse(connectionSource.isOpen());
        }


    }
}
