using Moq;
using PharmaGo.BusinessLogic;
using PharmaGo.Domain.Entities;
using PharmaGo.Domain.SearchCriterias;
using PharmaGo.Exceptions;
using PharmaGo.IDataAccess;
using System;
using System.Linq.Expressions;
using TechTalk.SpecFlow;

namespace SpecFlowProject.StepDefinitions
{
    [Binding]
    public class GetAllProductsStepDefinitions
    {
        private static Mock<IRepository<Product>> _productRepository = new Mock<IRepository<Product>>();
        private static Mock<IRepository<Pharmacy>> _pharmacyRepository = new Mock<IRepository<Pharmacy>>();
        private static Mock<IRepository<User>> _userRepository = new Mock<IRepository<User>>();
        private static Mock<IRepository<Session>> _sessionRepository = new Mock<IRepository<Session>>();

        private ProductManager _productManager = new ProductManager(_productRepository.Object,
                                                                    _pharmacyRepository.Object,
                                                                    _sessionRepository.Object,
                                                                    _userRepository.Object);

        private static string token = "c80da9ed-1b41-4768-8e34-b728cae25d2f";
        private Session session = new Session { Id = 1, Token = new Guid(token), UserId = 1 };
        private User user = new User() { Id = 1, UserName = "test", Email = "test@gmail.com", Address = "test" };
        private Pharmacy pharmacy = new Pharmacy() {Name = "pharmacy", Address = "address", Users = new List<User>() };

        private Product product = new Product()
        {
            Id = 1,
            Code = 12345,
            Name = "Shampoo",
            Description = "desc",
            Price = 100,
            Deleted = false,
        };

        IEnumerable<Product> productList1;

        private Exception? err;

        [Given(@"Una famacia de id (.*)")]
        public void GivenUnaFamaciaDeId(int p0)
        {
            pharmacy.Id = p0;
        }

        [Given(@"existe un producto en la base")]
        public void GivenExisteUnProductoEnLaBase()
        {
            product.Pharmacy = pharmacy;
        }

        [When(@"cargo la lista de productos")]
        public void WhenCargoLaListaDeProductos()
        {
            List<Product> productList = new List<Product>();
            productList.Add(product);
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Pharmacy, bool>>>())).Returns(pharmacy);
            _productRepository.Setup(r => r.GetAllByExpression(It.IsAny<Expression<Func<Product, bool>>>())).Returns(productList);

            productList1 = _productManager.GetAll(new ProductSearchCriteria() { PharmacyId = pharmacy.Id });
        }

        [Then(@"se cargan los productos correctamente")]
        public void ThenSeCarganLosProductosCorrectamente()
        {
            productList1.Should().HaveCount(1);
        }

        [Given(@"un id de farmacia (.*) que no existe")]
        public void GivenUnIdDeFarmaciaQueNoExiste(int p0)
        {
            pharmacy.Id = p0;
        }

        [When(@"quiero ver los prdocutos de la farmacia")]
        public void WhenQuieroVerLosPrdocutosDeLaFarmacia()
        {
            Pharmacy nullPharmacy = null;
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Pharmacy, bool>>>())).Returns(nullPharmacy);
            try
            {
                productList1 = _productManager.GetAll(new ProductSearchCriteria());
            }
            catch (Exception e)
            {
                err = e;
            }
        }

        [Then(@"no se cargan los productos y salta un error")]
        public void ThenNoSeCarganLosProductosYSaltaUnError()
        {
            productList1.Should().HaveCount(0);
            err.Should().NotBeNull();
            Assert.IsType<ResourceNotFoundException>(err);
        }
    }
}
