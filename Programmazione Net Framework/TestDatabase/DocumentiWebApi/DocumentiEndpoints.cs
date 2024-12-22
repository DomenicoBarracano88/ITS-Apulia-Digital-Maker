using AutoMapper;
using DocumentiWebApi.Dtos;
using Domain.Domain;
using Domain.Repositories;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using Domain.Services;

namespace DocumentiWebApi
{
    public class DocumentiEndpoints
    {
        public static void AggiungiEndpoints(WebApplication app)
        {
            app.MapGet("/documenti", ([FromServices]DocumentoRepository repo,
                [FromServices] IMapper mapper) =>
            {
                return mapper.Map<List<DocumentoDto>>(repo.FindAll());
            })
            .WithOpenApi();

            app.MapGet("/documenti/{id}", ([FromServices]DocumentoRepository repo,
                    [FromServices] IMapper mapper, [FromRoute] long id) =>
                {
                    var documento = repo.GetById(id);
                    return mapper.Map<DocumentoDto>(documento);
                })
                .WithOpenApi();

            app.MapPost("/documenti", ([FromBody] DocumentoDto dto,
                [FromServices] DocumentoRepository repo, 
                    [FromServices] DocumentiService DocumentiService,
                [FromServices] IMapper mapper) =>
            {
                Documento documento = mapper.Map<Documento>(dto);
                
                repo.Insert(documento);
                return mapper.Map<DocumentoDto>(documento);
            })
            .WithOpenApi();

            app.MapPut("/documenti/{id}",  ([FromServices] DocumentoRepository repo,
                    [FromServices] IMapper mapper,
                    [FromRoute] long id,
                    [FromBody] DocumentoDto documentoDto) =>
                {
                    var existingDocumento = repo.GetById(id);
                    if (existingDocumento == null)
                    {
                        return Results.NotFound();
                    }
                    mapper.Map(documentoDto, existingDocumento);
                    existingDocumento.Id = id;
                    repo.Update(existingDocumento);
                    return Results.NoContent();
                })
                .WithOpenApi();

            app.MapDelete("/documenti/{id}", ([FromServices] DocumentoRepository repo,
                    [FromServices] DocumentiService documentiService,
                    [FromRoute] long id, [FromServices] IMapper mapper) =>
                {
                    var existingDocumento = repo.GetById(id);
                    documentiService.DeleteDocumento(id);
                    return mapper.Map<DocumentoDto>(existingDocumento);
                })
                .WithOpenApi();
            
            
            app.MapPut("/documenti/{idDocumento}/protocollo", ([FromRoute] long idDocumento,
                    [FromServices] DocumentiService documentiService, [FromServices] IMapper mapper
                ) =>
                {
                    
                    
                    var protocollo = documentiService.RichiediProtocollazione(idDocumento);
                    
                    return protocollo;
                })
                .WithOpenApi();
            
            
        }

        }
    }
