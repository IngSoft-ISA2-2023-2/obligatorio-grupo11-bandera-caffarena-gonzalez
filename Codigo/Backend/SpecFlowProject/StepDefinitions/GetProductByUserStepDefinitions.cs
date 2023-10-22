using Moq;
using PharmaGo.BusinessLogic;
using PharmaGo.DataAccess.Repositories;
using PharmaGo.Domain.Entities;
using PharmaGo.Domain.SearchCriterias;
using PharmaGo.IDataAccess;
using System;
using System.Linq.Expressions;
using TechTalk.SpecFlow;

namespace SpecFlowProject.StepDefinitions
{
    [Binding]
    public class GetProductByUserStepDefinitions
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
        private Session session;
        private User user;
        private Pharmacy pharmacy;
        private Product product = new Product()
        {
            Id = 1,
            Code = 12345,
            Name = "Shampoo",
            Description = "desc",
            Price = 100,
            Deleted = false,
        };

        IEnumerable<Product> productList1 = new List<Product>();

        [Given(@"un usuario")]
        public void GivenUnUsuario()
        {
            session = new Session { Id = 1, Token = new Guid(token), UserId = 1 };
            user = new User() { Id = 1, UserName = "test", Email = "test@gmail.com", Address = "test" };
            pharmacy = new Pharmacy() { Name = "pharmacy", Address = "address", Users = new List<User>() };
        }


        [When(@"hago la peticion para ver los productos de su farmacia")]
        public void WhenHagoLaPeticionParaVerLosProductosDeSuFarmacia()
        {   
            List<Product> returnProductList = new List<Product>();
            returnProductList.Add(product);

            _sessionRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Session, bool>>>())).Returns(session);
            _userRepository.Setup(r => r.GetOneDetailByExpression(It.IsAny<Expression<Func<User, bool>>>())).Returns(user);
            _productRepository.Setup(r => r.GetAllByExpression(It.IsAny<Expression<Func<Product, bool>>>())).Returns(returnProductList);

            productList1 = _productManager.GetAllByUser(token);
        }

        [Then(@"obtengo los productos")]
        public void ThenObtengoLosProductos()
        {
            productList1.Should().HaveCount(1);
        }
    }
}
