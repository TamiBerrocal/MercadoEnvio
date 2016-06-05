﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MercadoEnvio.Entidades;
using MercadoEnvio.Helpers;
using System.Configuration;
using System.Data;

namespace MercadoEnvio.DataManagers
{
    public class DataManagerPublicaciones
    {
        public static List<Publicacion> GetAllData()
        {
            DataBaseHelper db = null;
            db = new DataBaseHelper(ConfigurationManager.AppSettings["connectionString"]);

            using (db.Connection)
            {
                DataTable res = db.GetDataAsTable("SP_GetPublicaciones");
                List<Publicacion> listPublicaciones = new List<Publicacion>();
                foreach (DataRow row in res.Rows)
                {
                    var publicacion = new Publicacion
                    {
                        IdPublicacion = Convert.ToInt32(row["IdPublicacion"]),
                        CodigoPublicacion = Convert.ToInt32(row["CodigoPublicacion"]),
                        Descripcion = Convert.ToString(row["Descripcion"]),
                        Stock = Convert.ToInt32(row["Stock"]),
                        FechaInicio = Convert.ToDateTime(row["FechaInicio"]),
                        FechaVencimiento = Convert.ToDateTime(row["FechaVencimiento"]),
                        Precio = Convert.ToDecimal(row["Precio"]),
                        IdRubro = Convert.ToInt32(row["IdRubro"]),
                        IdUsuario = Convert.ToInt32(row["IdUsuario"]),
                        IdEstado = Convert.ToInt32(row["IdEstado"]),
                        IdTipo = Convert.ToInt32(row["IdTipo"]),
                    };

                    listPublicaciones.Add(publicacion);
                }

                return listPublicaciones;
            }
        }
    }
}