using AutoMapper;
using DocumentiWebApi.Dtos;
using Domain.Domain;
using Domain.Repositories;
using Domain.Services;
using Microsoft.AspNetCore.Mvc;

namespace DocumentiWebApi;

public class CausaliEndpoints
{
    public static void AggiungiEndpoints(WebApplication app)
    {
        app.MapGet("/causali", ([FromServices]CausaliRepository repo,
            [FromServices] IMapper mapper) =>
            {
                return mapper.Map<List<CausaleDto>>(repo.FindAll() as List<Causale>);
            })
            .WithOpenApi();
        
        app.MapGet("/causali/{id}", ([FromServices]CausaliRepository repo,
                [FromServices] IMapper mapper, [FromRoute] long id) =>
            {
                return mapper.Map<CausaleDto>(repo.GetById(id));
            })
            .WithOpenApi();

        app.MapPost("/causali", ([FromBody] CausaleDto dto,
            [FromServices] CausaliRepository repo,
            [FromServices] IMapper mapper) =>
        {
              Causale c = mapper.Map<Causale>(dto);
              repo.Insert(c);
             return mapper.Map<CausaleDto>(c);
        })
            .WithOpenApi();  
        
        app.MapPut("/causali/{id}", async ([FromServices] CausaliRepository repo,
                [FromServices] IMapper mapper,
                [FromRoute] long id,
                [FromBody] CausaleDto causaleDto) =>
            {
                var existingCausale = repo.GetById(id);
                if (existingCausale == null)
                {
                    return Results.NotFound();
                }
                mapper.Map(causaleDto, existingCausale);
                existingCausale.Id = id;
                repo.Update(existingCausale);
                return Results.NoContent();
            })
            .WithOpenApi();
        
        app.MapDelete("/causali/{id}", ([FromServices] CausaliRepository repo, [FromServices] CausaleService causaleService, [FromRoute] long id, [FromServices] IMapper mapper) =>
            {
                var existingCausale = repo.GetById(id);
                causaleService.DeleteCausale(id);
                return mapper.Map<CausaleDto>(existingCausale);
            })
            .WithOpenApi();

    }
}