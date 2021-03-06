﻿using System.Collections.Generic;
using MercadoEnvio.Entidades;

namespace MercadoEnvio.Servicios
{
    public class UsuariosService
    {
        public static Entidades.Login LoginUser(string userName, string password)
        {
            Entidades.Login login = DataManagers.DataManagerUsuario.Login(userName, password);
            return login;
        }

        public static List<Empresa> FindEmpresas(string filtroRazonSocial, string filtroCuit, string filtroEmail)
        {
            return DataManagers.DataManagerUsuario.FindEmpresas(filtroRazonSocial, filtroCuit, filtroEmail);
        }

        public static List<Cliente> FindClientes(string filtroNombre, string filtroApellido, string filtroDni, string filtroEmail)
        {
            return DataManagers.DataManagerUsuario.FindClientes(filtroNombre, filtroApellido, filtroDni, filtroEmail);
        }

        public static void SaveNewCliente(Cliente newCliente)
        {
            DataManagers.DataManagerUsuario.SaveNewCliente(newCliente);
        }

        public static void UpdateCliente(Cliente cliente)
        {
            DataManagers.DataManagerUsuario.UpdateCliente(cliente);
        }

        public static void SaveNewEmpresa(Empresa newEmpresa)
        {
            DataManagers.DataManagerUsuario.SaveNewEmpresa(newEmpresa);
        }

        public static void UpdateEmpresa(Empresa empresa)
        {
            DataManagers.DataManagerUsuario.UpdateEmpresa(empresa);
        }

        public static Cliente GetClienteByTipoDocNroDoc(string tipoDoc, string nroDoc)
        {
            return DataManagers.DataManagerUsuario.GetClienteByTipoDocNroDoc(tipoDoc, nroDoc);
        }

        public static Empresa GetEmpresaByRazonSocial(string razonSocial)
        {
            return DataManagers.DataManagerUsuario.GetEmpresaByRazonSocial(razonSocial);
        }

        public static Empresa GetEmpresaByCuit(string cuit)
        {
            return DataManagers.DataManagerUsuario.GetEmpresaByCuit(cuit);
        }

        public static void DeleteUsuario(Usuario usuario)
        {
            DataManagers.DataManagerUsuario.DeleteUsuario(usuario);
        }

        public static Cliente GetClienteById(int idUsuario)
        {
            return DataManagers.DataManagerUsuario.GetClienteById(idUsuario);
        }

        public static Empresa GetEmpresaById(int idUsuario)
        {
            return DataManagers.DataManagerUsuario.GetEmpresaById(idUsuario);
        }
    }
}
