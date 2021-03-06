﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using MercadoEnvio.Entidades;
using MercadoEnvio.Properties;
using MercadoEnvio.Servicios;
using System.ComponentModel;
using System.Xml.Serialization;
using MercadoEnvio.Helpers;

namespace MercadoEnvio.ABM_Usuario
{
    public partial class AltaUsuario : Form
    {
        #region properties
        public Usuario Usuario { get; set; }
        #endregion

        public AltaUsuario(Usuario usuario)
        {
            InitializeComponent();

            Usuario = usuario;

            #region armadoDeGrillaRoles
            BindingList<Rol> dataSource = new BindingList<Rol>(usuario.Roles);
            BindingSource bs = new BindingSource();
            bs.DataSource = dataSource;

            DgRoles.AutoGenerateColumns = false;
            DgRoles.Columns.Add(new DataGridViewTextBoxColumn { DataPropertyName = "Descripcion", HeaderText = Resources.Descripcion, Name = "Descripcion" });
            DgRoles.Columns.Add(new DataGridViewTextBoxColumn { DataPropertyName = "Estado", HeaderText = Resources.Estado, Name = "Estado" });

            DgRoles.DataSource = bs;
            #endregion

            #region armadoComboEstado
            Estado estadoHabilitado = new Estado { Valor = true };
            Estado estadoDeshabilitado = new Estado { Valor = false };
            List<Estado> estados = new List<Estado>();
            estados.Add(estadoHabilitado);
            estados.Add(estadoDeshabilitado);

            ComboEstado.DataSource = estados;
            ComboEstado.DisplayMember = "Descripcion";
            ComboEstado.DropDownStyle = ComboBoxStyle.DropDownList;

            if (Usuario.IdUsuario != 0)
                ComboEstado.SelectedIndex = ComboEstado.FindStringExact(usuario.Estado);
            #endregion
        }

        private void AltaUsuario_Load(object sender, EventArgs e)
        {
            #region armadoComboRol
            List<Rol> roles = new List<Rol>(RolesServices.GetAllData());
            roles = roles.FindAll(x => x.Descripcion.Equals(Resources.Cliente, StringComparison.CurrentCultureIgnoreCase)
                                    || x.Descripcion.Equals(Resources.Empresa, StringComparison.CurrentCultureIgnoreCase));

            ComboTipoDeUsuario.DataSource = roles;
            ComboTipoDeUsuario.DisplayMember = "Descripcion";
            ComboTipoDeUsuario.DropDownStyle = ComboBoxStyle.DropDownList;

            if (Usuario.Roles.Count > 0)
            {
                Rol rolAux = new Rol();
                rolAux = Usuario.Roles.First(x => x.Descripcion.Equals("Cliente", StringComparison.CurrentCultureIgnoreCase) || x.Descripcion.Equals("Empresa", StringComparison.CurrentCultureIgnoreCase));
                ReorganizarPantallaDeAcuerdoARol(rolAux);
                ComboTipoDeUsuario.SelectedIndex = ComboTipoDeUsuario.FindStringExact(rolAux.Descripcion);
            }
                

            if (Usuario.IdUsuario != 0)
                ComboTipoDeUsuario.Enabled = false;
            #endregion

            #region armadoComboRolGrilla
            List<Rol> rolesGrilla = new List<Rol>(RolesServices.GetAllData());
            rolesGrilla = rolesGrilla.FindAll(x => !x.Descripcion.Equals(Resources.Administrativo, StringComparison.CurrentCultureIgnoreCase)
                                                && !x.Descripcion.Equals(Resources.Cliente, StringComparison.CurrentCultureIgnoreCase)
                                                && !x.Descripcion.Equals(Resources.Empresa, StringComparison.CurrentCultureIgnoreCase));

            ComboRol.DataSource = rolesGrilla;
            ComboRol.DisplayMember = "Descripcion";
            ComboRol.DropDownStyle = ComboBoxStyle.DropDownList;
            #endregion
        }

        private void ComboTipoDeUsuario_SelectionChangeCommitted(object sender, EventArgs e)
        {
            Rol rolSeleccionado = ((Rol)ComboTipoDeUsuario.SelectedItem);
            ReorganizarPantallaDeAcuerdoARol(rolSeleccionado);
        }

