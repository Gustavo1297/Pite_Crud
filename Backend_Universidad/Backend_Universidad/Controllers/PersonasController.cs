using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Backend_Universidad.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Backend_Universidad.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PersonasController : ControllerBase
    {
        private readonly AplicationDbContext _context;
        public PersonasController(AplicationDbContext context) 
        {
            _context = context;
        }
        // GET: api/<PersonasController>
        [HttpGet("GetPersona")]
        public ActionResult<List<PersonaPA>> Get(int id)
        {
            try
            {
                var parametro = new SqlParameter("@CvePersona", id);
                var res = _context.PersonaPA.FromSqlRaw("Exec PA_PersonaGet @CvePersona", parametro).ToList();
                if (res.Count() >=1)
                {
                    return Ok(res);
                }
                else
                {
                    return BadRequest();
                }
            }
            catch (Exception ex)
            {

                return BadRequest(new { message = ex.ToString()});
            }
        }

        

        // POST api/<PersonasController>
        [HttpPost("AddPersona")]
        public ActionResult Post([FromBody] Persona persona)
        {
            try
            {
                var nombre = new SqlParameter("@nombre", persona.nombre);
                var apellidoP = new SqlParameter("@apellidoP", persona.apellidoP);
                var apellidoM = new SqlParameter("@apellidoM", persona.apellidoM);
                var ciudad = new SqlParameter("@ciudad", persona.ciudad);
                var direccion = new SqlParameter("@direccion", persona.direccion);
                var sexo = new SqlParameter("@sexo", persona.sexo);
                var tipoP = new SqlParameter("@tipoP", persona.tipoP);
                //Se inserta el registro mediante un Store procedure
                var insert = _context.Persona.FromSqlRaw("Exec PA_PersonaAdd @nombre,@apellidoP, @apellidoM, @ciudad, @direccion, @sexo, @tipoP",nombre, apellidoP, apellidoM, ciudad, direccion, sexo, tipoP);
                return Ok(insert);
            }
            catch (Exception ex)
            {

                return BadRequest(new { message = ex.ToString() });
            }
        }

        // PUT api/<PersonasController>/5
        [HttpPut("UpdatePersona")]
        public ActionResult Put([FromBody] Persona persona)
        {
            try
            {
                var Persona = _context.Persona.Find(persona.CvePersona);
                Console.WriteLine("CvePersona: "+Persona);
                if (Persona == null)
                {
                    return NotFound();
                }
                var CvePersona = new SqlParameter("@CvePersona", persona.CvePersona);
                var nombre = new SqlParameter("@nombre", persona.nombre);
                var apellidoP = new SqlParameter("@apellidoP", persona.apellidoP);
                var apellidoM = new SqlParameter("@apellidoM", persona.apellidoM);
                var ciudad = new SqlParameter("@ciudad", persona.ciudad);
                var direccion = new SqlParameter("@direccion", persona.direccion);
                var sexo = new SqlParameter("@sexo", persona.sexo);
                var tipoP = new SqlParameter("@tipoP", persona.tipoP);
                //Se inserta el registro mediante un Store procedure
                var insert = _context.Persona.FromSqlRaw("Exec PA_PersonaUpdate @CvePersona, @nombre,@apellidoP, @apellidoM, @ciudad, @direccion, @sexo, @tipoP", CvePersona, nombre, apellidoP, apellidoM, ciudad, direccion, sexo, tipoP);
                return Ok(insert);

            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.ToString() });
            }
        }

        // DELETE api/<PersonasController>/5
        [HttpDelete("DeletePersona")]
        public ActionResult DeletePersona(int id, string tipo)
        {
            try
            {
                var Persona =  _context.Persona.Find(id);
                if (Persona == null)
                {
                    return NotFound();
                }
                var CvePersona = new SqlParameter("@CvePersona", id);
                var TipoP = new SqlParameter("@TipoP", id);
                //Se elimina el registro mediante un Store procedure
                var delete = _context.Persona.FromSqlRaw("Exec PA_PersonaDelete @CvePersona", CvePersona);
                return Ok(delete);

            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.ToString() });
            }
        }
    }
}
