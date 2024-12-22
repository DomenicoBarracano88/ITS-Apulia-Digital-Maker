
using Domain.Domain;

namespace DocumentiWebApi.Dtos;

public class DocumentoDto
{
    public string Oggetto { get; set; }
    public Causale Causale { get; set; }
    public ContestoDocumento ContestoDocumento { get; set; }
    public Operatore Operatore { get; set; }
    public List<Contatto> Contatti { get; set; }

    public string Protocollo => _protocollo;

    private string _protocollo;
}