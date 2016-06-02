﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using MercadoEnvio.Properties;

namespace MercadoEnvio.Helpers
{
    public class DataBaseHelper
    {
        #region attributes
        private string _connectionString;
        private readonly SqlConnection _sqlConn;
        private SqlTransaction _sqlTrans;
        #endregion

        #region properties
        public string ConnectionString
        {
            get { return _connectionString; }
            set { _connectionString = value; }
        }

        public enum ExecutionType
        {
            Scalar,
            NonQuery
        };

        public SqlConnection Connection
        {
            get { return _sqlConn; }
        }
        #endregion

        #region constructor
        public DataBaseHelper(string connectionString)
        {
            _connectionString = connectionString;
            try
            {
                _sqlConn = new SqlConnection(_connectionString);
            }
            catch (Exception ex)
            {
                throw new Exception(Resources.ErrorBD, ex);
            }
        }
        #endregion

        #region methods
        #region transaction methods
        public void BeginTransaction()
        {
            try
            {
                if (Connection != null)
                {
                    Connection.Open();
                    _sqlTrans = Connection.BeginTransaction();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(Resources.ErrorTrans,ex);
            }
        }

        public void RollbackTransaction()
        {
            try
            {
                if (_sqlTrans != null)
                {
                    _sqlTrans.Rollback();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(Resources.ErrorTrans, ex);
            }
        }

        public void EndTransaction()
        {
            try
            {
                if (_sqlTrans != null)
                {
                    _sqlTrans.Commit();
                    _sqlTrans.Dispose();
                    _sqlTrans = null;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(Resources.ErrorTrans, ex);
            }
        }
        #endregion

        #region data methods
        public DataTable GetDataAsTable(string storedProcedure)
        {
            SqlCommand sqlCommand;
            SqlDataAdapter sqlAdapter;
            DataTable sqlTable;

            sqlCommand = new SqlCommand();
            sqlAdapter = new SqlDataAdapter(sqlCommand);

            try
            {
                if (Connection != null && Connection.State != ConnectionState.Open)
                {
                    Connection.Open();
                }

                sqlCommand.CommandText = storedProcedure;
                sqlCommand.Connection = Connection;
                sqlCommand.CommandType = CommandType.StoredProcedure;

                sqlTable = new DataTable();
                sqlAdapter.Fill(sqlTable);

                return sqlTable;
            }
            catch (Exception ex)
            {
                throw new Exception(Resources.ErrorTable,ex);
            }
            finally
            {
                if (Connection != null && Connection.State == ConnectionState.Open)
                {
                    Connection.Close();
                }
                if (sqlCommand != null)
                {
                    sqlCommand.Dispose();
                }
                if (sqlAdapter != null)
                {
                    sqlAdapter.Dispose();
                }
            }
        }

        public DataTable GetDataAsTable(string storedProcedure, List<SqlParameter> parameters)
        {
            SqlCommand sqlCommand = new SqlCommand();
            SqlDataAdapter sqlAdapter = new SqlDataAdapter(sqlCommand);
            DataTable sqlTable = new DataTable();

            try
            {
                if (Connection != null && Connection.State != ConnectionState.Open)
                {
                    Connection.Open();
                }

                sqlCommand.CommandText = storedProcedure;
                sqlCommand.Connection = Connection;
                sqlCommand.CommandType = CommandType.StoredProcedure;

                foreach (SqlParameter sqlPrm in parameters)
                {
                    sqlCommand.Parameters.Add(sqlPrm);
                }

                sqlAdapter.Fill(sqlTable);
                return sqlTable;
            }
            catch (Exception ex)
            {
                throw new Exception(Resources.ErrorTable, ex);
            }
            finally
            {
                if (Connection != null && Connection.State == ConnectionState.Open)
                {
                    Connection.Close();
                }
                sqlCommand.Dispose();
                sqlAdapter.Dispose();
            }
        }

        public object ExectInstruction(ExecutionType execType, string storedProcedure, List<SqlParameter> parameters)
        {
            object result = null;
            SqlCommand sqlCommand = new SqlCommand();

            try
            {
                if (Connection != null && Connection.State != ConnectionState.Open)
                {
                    Connection.Open();
                }

                sqlCommand.CommandText = storedProcedure;
                sqlCommand.Connection = Connection;
                sqlCommand.CommandType = CommandType.StoredProcedure;

                foreach (SqlParameter sqlPrm in parameters)
                {
                    sqlCommand.Parameters.Add(sqlPrm);
                }

                if (_sqlTrans != null)
                {
                    sqlCommand.Transaction = _sqlTrans;
                }

                switch (execType)
                {
                    case ExecutionType.NonQuery:
                        result = sqlCommand.ExecuteNonQuery();
                        break;
                    case ExecutionType.Scalar:
                        result = sqlCommand.ExecuteScalar();
                        break;
                }

                return result;
            }
            catch (Exception ex)
            {
                RollbackTransaction();
                throw new Exception(Resources.ErrorSP,ex);
            }
            finally
            {
                if (_sqlTrans == null)
                {
                    if (Connection != null && Connection.State == ConnectionState.Open)
                    {
                        Connection.Close();
                    }
                }
                sqlCommand.Dispose();
            }
        }

        public void EndConnection()
        {
            try
            {
                if (Connection != null)
                {
                    Connection.Close();
                    if (_sqlTrans != null)
                    {
                        _sqlTrans.Dispose();
                    }
                    Connection.Dispose();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(Resources.ErrorBD,ex);
            }
        }
        #endregion
        #endregion
    }
}
