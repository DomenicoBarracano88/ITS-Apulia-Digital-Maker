

using Domain.Repositories;

namespace Domain.Services
{
    public class CausaleService
    {
        private readonly CausaliRepository _causaleRepository;
        private readonly DocumentoRepository _documentoRepository;

        public CausaleService(CausaliRepository causaleRepository, DocumentoRepository documentoRepository)
        {
            _causaleRepository = causaleRepository;
            _documentoRepository = documentoRepository;
        }


        public void DeleteCausale(long id)
        {
            try
            {
                var causale = _causaleRepository.GetById(id);
                if (causale == null)
                {
                    throw new ArgumentException($"Causale con ID {id} non trovata.");
                }

                
                var docUtilizzati = _documentoRepository.FindAll().Any(d => d.Causale.Id == id);
                if (docUtilizzati)
                {
                    throw new InvalidOperationException("Non puoi cancellare la causale perché è utilizzata in almeno un documento.");
                }
                
                _causaleRepository.Delete(id);
            }
            catch (Exception e)
            {
                throw new Exception("Errore!! Problema con l'eliminazione della causale.", e);
            }
        }

    }
}
