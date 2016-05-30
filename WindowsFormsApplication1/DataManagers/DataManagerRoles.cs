﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MercadoEnvio.Entidades;
using MercadoEnvio.Helpers;

namespace MercadoEnvio.DataManagers
{
    public class DataManagerRoles
    {
        public static DataTable GetAllData()
        {
            DataBaseHelper db = null;
            db = new DataBaseHelper(ConfigurationManager.AppSettings["connectionString"]);
            
            using (db.Connection)
            {
                DataTable res = db.GetDataAsTable("SP_GetRoles");
                return res;
            }
        }

        public static List<Funcionalidad> GetAllFuncionalidades()
        {
            DataBaseHelper db = null;
            db = new DataBaseHelper(ConfigurationManager.AppSettings["connectionString"]);

            using (db.Connection)
            {
                DataTable resAux = db.GetDataAsTable("SP_GetFuncionalidades");
                List<Funcionalidad> listFuncionalidades = new List<Funcionalidad>();
                foreach (DataRow row in resAux.Rows)
                {
                    var funcionalidad = new Funcionalidad
                    {
                        Descripcion = Convert.ToString(row["Descripcion"]),
                        IdFuncionalidad = Convert.ToInt32(row["IdFuncionalidad"])
                    };
                    listFuncionalidades.Add(funcionalidad);
                }

                return listFuncionalidades;
            }
        }

        public static DataTable FindRoles(string filtroNombre, int filtroFuncionalidad, string filtroEstado)
        {
            DataBaseHelper db = null;
            db = new DataBaseHelper(ConfigurationManager.AppSettings["connectionString"]);

            SqlParameter nombreParameter;
            SqlParameter funcionalidadParameter;
            SqlParameter estadoParameter;
            List<SqlParameter> parameters = new List<SqlParameter>();

            nombreParameter = new SqlParameter("@FiltroNombre", SqlDbType.NVarChar);
            nombreParameter.Value = filtroNombre.Trim();

            funcionalidadParameter = new SqlParameter("@FiltroFuncionalidad", SqlDbType.Int);
            funcionalidadParameter.Value = filtroFuncionalidad;

            estadoParameter = new SqlParameter("@FiltroEstado", SqlDbType.NVarChar);
            estadoParameter.Value = filtroEstado;

            parameters.Add(nombreParameter);
            parameters.Add(funcionalidadParameter);
            parameters.Add(estadoParameter);

            using (db.Connection)
            {
                DataTable res = db.GetDataAsTable("SP_FindRoles", parameters);
                return res;
            }
        }
    }
}
