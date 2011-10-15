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
    import org.as3commons.reflect.Constructor;
    import org.as3commons.reflect.Field;
    import org.lionart.flexine.dao.Dao;
    import org.lionart.flexine.statement.mapped.MappedQueryForId;
    import org.lionart.flexine.support.ConnectionSource;
    import org.lionart.flexine.table.TableInfo;

    public class FieldType
    {

        // private static const AtomicInteger recursionProtection = new AtomicInteger();

        /** default suffix added to fields that are id fields of foreign objects */
        public static const FOREIGN_ID_FIELD_SUFFIX : String = "_id";
        public static const MAX_FOREIGN_RECURSE_LEVEL : int = 10;

        private var _connectionSource : ConnectionSource;
        private var _tableName : String;
        private var _field : Field;
        private var _fieldName : String;
        private var _dbColumnName : String;
        private var _dataType : DataType;
        private var _dataTypeConfigObj : Object;
        private var _defaultValue : Object;
        private var _fieldConfig : DatabaseFieldConfig;
        private var _isId : Boolean;
        private var _isGeneratedId : Boolean;
        private var _generatedIdSequence : String;
        private var _fieldConverter : FieldConverter;
        private var _foreignIdField : FieldType;
        private var _foreignConstructor : Constructor;
        private var _foreignTableInfo : TableInfo;
        private var _foreignFieldType : FieldType;
        private var _foreignDao : Dao;
        private var _mappedQueryForId : MappedQueryForId;
        private var _fieldGetMethod : Function;
        private var _fieldSetMethod : Function;

        /**
         * You should use {@link FieldType#createFieldType} to instantiate one of these field if you have a {@link Field}.
         */
        public function FieldType( connectionSource : ConnectionSource, tableName : String,
            field : Field, fieldConfig : DatabaseFieldConfig,
            parentClass : Class )
        {
        /*
           this._connectionSource = connectionSource;
           var databaseType : DatabaseType = connectionSource.getDatabaseType();
           this._tableName = tableName;
           this._field = field;
           this._fieldName = field.name;
           var clazz : Class = field.type;
           var dataType : DataType;
           if (fieldConfig.dataType == DataType.OBJECT)
           {
           dataType = DataType.lookupClass(clazz);
           }
           else
           {
           dataType = fieldConfig.dataType;
           if (!dataType.isValidForType(clazz))
           {
           throw new IllegalOperationError("Field class " + clazz + " for field " + this
           + " is not valid for data type " + dataType);
           }
           }
           var defaultFieldName : String = field.name;
           /*
         * See if we have an auto-refresh field first. If we are in too many levels then just fall back to just being a
         * foreign field.
         */
        /*
           if (fieldConfig.foreignAutoRefresh && getLevel() < fieldConfig.maxForeignLevel)
           {
           if (dataType.isPrimitive())
           {
           throw new IllegalOperationError("Field " + this + " is a primitive class " + clazz
           + " but marked as foreign");
           }
           var tableConfig : DatabaseTableConfig = fieldConfig.foreignTableConfig;
           incrementLevel();
           try {
           if (tableConfig == null) {
           // NOTE: the cast is necessary for maven
           this._foreignDao = BaseDaoImpl(DaoManager.createDao(connectionSource, clazz));
           this._foreignTableInfo = BaseDaoImpl(this._foreignDao).getTableInfo();
           } else {
           tableConfig.extractFieldTypes(connectionSource);
           // NOTE: the cast is necessary for maven
           this._foreignDao = BaseDaoImpl(DaoManager.createDao(connectionSource, tableConfig));
           this._foreignTableInfo = BaseDaoImpl(this._foreignDao).getTableInfo();
           }
           }
           finally
           {
           decrementLevel();
           }
           if (this._foreignTableInfo.getIdField() == null) {
           throw new IllegalOperationError("Foreign field " + clazz + " does not have id field");
           }
           defaultFieldName = defaultFieldName + FOREIGN_ID_FIELD_SUFFIX;
           this._foreignIdField = this._foreignTableInfo.getIdField();
           // this field's data type is the foreign id's type
           dataType = this._foreignIdField._dataType;

           var castMappedQueryForId : MappedQueryForId =
           MappedQueryForId(MappedQueryForId.build(databaseType, this._foreignTableInfo));
           this._mappedQueryForId = castMappedQueryForId;
           this._foreignConstructor = this._foreignTableInfo.getConstructor();
           this._foreignFieldType = null;
           }

           else if (fieldConfig.foreign || fieldConfig.foreignAutoRefresh) {
           defaultFieldName = defaultFieldName + FOREIGN_ID_FIELD_SUFFIX;
           /*
         * If we are a foreign-field or if the foreign-auto-refresh was in too deep then we configure this as a
         * foreign field. This is <= instead of < because we go one more level than the foreign auto-refresh.
         */
        /*
           if (getLevel() <= fieldConfig.maxForeignLevel) {
           if (dataType.isPrimitive()) {
           throw new IllegalOperationError("Field " + this + " is a primitive class " + clazz
           + " but marked as foreign");
           }
           DatabaseTableConfig<?> tableConfig = fieldConfig.foreignTableConfig;
           incrementLevel();
           try {
           if (tableConfig != null) {
           tableConfig.extractFieldTypes(connectionSource);
           // NOTE: the cast is necessary for maven
           this._foreignDao = BaseDaoImpl(DaoManager.createDao(connectionSource, tableConfig));
           this._foreignTableInfo = ((BaseDaoImpl<?, ?>) this.foreignDao).getTableInfo();
           this._foreignIdField = this.foreignTableInfo.getIdField();
           this._foreignConstructor = this.foreignTableInfo.getConstructor();
           } else if (BaseDaoEnabled.class.isAssignableFrom(clazz)) {
           // NOTE: the cast is necessary for maven
           this._foreignDao = (BaseDaoImpl<?, ?>) DaoManager.createDao(connectionSource, clazz);
           this._foreignTableInfo = ((BaseDaoImpl<?, ?>) this.foreignDao).getTableInfo();
           this._foreignIdField = this.foreignTableInfo.getIdField();
           this._foreignConstructor = this.foreignTableInfo.getConstructor();
           } else {
           this.foreignDao = null;
           this.foreignTableInfo = null;
           this.foreignIdField =
           DatabaseTableConfig.extractIdFieldType(connectionSource, clazz,
           DatabaseTableConfig.extractTableName(clazz));
           this.foreignConstructor = DatabaseTableConfig.findNoArgConstructor(clazz);
           }
           } finally {
           decrementLevel();
           }
           if (this.foreignIdField == null) {
           throw new IllegalOperationError("Foreign field " + clazz + " does not have id field");
           }
           // this field's data type is the foreign id's type
           dataType = this.foreignIdField.getDataType();
           this.mappedQueryForId = null;
           } else {
           // act like it's not foreign
           this.mappedQueryForId = null;
           this.foreignIdField = null;
           this.foreignConstructor = null;
           this.foreignTableInfo = null;
           this.foreignDao = null;
           }
           this.foreignFieldType = null;
           } else if (fieldConfig.isForeignCollection() && getLevel() == 0) {
           if (clazz != Collection.class && !ForeignCollection.class.isAssignableFrom(clazz)) {
           throw new SQLException("Field class for '" + field.getName() + "' must be of class "
           + ForeignCollection.class.getSimpleName() + " or Collection.");
           }
           Type type = field.getGenericType();
           if (!(type instanceof ParameterizedType)) {
           throw new SQLException("Field class for '" + field.getName() + "' must be a parameterized Collection.");
           }
           Type[] genericArguments = ((ParameterizedType) type).getActualTypeArguments();
           if (genericArguments.length == 0) {
           // i doubt this will ever be reached
           throw new SQLException("Field class for '" + field.getName()
           + "' must be a parameterized Collection with at least 1 type.");
           }
           clazz = (Class<?>) genericArguments[0];
           DatabaseTableConfig<?> tableConfig = fieldConfig.getForeignTableConfig();
           incrementLevel();
           try {
           if (tableConfig == null) {
           Dao<Object, Object> castDao = (Dao<Object, Object>) DaoManager.createDao(connectionSource, clazz);
           this.foreignDao = castDao;
           }

           else {
           Dao<Object, Object> castDao =
           (Dao<Object, Object>) DaoManager.createDao(connectionSource, tableConfig);
           this.foreignDao = castDao;
           }
           } finally {
           decrementLevel();
           }

           var foreignFieldType :FieldType= null;
           for (FieldType fieldType : ((BaseDaoImpl<?, ?>) this.foreignDao).getTableInfo().getFieldTypes()) {
           if (fieldType.getFieldType() == parentClass) {
           foreignFieldType = fieldType;
           break;
           }
           }
           if (foreignFieldType == null) {
           throw new SQLException("Foreign collection object " + clazz + " for field '" + field.getName()
           + "' does not contain a foreign field of class " + parentClass);
           }
           if (!foreignFieldType.isForeign()) {
           // this may never be reached
           throw new SQLException("Foreign collection object " + clazz + " for field '" + field.getName()
           + "' contains a field of class " + parentClass + " but it's not foreign");
           }
           this.foreignFieldType = foreignFieldType;
           this.foreignTableInfo = null;
           this.mappedQueryForId = null;
           this.foreignIdField = null;
           this.foreignConstructor = null;
           } else if (dataType == DataType.UNKNOWN && (!fieldConfig.isForeignCollection())) {
           if (byte[].class.isAssignableFrom(clazz)) {
           throw new SQLException("ORMLite can't store unknown class " + clazz + " for field '" + field.getName()
           + "'. byte[] fields must specify dataType=DataType.BYTE_ARRAY or SERIALIZABLE");
           } else if (Serializable.class.isAssignableFrom(clazz)) {
           throw new SQLException("ORMLite can't store unknown class " + clazz + " for field '" + field.getName()
           + "'. Serializable fields must specify dataType=DataType.SERIALIZABLE");
           } else {
           throw new IllegalOperationError("ORMLite does not know how to store field class " + clazz
           + " for field " + this);
           }
           } else {
           this.foreignTableInfo = null;
           this.mappedQueryForId = null;
           this.foreignDao = null;
           this.foreignFieldType = null;
           this.foreignIdField = null;
           this.foreignConstructor = null;
           }
           if (fieldConfig.getColumnName() == null) {
           this.dbColumnName = defaultFieldName;
           } else {
           this.dbColumnName = fieldConfig.getColumnName();
           }
           this.dataType = dataType;
           this.fieldConfig = fieldConfig;
           if (fieldConfig.isId()) {
           if (fieldConfig.isGeneratedId() || fieldConfig.getGeneratedIdSequence() != null) {
           throw new IllegalOperationError("Must specify one of id, generatedId, and generatedIdSequence with "
           + field.getName());
           }
           this.isId = true;
           this.isGeneratedId = false;
           this.generatedIdSequence = null;
           } else if (fieldConfig.isGeneratedId()) {
           if (fieldConfig.getGeneratedIdSequence() != null) {
           throw new IllegalOperationError("Must specify one of id, generatedId, and generatedIdSequence with "
           + field.getName());
           }
           this.isId = true;
           this.isGeneratedId = true;
           if (databaseType.isIdSequenceNeeded()) {
           this.generatedIdSequence = databaseType.generateIdSequenceName(tableName, this);
           } else {
           this.generatedIdSequence = null;
           }
           } else if (fieldConfig.getGeneratedIdSequence() != null) {
           this.isId = true;
           this.isGeneratedId = true;
           String seqName = fieldConfig.getGeneratedIdSequence();
           if (databaseType.isEntityNamesMustBeUpCase()) {
           seqName = seqName.toUpperCase();
           }
           this.generatedIdSequence = seqName;
           } else {
           this.isId = false;
           this.isGeneratedId = false;
           this.generatedIdSequence = null;
           }
           if (this.isGeneratedId && !this.dataType.isValidGeneratedType()) {
           StringBuilder sb = new StringBuilder();
           sb.append("Generated-id field '").append(field.getName());
           sb.append("' in ").append(field.getDeclaringClass().getSimpleName());
           sb.append(" can't be type ").append(this.dataType);
           sb.append(".  Must be one of: ");
           for (DataType type : DataType.values()) {
           if (type.isValidGeneratedType()) {
           sb.append(type).append(' ');
           }
           }
           throw new IllegalOperationError(sb.toString());
           }
           this.fieldConverter = databaseType.getFieldConverter(dataType);
           if (this.isId && this.foreignIdField != null) {
           throw new IllegalOperationError("Id field " + field.getName() + " cannot also be a foreign object");
           }
           if (fieldConfig.isUseGetSet()) {
           this.fieldGetMethod = DatabaseFieldConfig.findGetMethod(field, true);
           this.fieldSetMethod = DatabaseFieldConfig.findSetMethod(field, true);
           } else {
           this.fieldGetMethod = null;
           this.fieldSetMethod = null;
           }
           if (fieldConfig.isThrowIfNull() && !dataType.isPrimitive()) {
           throw new SQLException("Field " + field.getName() + " must be a primitive if set with throwIfNull");
           }
           if (this.isId && !dataType.isAppropriateId()) {
           throw new SQLException("Field '" + field.getName() + "' is of data type " + dataType
           + " which cannot be the ID field");
           }
           this.dataTypeConfigObj = dataType.makeConfigObject(this);
           String defaultStr = fieldConfig.getDefaultValue();
           if (defaultStr == null || defaultStr.equals("")) {
           this.defaultValue = null;
           } else if (this.isGeneratedId) {
           throw new SQLException("Field '" + field.getName() + "' cannot be a generatedId and have a default value '"
           + defaultStr + "'");
           } else {
           this.defaultValue = this.fieldConverter.parseDefaultString(this, defaultStr);
           }*/
        }

        private function getLevel() : Boolean
        {
            // TODO Auto Generated method stub
            return false;
        }

        private function incrementLevel() : void
        {
            // TODO Auto Generated method stub

        }

        /**
         * Return the format of the field.
         */
        public function getFormat() : String
        {
            return _fieldConfig.format;
        }


        public function getDataTypeConfigObj() : Object
        {
            return _dataTypeConfigObj;
        }

    }
}

