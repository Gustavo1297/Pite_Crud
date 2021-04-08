using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Backend_Universidad.Models
{
    public class Persona
    {

        public int Id => CvePersona;
        [Key]
        public int CvePersona { get; set; }
        public string nombre { get; set; }
        public string apellidoP { get; set; }
        public string apellidoM { get; set; }
        public string ciudad { get; set; }
        public string direccion { get; set; }
        public DateTime fechaNac { get; set; }
        public string sexo { get; set; }
        public string tipoP { get; set; }
       
    }
    public class PersonaPA
    {

        public int Id => CvePersona;
        [Key]
        public int CvePersona { get; set; }
        public string nombre { get; set; }
        public string apellidoP { get; set; }
        public string apellidoM { get; set; }
        public string ciudad { get; set; }
        public string direccion { get; set; }
        public DateTime fechaNac { get; set; }
        public string sexo { get; set; }
        public string tipoP { get; set; }
        public string DescripcionSexo { get; set; }
        public string Estatus { get; set; }



    }
}
