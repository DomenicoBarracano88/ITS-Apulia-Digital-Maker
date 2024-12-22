using System.Data;
using Domain.Domain;
using RepoLibrary;

namespace Domain.Repositories;

public class ContestoDocumentoRepository : AbstractRepository<ContestoDocumento>
{
    protected override string GetByIdQuery { get; } = @"select Id, Descrizione, CodiceProtocollo, Responsabile, CodiceProtocolloResponsabile from ContestoDocumento where Id = @id";
    protected override string NomeTabella { get; } = "ContestoDocumento";
    protected override string InsertQuery { get; } = @"INSERT INTO ContestoDocumento
           (Descrizione, CodiceProtocollo, Responsabile, CodiceProtocolloResponsabile)
           VALUES (@desc, @cod, @responsabile, @codiceProtocolloResponsabile); SELECT SCOPE_IDENTITY()";
    protected override string UpdateQuery { get; } = @"UPDATE ContestoDocumento 
           SET Descrizione = @desc, 
               CodiceProtocollo = @cod, 
               Responsabile = @responsabile, 
               CodiceProtocolloResponsabile = @codiceProtocolloResponsabile 
           WHERE Id = @id";

    protected override void LoadParams(ContestoDocumento entity, IDbCommand cmd)
    {
        cmd.Parameters.Add(CreateParamter("@desc", entity.Descrizione));
        cmd.Parameters.Add(CreateParamter("@cod", entity.CodiceProtocollo));
        cmd.Parameters.Add(CreateParamter("@responsabile", entity.Responsabile));
        cmd.Parameters.Add(CreateParamter("@codiceProtocolloResponsabile", entity.CodiceProtocolloResponsabile));
    }

    protected override ContestoDocumento Materialize(Dictionary<string, object> reader, IDbConnection connection)
    {
        ContestoDocumento p = new ContestoDocumento()
        {
            Id = Convert.ToInt64(reader["Id"]),
            Descrizione = reader["Descrizione"].ToString(),
            CodiceProtocollo = reader["CodiceProtocollo"].ToString(),
            Responsabile = reader["Responsabile"].ToString(),
            CodiceProtocolloResponsabile = reader["CodiceProtocolloResponsabile"].ToString()
        };
        return p;
    }
}
