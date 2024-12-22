using AutoMapper;
using DocumentiWebApi.Dtos;
using Domain.Domain;
using Domain.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace DocumentiWebApi;

public class OperatoriEndpoints
{
    public static void AggiungiEndpoints(WebApplication app)
    {
        app.MapGet("/operatori", ([FromServices]RepositoryOperatore repo,
            [FromServices] IMapper mapper) =>
            {
                return mapper.Map<List<OperatoreDto>>(repo.FindAll() as List<Operatore>);
            })
            .WithOpenApi();
        
        app.MapGet("/operatori/{id}", ([FromServices]RepositoryOperatore repo,
                [FromServices] IMapper mapper, [FromRoute] long id) =>
            {
                return mapper.Map<OperatoreDto>(repo.GetById(id));
            })
            .WithOpenApi();

        app.MapPost("/operatori", ([FromBody] OperatoreDto dto,
            [FromServices] RepositoryOperatore repo,
            [FromServices] IMapper mapper) =>
        {
              Operatore o = mapper.Map<Operatore>(dto);
              repo.Insert(o);
             return mapper.Map<OperatoreDto>(o);
        })
            .WithOpenApi();  
        
        app.MapPut("/operatori/{id}", async ([FromServices] RepositoryOperatore repo,
                [FromServices] IMapper mapper,
                [FromRoute] long id,
                [FromBody] OperatoreDto operatoreDto) =>
            {
                var existingOperatore = repo.GetById(id);
                if (existingOperatore == null)
                {
                    return Results.NotFound();
                }
                mapper.Map(operatoreDto, existingOperatore);
                existingOperatore.Id = id;
                repo.Update(existingOperatore);
                return Results.NoContent();
            })
            .WithOpenApi();
        
        app.MapDelete("/operatori/{id}", ([FromServices] RepositoryOperatore repo, [FromRoute] long id, [FromServices] IMapper mapper) =>
            {
                var existingOperatore = repo.GetById(id);
                repo.Delete(id);
                return mapper.Map<OperatoreDto>(existingOperatore);
            })
            .WithOpenApi();

    }
}
