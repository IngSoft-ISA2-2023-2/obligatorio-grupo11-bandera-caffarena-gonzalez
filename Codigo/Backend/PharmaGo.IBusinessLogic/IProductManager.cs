using PharmaGo.Domain.Entities;
using PharmaGo.Domain.SearchCriterias;

namespace PharmaGo.IBusinessLogic
{
    public interface IProductManager
    {
        IEnumerable<Product> GetAll(ProductSearchCriteria productSearchCriteria);
        Product GetById(int id);
        Product Create(Product product, string token);
        Product Update(int id, Product product);
        void Delete(int id);
    }
}