        private void ReorganizarPantallaDeAcuerdoARol(Rol rol)
        {
            if (rol.Descripcion.Equals(Resources.Empresa, StringComparison.CurrentCultureIgnoreCase))
            {
                LabelNombre.Text = Resources.RazonSocial;
                LabelDNI.Text = Resources.CUIT;
                LabelApellido.Text = Resources.Rubro;

                Empresa emp = new Empresa();
                emp = UsuariosService.GetEmpresaById(Usuario.IdUsuario);
                TxtNombre.Text = emp.RazonSocial;
                TxtUserName.Text = emp.UserName;
                TxtPassword.Text = emp.Password;
                TxtCalle.Text = emp.Calle;
                TxtNumero.Text = emp.NroCalle.ToString();
                TxtPiso.Text = emp.Piso.ToString();
                TxtDepto.Text = emp.Departamento;
                TxtEmail.Text = emp.Email;
                TxtTelefono.Text = emp.Telefono;
                TxtContacto.Text = emp.Contacto;
                TxtCp.Text = emp.CodigoPostal;
                TxtLocalidad.Text = emp.Localidad;
                TxtCiudad.Text = emp.Ciudad;
                TxtApellido.Text = emp.Rubro;

                TxtDNI.Visible = false;
                TxtCuit.Visible = true;
                TxtCuit.Text = emp.Cuit;
                LabelContacto.Visible = true;
                TxtContacto.Visible = true;
                TxtContacto.Text = emp.Contacto;
                LabelFechaNacimiento.Visible = false;
                DatePickerFechaNacimiento.Visible = false;
                TxtTipoDoc.Enabled = false;
                TxtCiudad.Visible = true;
                TxtCiudad.Text = emp.Ciudad;
                LabelCiudad.Visible = true;
            }
            else
            {
                LabelNombre.Text = Resources.Nombre;
                LabelDNI.Text = Resources.NoDoc;
                LabelApellido.Text = Resources.Apellido;

                Cliente cli = new Cliente();
                cli = UsuariosService.GetClienteById(Usuario.IdUsuario);
                TxtNombre.Text = cli.Nombre;
                TxtUserName.Text = cli.UserName;
                TxtPassword.Text = cli.Password;
                TxtCalle.Text = cli.Calle;
                TxtNumero.Text = cli.NroCalle.ToString();
                TxtPiso.Text = cli.Piso.ToString();
                TxtDepto.Text = cli.Departamento;
                TxtEmail.Text = cli.Email;
                TxtTelefono.Text = cli.Telefono;
                TxtCp.Text = cli.CodigoPostal;
                TxtLocalidad.Text = cli.Localidad;
                TxtLocalidad.Visible = true;
                TxtApellido.Visible = true;
                TxtApellido.Text = cli.Apellido;
                TxtDNI.Visible = true;
                TxtDNI.Text = cli.NumeroDoc.ToString();
                TxtCuit.Visible = false;
                LabelContacto.Visible = false;
                TxtContacto.Visible = false;
                LabelFechaNacimiento.Visible = true;
                DatePickerFechaNacimiento.Visible = true;
                DatePickerFechaNacimiento.Value = cli.IdUsuario != 0 ? cli.FechaNacimiento : new FechaHelper().GetSystemDate();
                TxtTipoDoc.Enabled = true;
                TxtTipoDoc.Text = cli.TipoDoc;
                TxtCiudad.Visible = false;
                LabelCiudad.Visible = false;
            }
        }

        private void LimpiarCampos()
        {
            TxtNombre.Text = string.Empty;
            TxtApellido.Text = string.Empty;
            TxtTipoDoc.Text = string.Empty;
            TxtDNI.Text = string.Empty;
            TxtCp.Text = string.Empty;
            TxtCuit.Text = string.Empty;
            TxtDepto.Text = string.Empty;
            TxtPiso.Text = string.Empty;
            TxtNumero.Text = string.Empty;
            TxtLocalidad.Text = string.Empty;
            TxtCiudad.Text = string.Empty;
            TxtContacto.Text = string.Empty;
            TxtEmail.Text = string.Empty;
            TxtTelefono.Text = string.Empty;
            TxtCalle.Text = string.Empty;
        }

        private void TxtDNI_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {
                e.Handled = true;
            }
        }

        private void BtnSeleccionar_Click(object sender, EventArgs e)
        {
            SeleccionarRol(ComboRol);
        }

