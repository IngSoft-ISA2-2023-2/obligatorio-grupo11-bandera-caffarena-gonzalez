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
    public class GetProductByIdStepDefinitions
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
        private Pharmacy pharmacy = new Pharmacy() { Name = "pharmacy", Address = "address", Users = new List<User>() };

        private Product product = new Product()
        {
            Code = 12345,
            Name = "Shampoo",
            Description = "desc",
            Price = 100,
            Deleted = false,
        };

        int id1 = 0;
        int id2 = 0;

        Product product1;
        Product product2;

        private Exception? err;

        [Given(@"un producto de id (.*)")]
        public void GivenUnProductoDeId(int p0)
        {
            product.Id = p0;
        }

        [Given(@"se ingresa el id (.*)")]
        public void GivenSeIngresaElId(int p0)
        {
            id1 = p0;
        }

        [When(@"hago la peticion")]
        public void WhenHagoLaPeticion()
        {
            _productRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Product, bool>>>())).Returns(product);

            product1 = _productManager.GetById(id1);
        }

        [Then(@"obtengo el producto")]
        public void ThenObtengoElProducto()
        {
            product1.Should().NotBeNull();
            product1.Should().BeEquivalentTo(product);
        }

        [Given(@"un id de producto (.*) que no existe")]
        public void GivenUnIdDeProductoQueNoExiste(int p0)
        {
            id2 = p0;
        }

        [When(@"quiero ver el producto")]
        public void WhenQuieroVerElProducto()
        {
            Product nullProduct = null;
            _productRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Product, bool>>>())).Returns(nullProduct);

            try
            {
                product2 = _productManager.GetById(id2);
            }
            catch (Exception e)
            {
                err = e;
            }
        }

        [Then(@"no obtengo nada y aparece un error")]
        public void ThenNoObtengoNadaYApareceUnError()
        {
            product1.Should().BeNull();
            product1.Should().NotBeEquivalentTo(product);
            err.Should().NotBeNull();
            Assert.IsType<ResourceNotFoundException>(err);
        }
    }
}
