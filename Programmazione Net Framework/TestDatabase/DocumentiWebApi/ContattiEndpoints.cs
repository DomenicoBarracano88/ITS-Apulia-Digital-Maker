using AutoMapper;
using DocumentiWebApi.Dtos;
using Domain.Domain;
using Domain.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace DocumentiWebApi;

public class ContattiEndpoints
{
    public static void AggiungiEndpoints(WebApplication app)
    {
        app.MapGet("/contatti", ([FromServices]ContattiRepository repo,
            [FromServices] IMapper mapper) =>
            {
                return mapper.Map<List<ContattoDto>>(repo.FindAll() as List<Contatto>);
            })
            .WithOpenApi();
        
        app.MapGet("/contatti/{id}", ([FromServices]ContattiRepository repo,
                [FromServices] IMapper mapper, [FromRoute] long id) =>
            {
                return mapper.Map<ContattoDto>(repo.GetById(id));
            })
            .WithOpenApi();

        app.MapPost("/contatti", ([FromBody] ContattoDto dto,
            [FromServices] ContattiRepository repo,
            [FromServices] IMapper mapper) =>
        {
              Contatto c = mapper.Map<Contatto>(dto);
              repo.Insert(c);
             return mapper.Map<ContattoDto>(c);
        })
            .WithOpenApi();  
        
        app.MapPut("/contatti/{id}", async ([FromServices] ContattiRepository repo,
                [FromServices] IMapper mapper,
                [FromRoute] long id,
                [FromBody] ContattoDto contattoDto) =>
            {
                var existingContatto = repo.GetById(id);
                if (existingContatto == null)
                {
                    return Results.NotFound();
                }
                mapper.Map(contattoDto, existingContatto);
                existingContatto.Id = id;
                repo.Update(existingContatto);
                return Results.NoContent();
            })
            .WithOpenApi();
        
        app.MapDelete("/contatti/{id}", ([FromServices] ContattiRepository repo, [FromRoute] long id, [FromServices] IMapper mapper) =>
            {
                var existingContatto = repo.GetById(id);
                repo.Delete(id);
                return mapper.Map<ContattoDto>(existingContatto);
            })
            .WithOpenApi();

    }
}
