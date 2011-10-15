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
    import flash.errors.IllegalOperationError;

    import org.as3commons.lang.Enum;
    import org.as3commons.reflect.Field;
    import org.lionart.commons.lang.reflect.utils.ReflectionTools;
    import org.lionart.flexine.db.DatabaseType;
    import org.lionart.flexine.table.DatabaseTableConfig;

    /**
     * Database field configuration information either supplied by a {DatabaseField} annotation or by direct ActionScript or
     * Spring wiring.
     *
     * @author Ghazi Triki
     */
    public class DatabaseFieldConfig
    {
        private var _fieldName : String;
        private var _columnName : String;
        private var _dataType : DataType = DataType.NONE;
        private var _defaultValue : String;
        private var _width : int;
        private var _canBeNull : Boolean;
        private var _id : Boolean;
        private var _generatedId : Boolean;
        private var _generatedIdSequence : String;
        private var _foreign : Boolean;
        private var _foreignTableConfig : DatabaseTableConfig;
        private var _useGetSet : Boolean;
        private var _unknownEnumvalue : Enum;
        private var _throwIfNull : Boolean;
        private var _format : String;
        private var _unique : Boolean;
        private var _uniqueCombo : Boolean;
        private var _indexName : String;
        private var _uniqueIndexName : String;
        private var _foreignAutoRefresh : Boolean;
        private var _maxForeignLevel : int = DatabaseField.MAX_FOREIGN_LEVEL;
        private var _foreignCollection : Boolean;
        private var _foreignCollectionEager : Boolean;

        public function DatabaseFieldConfig( fieldName : String )
        {
            this._fieldName = fieldName;
        }

        /**
         * Configure DatabaseFieldConfig, beacause we are not able to redefine constructor.
         */
        public function configure( columnName : String, dataType : DataType, defaultValue : String, width : int,
            canBeNull : Boolean, id : Boolean, generatedId : Boolean, generatedIdSequence : String, foreign : Boolean,
            foreignTableConfig : DatabaseTableConfig, useGetSet : Boolean, unknownEnumValue : Enum,
            throwIfNull : Boolean, format : String, unique : Boolean, indexName : String, uniqueIndexName : String,
            autoRefresh : Boolean, maxForeignAutoRefreshLevel : int ) : void
        {
            this._columnName = columnName;
            this._dataType = dataType;
            this._defaultValue = defaultValue;
            this._width = width;
            this._canBeNull = canBeNull;
            this._id = id;
            this._generatedId = generatedId;
            this._generatedIdSequence = generatedIdSequence;
            this._foreign = foreign;
            this._foreignTableConfig = foreignTableConfig;
            this._useGetSet = useGetSet;
            this._unknownEnumvalue = unknownEnumValue;
            this._throwIfNull = throwIfNull;
            this._format = format;
            this._unique = unique;
            this._indexName = indexName;
            this._uniqueIndexName = uniqueIndexName;
            this._foreignAutoRefresh = autoRefresh;
            this._maxForeignLevel = maxForeignAutoRefreshLevel;
        }

        /**
         * Return the name of the field in the class.
         */
        public function get fieldName() : String
        {
            return _fieldName;
        }

        public function set fieldName( value : String ) : void
        {
            _fieldName = value;
        }

        /**
         * @see DatabaseField#columnName()
         */
        public function get columnName() : String
        {
            return _columnName;
        }

        public function set columnName( value : String ) : void
        {
            _columnName = value;
        }

        /**
         * @see DatabaseField#dataType()
         */
        public function get dataType() : DataType
        {
            return _dataType;
        }

        public function set dataType( value : DataType ) : void
        {
            _dataType = value;
        }

        /**
         * @see DatabaseField#defaultValue()
         */
        public function get defaultValue() : String
        {
            return _defaultValue;
        }

        public function set defaultValue( value : String ) : void
        {
            _defaultValue = value;
        }

        /**
         * @see DatabaseField#width()
         */
        public function get width() : int
        {
            return _width;
        }

        public function set width( value : int ) : void
        {
            _width = value;
        }

        /**
         * @see DatabaseField#canBeNull()
         */
        public function get canBeNull() : Boolean
        {
            return _canBeNull;
        }

        public function set canBeNull( value : Boolean ) : void
        {
            _canBeNull = value;
        }

        /**
         * @see DatabaseField#id()
         */
        public function get id() : Boolean
        {
            return _id;
        }

        public function set id( value : Boolean ) : void
        {
            _id = value;
        }

        /**
         * @see DatabaseField#generatedId()
         */
        public function get generatedId() : Boolean
        {
            return _generatedId;
        }

        public function set generatedId( value : Boolean ) : void
        {
            _generatedId = value;
        }

        /**
         * @see DatabaseField#generatedIdSequence()
         */
        public function get generatedIdSequence() : String
        {
            return _generatedIdSequence;
        }

        public function set generatedIdSequence( value : String ) : void
        {
            _generatedIdSequence = value;
        }

        /**
         * @see DatabaseField#foreign()
         */
        public function get foreign() : Boolean
        {
            return _foreign;
        }

        public function set foreign( value : Boolean ) : void
        {
            _foreign = value;
        }

        /**
         * For a foreign class which does not use the {@link DatabaseField} annotations, you need to inject the table
         * configuration.
         */
        public function get foreignTableConfig() : DatabaseTableConfig
        {
            return _foreignTableConfig;
        }

        public function set foreignTableConfig( value : DatabaseTableConfig ) : void
        {
            _foreignTableConfig = value;
        }

        /**
         * @see DatabaseField#useGetSet()
         */
        public function get useGetSet() : Boolean
        {
            return _useGetSet;
        }

        public function set useGetSet( value : Boolean ) : void
        {
            _useGetSet = value;
        }

        public function get unknownEnumvalue() : Enum
        {
            return _unknownEnumvalue;
        }

        public function set unknownEnumvalue( value : Enum ) : void
        {
            _unknownEnumvalue = value;
        }

        /**
         * @see DatabaseField#throwIfNull()
         */
        public function get throwIfNull() : Boolean
        {
            return _throwIfNull;
        }

        public function set throwIfNull( value : Boolean ) : void
        {
            _throwIfNull = value;
        }

        /**
         * @see DatabaseField#format()
         */
        public function get format() : String
        {
            return _format;
        }

        public function set format( value : String ) : void
        {
            _format = value;
        }

        /**
         * @see DatabaseField#unique()
         */
        public function get unique() : Boolean
        {
            return _unique;
        }

        public function set unique( value : Boolean ) : void
        {
            _unique = value;
        }

        /**
         * @see DatabaseField#uniqueCombo()
         */
        public function get uniqueCombo() : Boolean
        {
            return _uniqueCombo;
        }

        public function set uniqueCombo( value : Boolean ) : void
        {
            _uniqueCombo = value;
        }


        /**
         * @see DatabaseField#indexName()
         */
        public function get indexName() : String
        {
            return _indexName;
        }

        public function set indexName( value : String ) : void
        {
            _indexName = value;
        }

        /**
         * @see DatabaseField#uniqueIndexName()
         */
        public function get uniqueIndexName() : String
        {
            return _uniqueIndexName;
        }

        public function set uniqueIndexName( value : String ) : void
        {
            _uniqueIndexName = value;
        }

        /**
         * @see DatabaseField#maxForeignLevel()
         */
        public function get maxForeignLevel() : int
        {
            return _maxForeignLevel;
        }

        public function set maxForeignLevel( maxForeignLevel : int ) : void
        {
            this._maxForeignLevel = maxForeignLevel;
        }

        /**
         * @see DatabaseField#foreignAutoRefresh()
         */
        public function get foreignAutoRefresh() : Boolean
        {
            return _foreignAutoRefresh;
        }

        public function set foreignAutoRefresh( value : Boolean ) : void
        {
            _foreignAutoRefresh = value;
        }

        public function get foreignCollection() : Boolean
        {
            return _foreignCollection;
        }

        public function set foreignCollection( value : Boolean ) : void
        {
            _foreignCollection = value;
        }

        public function get foreignCollectionEager() : Boolean
        {
            return _foreignCollectionEager;
        }

        public function set foreignCollectionEager( value : Boolean ) : void
        {
            _foreignCollectionEager = value;
        }

        /**
         * Create and return a config converted from a {Field} that may have a {DatabaseField} metadata.
         */
        public static function fromField( databaseType : DatabaseType, tableName : String, field : Field ) : DatabaseFieldConfig
        {
            // first we lookup the DatabaseField annotation
            var databaseField : DatabaseField = ReflectionTools.fillFromMetada(field.getMetadata(DatabaseField.NAME)[0], DatabaseField) as DatabaseField;
            if (databaseField != null)
            {
                if (databaseField.persisted)
                {
                    return fromDatabaseField(databaseType, tableName, field, databaseField);
                }
                else
                {
                    return null;
                }
            }

            var foreignCollection : ForeignCollectionField = ReflectionTools.fillFromMetada(field.getMetadata(ForeignCollectionField.NAME)[0], ForeignCollectionField) as ForeignCollectionField;
            if (foreignCollection != null)
            {
                return fromForeignCollection(databaseType, tableName, field, foreignCollection);
            }

            return null;
        }

        private static function fromDatabaseField( databaseType : DatabaseType, tableName : String, field : Field, databaseField : DatabaseField ) : DatabaseFieldConfig
        {
            var config : DatabaseFieldConfig = new DatabaseFieldConfig(field.name);
            config.fieldName = field.name;
            if (databaseType.isEntityNamesMustBeUpCase())
            {
                config.fieldName = config.fieldName.toUpperCase();
            }
            if (databaseField.columnName.length > 0)
            {
                config.columnName = databaseField.columnName;
            }
            else
            {
                config.columnName = null;
            }
            config.dataType = databaseField.dataType;
            // NOTE: == did not work with the NO_DEFAULT string
            if (databaseField.defaultValue == DatabaseField.NO_DEFAULT)
            {
                config.defaultValue = null;
            }
            else
            {
                config.defaultValue = databaseField.defaultValue;
            }
            config.width = databaseField.width;
            config.canBeNull = databaseField.canBeNull;
            config.id = databaseField.id;
            config.generatedId = databaseField.generatedId;
            if (databaseField.generatedIdSequence.length > 0)
            {
                config.generatedIdSequence = databaseField.generatedIdSequence;
            }
            else
            {
                config.generatedIdSequence = null;
            }
            config.foreign = databaseField.foreign;
            config.useGetSet = databaseField.useGetSet;
            if (databaseField.unknownEnumName.length > 0)
            {
                config.unknownEnumvalue = findMatchingEnumVal(field, databaseField.unknownEnumName);
            }
            else
            {
                config.unknownEnumvalue = null;
            }
            config.throwIfNull = databaseField.throwIfNull;
            if (databaseField.format.length > 0)
            {
                config.format = databaseField.format;
            }
            else
            {
                config.format = null;
            }
            config.unique = databaseField.unique;
            config.uniqueCombo = databaseField.uniqueCombo;

            // add in the index information
            config.indexName = findIndexName(tableName, databaseField.indexName, databaseField.index, config);
            config.uniqueIndexName =
                findIndexName(tableName, databaseField.uniqueIndexName, databaseField.uniqueIndex, config);
            config.foreignAutoRefresh = databaseField.foreignAutoRefresh;
            config.maxForeignLevel = databaseField.maxForeignLevel;

            return config;
        }

        private static function fromForeignCollection( databaseType : DatabaseType, tableName : String, field : Field, foreignCollection : ForeignCollectionField ) : DatabaseFieldConfig
        {
            var config : DatabaseFieldConfig = new DatabaseFieldConfig(field.name);
            config.foreignCollection = true;
            config.foreignCollectionEager = foreignCollection.eager;
            return config;
        }

        private static function findIndexName( tableName : String, indexName : String, index : Boolean, config : DatabaseFieldConfig ) : String
        {
            if (indexName.length > 0)
            {
                return indexName;
            }
            else if (index)
            {
                if (config.columnName == null)
                {
                    return tableName + "_" + config.fieldName + "_idx";
                }
                else
                {
                    return tableName + "_" + config.columnName + "_idx";
                }
            }
            else
            {
                return null;
            }
        }

        private static function findMatchingEnumVal( field : Field, unknownEnumName : String ) : Enum
        {
            for each (var enumType : String in Enum.getValues(field.type.clazz))
            {
                if (Enum(enumType).name == unknownEnumName)
                {
                    return field.type[enumType];
                }
                throw new IllegalOperationError("Unknwown enum unknown name " + unknownEnumName + " for field " + field);
            }
            return null;
        }
    }
}


