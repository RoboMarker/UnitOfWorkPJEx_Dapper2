﻿using Dapper;
using Generic.Interface;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Text;
using static Dapper.SqlMapper;

namespace Generally
{
    public class MsDBConn : IMsDBConn, IDisposable
    {
        IConfiguration _config;
        IDbConnection _conn;
        IDbTransaction _tran;

        public IDbConnection Connection
        {
            get { return _conn; }
        }

        public IDbTransaction Transcation
        {
            get { return _tran; }
        }
        const char dbParamPrefix = '@';
        public MsDBConn(IConfiguration config)
        {
            _config = config;
            _conn = new SqlConnection(_config.GetConnectionString("DefConnectionStr"));
            if (_conn.State != ConnectionState.Open)
                _conn.Open();

            if (_tran == null)
                _tran = _conn.BeginTransaction();
        }

        public int Add<T>(T data)
        {
            int num = _conn.Execute(this.CreateInsertSql<T>(), data, _tran);
            return num;
        }

        public int Update<T>(string[] setColumns, T setValues, string[] conditionColumns = null, T conditionValues = default(T))
        {
            int index = 0;
            if (setColumns != null || setColumns.Length <= 0) return 0;

            if (setValues == null)
            {
                // "更新欄位為空，無法更新資料";
                return 0;
            }
            Dictionary<string, object> setValueDictionary =
                setValues.GetType().GetProperties(System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Public)
                .ToDictionary(prop => prop.Name, prop => prop.GetValue(setValues, null));
            if (setColumns.Except(setValueDictionary.Keys).Any())
            {
                //"更新欄位無法對應更新資料"
                return 0;
            }
            if ((conditionColumns == null && conditionValues != null) || (conditionColumns != null && conditionValues == null))
            {
                //"條件欄位無法對應條件資料"
                return 0;
            }
            Dictionary<string, object> conditionValueDictionary =
                conditionValues.GetType().GetProperties(System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Public)
                .ToDictionary(prop => prop.Name, prop => prop.GetValue(conditionValues, null));

            if (conditionColumns.Except(conditionValueDictionary.Keys).Any())
            {
                //"查詢條件欄位無法對應資料欄位"
                return 0;
            }

            T[] paramsArray = { setValues, conditionValues };
            index = this._conn.Execute(CreateUpdateSql<T>(setColumns, conditionColumns), paramsArray, this._tran);

            return index;
        }

        public int Delete<T>(T data)
        {
            return this._conn.Execute(CreateDeleteSql<T>(), data, this._tran);
        }

        public IEnumerable<T> Query<T>(string sSqlCmd, IDynamicParameters param = null)
        {

            var result = _conn.Query<T>(sSqlCmd, param: param, transaction: _tran);
            return result;
        }

        public async Task<IEnumerable<T>> QueryAsync<T>(string sSqlCmd, IDynamicParameters param = null)
        {

            var result = await _conn.QueryAsync<T>(sSqlCmd, param: param, transaction: _tran);
            return result;
        }

        public int Excute(string sql, SqlMapper.IDynamicParameters param)
        {
            return _conn.Execute(sql, param, transaction: _tran);
        }

        private string CreateInsertSql<T>(List<string> NotMatchList = null)
        {
            var typeList = typeof(T).GetProperties();

            StringBuilder sbsql = new StringBuilder();
            sbsql.Append(string.Format(@$"Insert Into {typeof(T).Name}"));

            List<string> colList = new List<string>();
            List<string> valList = new List<string>();

            foreach (var item in typeList)
            {
                if (NotMatchList.Any(x => x == item.Name)) continue;
                colList.Add($@"[{item.Name}]");
                valList.Add(dbParamPrefix + item.Name);
            }
            sbsql.Append($@"({String.Join(",", colList.ToArray())})");
            sbsql.Append($@" values({String.Join(",", valList.ToArray())})");
            return sbsql.ToString();
        }

        private string CreateUpdateSql<T>(string[] setColumns, string[] coditionColumns)
        {
            if (setColumns != null || setColumns.Length <= 0) return "";
            string sSql = $@"UPDATE {typeof(T).Name} set ";
            List<string> setColList = new List<string>();

            foreach (var col in setColumns)
            {
                setColList.Add($@"[{col}]={dbParamPrefix + col}");
            }
            sSql += string.Join(",", setColList.ToArray());

            if (coditionColumns != null && coditionColumns.Length > 0)
            {

                sSql += " where ";
                List<string> coditionColList = new List<string>();
                foreach (var col in coditionColumns)
                {
                    coditionColList.Add($@"[{col}]={dbParamPrefix + col}");
                }
                sSql += string.Join(" and ", coditionColList.ToArray());
            }
            return sSql;
        }
        private string CreateDeleteSql<T>()
        {
            var typeList = typeof(T).GetProperties();
            string sSql = @$"delete from [{typeof(T).Name}]";

            List<string> colList = new List<string>();
            foreach (var item in typeList)
            {
                colList.Add(@$"[{item.Name}]= {dbParamPrefix + item.Name}");
            }
            sSql += @$" where " + string.Join(" and ", colList.ToArray());
            return sSql;
        }

        public void Commit()
        {
            try
            {
                _tran?.Commit();
                _conn.Close();
            }
            catch
            {
                Rollback();
                throw;
            }
            finally
            {
                _tran.Dispose();
                _tran = null;
            }
        }

        public void Rollback()
        {
            try
            {
                _tran?.Rollback();
            }
            finally
            {
                _tran?.Dispose();
                _tran = null;
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
                if (_tran != null)
                {
                    _tran.Dispose();
                    _tran = null;
                }
                if (_conn != null)
                {
                    _conn.Dispose();
                    _conn = null;
                }
            }
        }


    }
}