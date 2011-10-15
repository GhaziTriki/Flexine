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

    [ExcludeClass]
    /**
     * Metadata that identifies a field in a class that corresponds to a column in the database and will be persisted.
     * Fields that are not to be persisted such as transient or other temporary fields probably should be ignored. For
     * example:
     *
     * <p>
     * <blockquote>
     *
     * <pre>
     * [DatabaseField(id = true)]
     * private String name;
     *
     * [DatabaseField(columnName = &quot;passwd&quot;, canBeNull = false)]
     * private String password;
     * </pre>
     *
     * </blockquote>
     * </p>
     *
     * <p>
     * <b> WARNING:</b> If you add any extra fields here, you will need to add them to {DatabaseFieldConfig} as well.
     * </p>
     *
     * @author Ghazi Triki
     */
    public final class DatabaseField
    {
        /** this special string is used as a .equals check to see if no default was specified */
        public static const NO_DEFAULT : String = "__flexine__ no default value string was specified";

        public static const NAME : String = "DatabaseField";

        /**
         * If you have two objects that both are {@link #foreign()} of each other and both have
         * {@link #foreignAutoRefresh()} set to true then if one is retrieved, it will go recursive. For example, you might
         * have a Answer with a foreign bestQuestion field and the Question with a foreign Answer. If you lookup an Answer,
         * it will lookup and auto-refresh the Question which will lookup and auto-refresh the Answer, etc.. This is the
         * maximum number of times it will go back and forth before stopping the auto-refresh.
         */
        public static const MAX_FOREIGN_LEVEL : int = 2;
        
        private var _columnName : String = "";

        /**
         * The name of the column in the database. If not set then the name is taken from the field name.
         */
        public function get columnName() : String
        {
            return _columnName;
        }

        public function set columnName( value : String ) : void
        {
            _columnName = value;
        }


        private var _dataType : DataType = DataType.STRING;

        /**
         * The DataType associated with the field. If not set then the Java class of the field is used to match with the
         * appropriate DataType.
         */
        public function get dataType() : DataType
        {
            return _dataType;
        }

        public function set dataType( value : DataType ) : void
        {
            _dataType = value;
        }


        private var _defaultValue : String = NO_DEFAULT;

        /**
         * The default value of the field for creating the table. Default is none.
         */
        public function get defaultValue() : String
        {
            return _defaultValue;
        }

        public function set defaultValue( value : String ) : void
        {
            _defaultValue = value;
        }

        private var _width : int = 0;

        /**
         * Width of array fields (often for strings). Default is database-specific.
         */
        public function get width() : int
        {
            return _width;
        }

        public function set width( value : int ) : void
        {
            _width = value;
        }

        private var _canBeNull : Boolean = true;

        /**
         * Whether the field can be assigned to null or have no value. Default is true.
         */
        public function get canBeNull() : Boolean
        {
            return _canBeNull;
        }

        public function set canBeNull( value : Boolean ) : void
        {
            _canBeNull = value;
        }

        private var _id : Boolean = false;

        /**
         * Whether the field is the id field or not. Default is false. Only one field can have this set in a class. If you
         * don't have it set then you won't be able to use the query, update, and delete by ID methods. Only one of this,
         * {#generatedId}, and {#generatedIdSequence} can be specified.
         */
        public function get id() : Boolean
        {
            return _id;
        }

        public function set id( value : Boolean ) : void
        {
            _id = value;
        }

        private var _generatedId : Boolean = false;

        /**
         * Whether the field is an auto-generated id field. Default is false. With databases for which
         * {DatabaseType#isIdSequenceNeeded} is true then this will cause the name of the sequence to be
         * auto-generated. To specify the name of the sequence use {#generatedIdSequence}. Only one of this,
         * {#id}, and {#generatedIdSequence} can be specified.
         */
        public function get generatedId() : Boolean
        {
            return _generatedId;
        }

        public function set generatedId( value : Boolean ) : void
        {
            _generatedId = value;
        }

        private var _generatedIdSequence : String = "";

        /**
         * The name of the sequence number to be used to generate this value. Default is none. This is only necessary for
         * database for which {DatabaseType#isIdSequenceNeeded} is true and you already have a defined sequence that
         * you want to use. If you use {#generatedId} instead then the code will auto-generate a sequence name. Only
         * one of this, {#id}, and {#generatedId} can be specified.
         */
        public function get generatedIdSequence() : String
        {
            return _generatedIdSequence;
        }

        public function set generatedIdSequence( value : String ) : void
        {
            _generatedIdSequence = value;
        }

        private var _foreign : Boolean = false;

        /**
         * Field is a non-primitive object that corresponds to another class that is also stored in the database. It must
         * have an id field (either {#id}, {#generatedId}, or {#generatedIdSequence} which will be stored
         * in this table. When an object is returned from a query call, any foreign objects will just have the id field set
         * in it. To get all of the other fields you will have to do a refresh on the object using its own Dao.
         */
        public function get foreign() : Boolean
        {
            return _foreign;
        }

        public function set foreign( value : Boolean ) : void
        {
            _foreign = value;
        }

        private var _useGetSet : Boolean = false;

        /**
         * Package should use get...() and set...() to access the field value instead of the default direct field access via
         * reflection. This may be necessary if the object you are storing has protections around it.
         *
         * <p>
         * <b>NOTE:</b> The name of the get method <i>must</i> match getXxx() where Xxx is the name of the field with the
         * first letter capitalized. The get <i>must</i> return a class which matches the field's. The set method
         * <i>must</i> match setXxx(), have a single argument whose class matches the field's, and return void. For example:
         * </p>
         *
         * <blockquote>
         *
         * <pre>
         * [DatabaseField]
         * private orderCount : int;
         *
         * public getOrderCount() : int
         * {
         * 	return orderCount;
         * }
         *
         * public setOrderCount( orderCount : int ) : void
         * {
         * 	this.orderCount = orderCount;
         * }
         * </pre>
         *
         * </blockquote>
         */
        public function get useGetSet() : Boolean
        {
            return _useGetSet;
        }

        public function set useGetSet( value : Boolean ) : void
        {
            _useGetSet = value;
        }

        private var _unknownEnumName : String = "";

        /**
         * If the field is an Enum and the database has a value that is not one of the names in the enum then this name will
         * be used instead. It must match one of the enum names. This is mainly useful when you are worried about backwards
         * compatibility with older database rows or future compatibility if you have to roll back to older data definition.
         */
        public function get unknownEnumName() : String
        {
            return _unknownEnumName;
        }

        public function set unknownEnumName( value : String ) : void
        {
            _unknownEnumName = value;
        }

        private var _throwIfNull : Boolean = false;

        /**
         * If this is set to true (default false) then it will throw a SQLException if a null value is attempted to be
         * de-persisted into a primitive. This must only be used on a primitive field. If this is false then if the database
         * field is null, the value of the primitive will be set to 0.
         */
        public function get throwIfNull() : Boolean
        {
            return _throwIfNull;
        }

        public function set throwIfNull( value : Boolean ) : void
        {
            _throwIfNull = value;
        }

        private var _persisted : Boolean = true;

        /**
         * Set this to be false (default true) to not store this field in the database. This is useful if you want to have
         * the annotation on all of your fields but turn off the writing of some of them to the database.
         */
        public function get persisted() : Boolean
        {
            return _persisted;
        }

        public function set persisted( value : Boolean ) : void
        {
            _persisted = value;
        }


        private var _format : String = "";

        /**
         * Optional format information that can be used by various field types. For example, if the Date is to be persisted
         * as a string, this can set what format string to use for the date.
         */
        public function get format() : String
        {
            return _format;
        }

        public function set format( value : String ) : void
        {
            _format = value;
        }

        private var _unique : Boolean = false;

        /**
         * Set this to be true (default false) to have the database insure that the column is unique to all rows in the
         * table. Use this when you wan a field to be unique even if it is not the identify field. For example, if you have
         * the firstName and lastName fields, both with unique=true and you have "Bob", "Smith" in the database, you cannot
         * insert either "Bob", "Jones" or "Kevin", "Smith".
         */
        public function get unique() : Boolean
        {
            return _unique;
        }

        public function set unique( value : Boolean ) : void
        {
            _unique = value;
        }
        
        private var _uniqueCombo : Boolean = false;
        
        /**
         * Set this to be true (default false) to have the database insure that _all_ of the columns marked with this as
         * true will together be unique. For example, if you have the firstName and lastName fields, both with unique=true
         * and you have "Bob", "Smith" in the database, you cannot insert another "Bob", "Smith" but you can insert "Bob",
         * "Jones" and "Kevin", "Smith".
         */
        public function get uniqueCombo():Boolean
        {
            return _uniqueCombo;
        }

        public function set uniqueCombo(value:Boolean):void
        {
            _uniqueCombo = value;
        }

        
        private var _index : Boolean = false;

        /**
         * Set this to be true (default false) to have the database add an index for this field. This will create an index
         * with the name columnName + "_idx". To specify a specific name of the index or to index multiple fields, use
         * {@link #indexName()}.
         */
        public function get index() : Boolean
        {
            return _index;
        }

        public function set index( value : Boolean ) : void
        {
            _index = value;
        }

        private var _uniqueIndex : Boolean = false;

        /**
         * Set this to be true (default false) to have the database add a unique index for this field. This is the same as
         * the {@link #index()} field but this ensures that all of the values in the index are unique..
         */
        public function get uniqueIndex() : Boolean
        {
            return _uniqueIndex;
        }

        public function set uniqueIndex( value : Boolean ) : void
        {
            _uniqueIndex = value;
        }

        private var _indexName : String = "";

        /**
         * Set this to be a string (default none) to have the database add an index for this field with this name. You do
         * not need to specify the {@link #index()} boolean as well. To index multiple fields together in one index, each of
         * the fields should have the same indexName value.
         */
        public function get indexName() : String
        {
            return _indexName;
        }

        public function set indexName( value : String ) : void
        {
            _indexName = value;
        }

        private var _uniqueIndexName : String = "";

        /**
         * Set this to be a string (default none) to have the database add a unique index for this field with this name.
         * This is the same as the {@link #indexName()} field but this ensures that all of the values in the index are
         * unique.
         */
        public function get uniqueIndexName() : String
        {
            return _uniqueIndexName;
        }

        public function set uniqueIndexName( value : String ) : void
        {
            _uniqueIndexName = value;
        }

        private var _foreignAutoRefresh : Boolean = false;

        /**
         * Set this to be true (default false) to have a foreign field automagically refreshed when an object is queried.
         * This will _not_ automagically create the foreign object but when the object is queried, a separate database call
         * will be made to load of the fields of the foreign object via an internal DAO. The default is to just have the ID
         * field in the object retrieved and for the caller to call refresh on the correct DAO.
         *
         * <p>
         * <b>NOTE:</b> This will create another DAO object so that low memory devices may want to call refresh by hand.
         * </p>
         */
        public function get foreignAutoRefresh() : Boolean
        {
            return _foreignAutoRefresh;
        }

        public function set foreignAutoRefresh( value : Boolean ) : void
        {
            _foreignAutoRefresh = value;
        }

        private var _maxForeignLevel : int = MAX_FOREIGN_LEVEL;

        /**
         * Set this to be the number of times to configure a foreign object's foreign object. If you query for A and it has
         * an foreign field B which has an foreign field C ..., then a lot of configuration information is being stored. If
         * each of these fields is auto-refreshed, then querying for A could get expensive. Setting this value to 1 will
         * mean that when you query for A, B will be auto-refreshed, but C will just have its id field set. This also works
         * if A has an auto-refresh field B which has an auto-refresh field A.
         *
         * <p>
         * <b>NOTE:</b> Increasing this value will result in more database transactions whenever you query for A, so use
         * carefully.
         * </p>
         */
        public function get maxForeignLevel() : int
        {
            return _maxForeignLevel;
        }
        
        public function set maxForeignLevel(value:int):void
        {
            _maxForeignLevel = value;
        }
    }
}


