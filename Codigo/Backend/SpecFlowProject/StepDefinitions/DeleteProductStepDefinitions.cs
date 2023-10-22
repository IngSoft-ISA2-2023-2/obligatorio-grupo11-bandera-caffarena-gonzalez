using Moq;
using PharmaGo.BusinessLogic;
using PharmaGo.Domain.Entities;
using PharmaGo.Exceptions;
using PharmaGo.IDataAccess;
using System;
using System.Linq.Expressions;
using TechTalk.SpecFlow;

namespace SpecFlowProject.StepDefinitions
{
    [Binding]
    public class DeleteProductStepDefinitions
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
        private Pharmacy pharmacy = new Pharmacy() { Id = 1, Name = "pharmacy", Address = "address", Users = new List<User>() };

        private Product Product;

        private Product nullProduct = null;

        private int id1;
        private int id2;

        private Exception? err1;
        private Exception? err2;
        private Exception? err3;

        [Given(@"que se ingresa un producto de id (.*)")]
        public void GivenQueSeIngresaUnProductoDeId(int p0)
        {
            Product = new Product()
            {
                Id = p0,
                Code = 12345,
                Name = "Shampoo",
                Description = "desc",
                Price = 100,
                Deleted = false
            };

            Product.Pharmacy = pharmacy;

            _productRepository.Setup(r => r.Exists(It.IsAny<Expression<Func<Product, bool>>>())).Returns(false);
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Pharmacy, bool>>>())).Returns(pharmacy);
            _sessionRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Session, bool>>>())).Returns(session);
            _userRepository.Setup(r => r.GetOneDetailByExpression(It.IsAny<Expression<Func<User, bool>>>())).Returns(user);

            _productRepository.Setup(x => x.InsertOne(It.IsAny<Product>()));
            _productRepository.Setup(x => x.Save());

            _productManager.Create(Product, token);

        }

        [Given(@"que se ingresa un id de un product (.*) para eliminar")]
        public void GivenQueSeIngresaUnIdDeUnProductParaEliminar(int p0)
        {
            id1 = p0;
        }

        [When(@"presiono el botón de eliminar")]
        public void WhenPresionoElBotonDeEliminar()
        {
            _productRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Product, bool>>>())).Returns(Product);

            _productManager.Delete(id1);
        }

        [Then(@"se elimina el producto correctamente")]
        public void ThenSeEliminaElProductoCorrectamente()
        {
            try
            {
                _productRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Product, bool>>>())).Returns(nullProduct);

                Product p1 = _productManager.GetById(id1);
                p1.Should().BeNull();
            }
            catch (Exception err)
            {
                err1 = err;
            }

            err1.Should().NotBeNull();
            Assert.IsType<ResourceNotFoundException>(err1);
        }

        [Given(@"que se ingresa un id de un product (.*) que no existe")]
        public void GivenQueSeIngresaUnIdDeUnProductQueNoExiste(int p0)
        {
            id2 = p0;
        }

        [When(@"presiono el botón de eliminar en el caso error")]
        public void WhenPresionoElBotonDeEliminarEnElCasoError()
        {
            try
            {
                _productRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Product, bool>>>())).Returns(nullProduct);

                _productManager.Delete(id2);
            }
            catch (Exception err)
            {
                err2 = err;
            }
        }

        [Then(@"no se elimina el producto")]
        public void ThenNoSeEliminaElProducto()
        {
            try
            {
                _productRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Product, bool>>>())).Returns(nullProduct);

                Product p2 = _productManager.GetById(id2);
                p2.Should().BeNull();

            }
            catch (Exception err)
            {
                err3 = err;
            }

            err2.Should().NotBeNull();
            Assert.IsType<ResourceNotFoundException>(err2);
            err3.Should().NotBeNull();
            Assert.IsType<ResourceNotFoundException>(err3);
        }
    }
}
