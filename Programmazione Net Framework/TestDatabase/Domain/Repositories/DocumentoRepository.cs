using System.Data;
using Domain.Domain;
using Domain.Services;
using RepoLibrary;

namespace Domain.Repositories;

public class DocumentoRepository : AbstractRepository<Documento>
{
    private readonly CausaliRepository _repoCausali;
    private readonly RepositoryOperatore _repoOperatore;
    private readonly ContestoDocumentoRepository _repoContesto;
    private readonly ContattiRepository _repoContatti;

    protected override string NomeTabella { get; } = "Documenti";
    protected override string InsertQuery { get; } = @"INSERT INTO Documenti (Oggetto, IdCausale, IdOperatore, IdContestoDocumento, Protocollo)
                                                        VALUES (@oggetto, @idCausale, @idOperatore, @idContestoDocumento, @prot); SELECT SCOPE_IDENTITY()";
    protected override string UpdateQuery { get; } = @"UPDATE Documenti
                                                        SET Oggetto = @oggetto,
                                                            IdCausale = @idCausale,
                                                            IdOperatore = @idOperatore,
                                                            IdContestoDocumento = @idContestoDocumento,
                                                            Protocollo = @prot
                                                         WHERE Id = @id";
    protected override string GetByIdQuery { get; } = @"SELECT * FROM Documenti WHERE Id = @id";

    public DocumentoRepository(CausaliRepository repoCausali, RepositoryOperatore repoOperatore, ContestoDocumentoRepository repoContesto, ContattiRepository repoContatti)
    {
        _repoCausali = repoCausali;
        _repoOperatore = repoOperatore;
        _repoContesto = repoContesto;
        _repoContatti = repoContatti;
    }

    protected override void LoadParams(Documento entity, IDbCommand cmd)
    {
        cmd.Parameters.Add(CreateParamter("@oggetto", entity.Oggetto));
        cmd.Parameters.Add(CreateParamter("@idCausale", entity.Causale.Id));
        cmd.Parameters.Add(CreateParamter("@idOperatore", entity.Operatore.Id));
        cmd.Parameters.Add(CreateParamter("@idContestoDocumento", entity.ContestoDocumento.Id));
        cmd.Parameters.Add(CreateParamter("@prot", entity.Protocollo));
    }

    protected override Documento Materialize(Dictionary<string, object> reader, IDbConnection connection)
    {
        var causale =
            _repoCausali.EseguiQueryEMaterializzaSingoloOggetto(Convert.ToInt64(reader["IdCausale"]), connection);
        var operatore =
            _repoOperatore.EseguiQueryEMaterializzaSingoloOggetto(Convert.ToInt64(reader["IdOperatore"]), connection);

        var contesto =
            _repoContesto.EseguiQueryEMaterializzaSingoloOggetto(Convert.ToInt64(reader["IdContestoDocumento"]),
                connection);

        var contatti = MaterializzaContatti(Convert.ToInt64(reader["Id"]), connection);
        
        
        Documento p = new Documento()
        {
            Id = Convert.ToInt64(reader["Id"]),
            Oggetto = reader["Oggetto"].ToString(),
            Causale = causale,
            Operatore = operatore,
            ContestoDocumento = contesto,
            Contatti = contatti,
            Protocollo = reader["Protocollo"] as string
        };
        return p;
    }

    private List<Contatto> MaterializzaContatti(long idDocumento, IDbConnection connection)
    {
        return _repoContatti.ExecuteQueryAndMaterialize(connection, $@"SELECT Contatti.*
                                                FROM Contatti JOIN DocumentiPerContatto ON Contatti.Id = DocumentiPerContatto.IdContatto
                                                WHERE IdDocumento = {idDocumento}", new IDbDataParameter[0]);
    }
}
