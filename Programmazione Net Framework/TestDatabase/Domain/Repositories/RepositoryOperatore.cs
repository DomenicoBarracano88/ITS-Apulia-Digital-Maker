using System.Data;
using Domain.Domain;
using RepoLibrary;

namespace Domain.Repositories;

public class RepositoryOperatore : AbstractRepository<Operatore>
{
    protected override string GetByIdQuery { get; } = @"select Id, Descrizione, CodiceProtocollo from Operatori where Id = @id";
    protected override string NomeTabella { get; } = "Operatori";
    protected override string InsertQuery { get; } = @"INSERT INTO Operatori
           (Descrizione, CodiceProtocollo)
           VALUES (@desc, @cod); SELECT SCOPE_IDENTITY()";
    protected override string UpdateQuery { get; } = @"UPDATE Operatori 
           SET Descrizione = @desc, 
               CodiceProtocollo = @cod 
           WHERE Id = @id";

    protected override void LoadParams(Operatore entity, IDbCommand cmd)
    {
        cmd.Parameters.Add(CreateParamter("@desc", entity.Descrizione));
        cmd.Parameters.Add(CreateParamter("@cod", entity.CodiceProtocollo));
    }

    protected override Operatore Materialize(Dictionary<string, object> reader, IDbConnection connection)
    {
        Operatore p = new Operatore()
        {
            Id = Convert.ToInt64(reader["Id"]),
            Descrizione = reader["Descrizione"].ToString(),
            CodiceProtocollo = reader["CodiceProtocollo"].ToString()
        };
        return p;
    }
}