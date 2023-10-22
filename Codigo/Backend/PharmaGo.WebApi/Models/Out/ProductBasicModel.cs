using PharmaGo.Domain.Entities;

namespace PharmaGo.WebApi.Models.Out
{
    public class ProductBasicModel
    {
        public int Id { get; set; }
        public int Code { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public string Description { get; set; }
        public PharmacyBasicModel Pharmacy { get; set; }

        public ProductBasicModel(Product product)
        {
            Id = product.Id;
            Code = product.Code;
            Name = product.Name;
            Description = product.Description;
            Price = product.Price;
            Pharmacy = new PharmacyBasicModel(product.Pharmacy);
        }
    }
}