        private void SeleccionarRol(ComboBox combo)
        {
            Rol rolSeleccionado = (Rol)combo.SelectedItem;

            BindingSource bs = DgRoles.DataSource as BindingSource;
            if (bs != null)
            {
                bool canAdd =
                    bs.List.Cast<Rol>().All(rol => rol.IdRol != rolSeleccionado.IdRol);

                if (canAdd)
                    bs.Add(rolSeleccionado);
                else
                    MessageBox.Show(Resources.ErrorAgregarRol, Resources.Advertencia, MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void BtnQuitar_Click(object sender, EventArgs e)
        {
            if (DgRoles.SelectedRows.Count > 0)
            {
                BindingSource bs = DgRoles.DataSource as BindingSource;
                if (bs != null)
                {
                    if (((Rol)bs[DgRoles.SelectedRows[0].Index]).IsClienteOEmpresa())
                        MessageBox.Show(Resources.ErrorUsuarioRol, Resources.Advertencia, MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    else
                        bs.RemoveAt(DgRoles.SelectedRows[0].Index);
                }
            }
        }

        private void BtnCancelar_Click(object sender, EventArgs e)
        {
            Close();
        }

        private List<string> ValidarDatosUsuario(Rol tipoUsuario)
        {
            List<string> errors = new List<string>();

            if (string.IsNullOrEmpty(TxtUserName.Text))
                errors.Add(Resources.ErrorUserName);

            if (string.IsNullOrEmpty(TxtPassword.Text))
                errors.Add(Resources.ErrorPassword);

            if (string.IsNullOrEmpty(TxtCp.Text))
                errors.Add(Resources.ErrorCp);

            if (string.IsNullOrEmpty(TxtCalle.Text))
                errors.Add(Resources.ErrorCalle);

            if (string.IsNullOrEmpty(TxtNumero.Text))
                errors.Add(Resources.ErrorNumeroCalle);

            if (string.IsNullOrEmpty(TxtEmail.Text))
                errors.Add(Resources.ErrorEmail);

            if (tipoUsuario.Descripcion.Equals(Resources.Cliente, StringComparison.CurrentCultureIgnoreCase))
            {
                ValidarDatosCliente(errors);
            }
            else
            {
                ValidarDatosEmpresa(errors);
            }

            return errors;
        }

        private void ValidarDatosCliente(List<string> errors)
        {
            if (DatePickerFechaNacimiento.Value.CompareTo(new FechaHelper().GetSystemDate()) >= 0)
                errors.Add(Resources.ErrorFechaNacimiento);

            if (string.IsNullOrEmpty(TxtNombre.Text))
                errors.Add(Resources.ErrorNombre);

            if (string.IsNullOrEmpty(TxtApellido.Text))
                errors.Add(Resources.ErrorApellido);

            if (string.IsNullOrEmpty(TxtDNI.Text))
                errors.Add(Resources.ErrorDNI);

            if (string.IsNullOrEmpty(TxtTipoDoc.Text))
                errors.Add(Resources.ErrorTipoDocumento1);
            else if (TxtTipoDoc.Text != Resources.DNI && TxtTipoDoc.Text != Resources.LE && TxtTipoDoc.Text != Resources.CUIL)
                errors.Add(Resources.ErrorTipoDocumento2);

            if (!string.IsNullOrEmpty(TxtDNI.Text) && !string.IsNullOrEmpty(TxtTipoDoc.Text))
            {
                Cliente cliente = UsuariosService.GetClienteByTipoDocNroDoc(TxtTipoDoc.Text, TxtDNI.Text);
                if (cliente.IdUsuario != 0)
                    if (cliente.IdUsuario != Usuario.IdUsuario)
                        errors.Add(Resources.ErrorClienteExistente);
            }
        }

        private void ValidarDatosEmpresa(List<string> errors)
        {
            if (string.IsNullOrEmpty(TxtNombre.Text))
                errors.Add(Resources.ErrorRazonSocial);
            else
            {
                Empresa empresa = UsuariosService.GetEmpresaByRazonSocial(TxtNombre.Text);
                if (empresa.IdUsuario != 0)
                    if (empresa.IdUsuario != Usuario.IdUsuario)
                        errors.Add(Resources.ErrorEmpresaExistenteRazonSocial);
            }

            if (string.IsNullOrEmpty(TxtCuit.Text))
                errors.Add(Resources.ErrorCuit);
            else
            {
                Empresa empresa = UsuariosService.GetEmpresaByCuit(TxtCuit.Text);
                if (empresa.IdUsuario != 0)
                    if (empresa.IdUsuario != Usuario.IdUsuario)
                        errors.Add(Resources.ErrorEmpresaExistenteCUIT);
            }
        }

        private List<Rol> GetRolesFromDg()
        {
            List<Rol> roles = new List<Rol>();

            BindingSource bs = DgRoles.DataSource as BindingSource;
            if (bs != null)
                foreach (Rol rol in bs.List)
                {
                    roles.Add(rol);
                }

            return roles;
        }

        private void BtnGuardar_Click(object sender, EventArgs e)
        {
            Rol rolSeleccionado = ((Rol)ComboTipoDeUsuario.SelectedItem);

            List<string> errors = new List<string>(ValidarDatosUsuario(rolSeleccionado));
            if (errors.Count > 0)
            {
                var message = string.Join(Environment.NewLine, errors);
                MessageBox.Show(message, Resources.ErrorGuardado, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else
            {
                if (rolSeleccionado.Descripcion.Equals(Resources.Cliente, StringComparison.CurrentCultureIgnoreCase))
                {
                    var usuario = new Cliente
                    {
                        Nombre = TxtNombre.Text.Trim(),
                        Apellido = TxtApellido.Text.Trim(),
                        Activo = ((Estado)ComboEstado.SelectedItem).Valor,
                        Calle = TxtCalle.Text.Trim(),
                        CodigoPostal = TxtCp.Text.Trim(),
                        Departamento = TxtDepto.Text.Trim(),
                        Email = TxtEmail.Text.Trim(),
                        FechaNacimiento = DatePickerFechaNacimiento.Value,
                        Piso = Convert.ToInt32(TxtPiso.Text.Trim()),
                        NroCalle = Convert.ToInt32(TxtNumero.Text.Trim()),
                        TipoDoc = TxtTipoDoc.Text.Trim(),
                        NumeroDoc = Convert.ToInt32(TxtDNI.Text.Trim()),
                        Localidad = TxtLocalidad.Text.Trim(),
                        Telefono = TxtTelefono.Text.Trim(),
                        Roles = GetRolesFromDg(),
                        UserName = TxtUserName.Text,
                        Password = TxtPassword.Text
                    };

                    if (Usuario.IdUsuario == 0)
                    {
                        UsuariosService.SaveNewCliente(usuario);
                        MessageBox.Show(Resources.UsuarioCreado, Resources.MercadoEnvio, MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    else
                    {
                        usuario.IdUsuario = Usuario.IdUsuario;
                        UsuariosService.UpdateCliente(usuario);
                        MessageBox.Show(Resources.UsuarioActualizado, Resources.MercadoEnvio, MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                }
                else
                {
                    var usuario = new Empresa
                    {
                        RazonSocial = TxtNombre.Text.Trim(),
                        Activo = ((Estado)ComboEstado.SelectedItem).Valor,
                        Calle = TxtCalle.Text.Trim(),
                        Ciudad = TxtCiudad.Text.Trim(),
                        CodigoPostal = TxtCp.Text.Trim(),
                        Contacto = TxtContacto.Text.Trim(),
                        Cuit = TxtCuit.Text.Trim(),
                        Departamento = TxtDepto.Text.Trim(),
                        Email = TxtEmail.Text.Trim(),
                        Rubro = TxtApellido.Text.Trim(),
                        Piso = Convert.ToInt32(TxtPiso.Text.Trim()),
                        NroCalle = Convert.ToInt32(TxtNumero.Text.Trim()),
                        Localidad = TxtLocalidad.Text.Trim(),
                        Telefono = TxtTelefono.Text.Trim(),
                        Roles = GetRolesFromDg(),
                        UserName = TxtUserName.Text,
                        Password = TxtPassword.Text
                    };

                    if (Usuario.IdUsuario == 0)
                    {
                        UsuariosService.SaveNewEmpresa(usuario);
                        MessageBox.Show(Resources.UsuarioCreado, Resources.MercadoEnvio, MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    else
                    {
                        usuario.IdUsuario = Usuario.IdUsuario;
                        UsuariosService.UpdateEmpresa(usuario);
                        MessageBox.Show(Resources.UsuarioActualizado, Resources.MercadoEnvio, MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                }
            }
        }
    }
}
