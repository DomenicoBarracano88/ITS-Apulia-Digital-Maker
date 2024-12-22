using AutoMapper;
using DocumentiWebApi.Dtos;
using Domain.Domain;

namespace DocumentiWebApi.Profiles;

public class ProfileData:Profile
{
    public ProfileData()
    {
        CreateMap<Causale, CausaleDto>();
        CreateMap<CausaleDto, Causale>();
        
        CreateMap<DocumentoDto, Documento>();
        CreateMap<Documento, DocumentoDto>(); 
        
        CreateMap<ContattoDto, Contatto>();
        CreateMap<Contatto, ContattoDto>(); 
        
        CreateMap<OperatoreDto, Operatore>();
        CreateMap<Operatore, OperatoreDto>(); 
        
        
    }
}