using Domain.Domain;
using Domain.Repositories;

namespace Domain.Services;

public class DocumentiService
{
    private readonly DocumentoRepository _documentoRepository;
    private readonly ContatoreRepository _contatoreRepository;
    private readonly ContatoreService _contatoreService;
    private object _locker = new object();

    public DocumentiService(DocumentoRepository documentoRepository,
        ContatoreRepository contatoreRepository,
        ContatoreService contatoreService)
    {
        _documentoRepository = documentoRepository;
        _contatoreRepository = contatoreRepository;
        _contatoreService = contatoreService;
    }


    public string RichiediProtocollazione(long idDocumento)
    {
        Documento d = _documentoRepository.GetById(idDocumento);
        int numProgr = _contatoreService.CalcolaProgressivoSuccessivo(_contatoreRepository);
        d.ApponiProtocollo(numProgr);
        _documentoRepository.Update(d);
        
        return d.Protocollo;
    }
    
    
    
    public void DeleteDocumento(long id)
    {
        try
        {
            var documento = _documentoRepository.GetById(id);
            if (documento == null)
            {
                throw new ArgumentException($"Documento con ID {id} non trovato.");
            }

            if (documento.Protocollo != null)
            {
                throw new InvalidOperationException("Non puoi cancellare il documento perché è già stato protocollato.");
            }

            _documentoRepository.Delete(id);
        }
        catch (Exception e)
        {
            throw new Exception("Errore!! Problema con l'eliminazione del documento.", e);
        }
    }
    
}