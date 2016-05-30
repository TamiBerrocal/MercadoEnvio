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
        public static List<Rol> GetAllData()
        {
            DataBaseHelper db = null;
            db = new DataBaseHelper(ConfigurationManager.AppSettings["connectionString"]);
            
            using (db.Connection)
            {
                DataTable res = db.GetDataAsTable("SP_GetRoles");
                List<Rol> listRoles = new List<Rol>();
                foreach (DataRow row in res.Rows)
                {
                    var rol = new Rol
                    {
                        Descripcion = Convert.ToString(row["Descripcion"]),
                        Estado = Convert.ToString(row["Estado"]),
                        IdRol = Convert.ToInt32(row["IdRol"]),
                    };
                    listRoles.Add(rol);
                }
                //return res;
                return listRoles;
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

        public static List<Rol> FindRoles(string filtroNombre, int filtroFuncionalidad, string filtroEstado)
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
                List<Rol> roles = new List<Rol>();
                foreach (DataRow row in res.Rows)
                {
                    var rol = new Rol
                    {
                        IdRol = Convert.ToInt32(row["IdRol"]),
                        Descripcion = Convert.ToString(row["Descripcion"]),
                        Estado = Convert.ToString(row["Estado"]),
                    };

                    roles.Add(rol);
                }

                return roles;
            }
        }
    }
}
