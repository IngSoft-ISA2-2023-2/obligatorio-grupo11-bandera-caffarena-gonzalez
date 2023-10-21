using Moq;
using PharmaGo.BusinessLogic;
using PharmaGo.DataAccess.Repositories;
using PharmaGo.Domain.Entities;
using PharmaGo.Exceptions;
using PharmaGo.IBusinessLogic;
using PharmaGo.IDataAccess;
using System.Linq.Expressions;
using TechTalk.SpecFlow;

namespace SpecFlowProject.StepDefinitions
{
    [Binding]
    public class NewProductStepDefinitions
    {
        private static Mock<IRepository<Product>> _productRepository  = new Mock<IRepository<Product>>();
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

        private Product Product1 = new Product();
        private Product Product2 = new Product();
        private Product Product3 = new Product();
        private Product Product4 = new Product();
        private Product Product5 = new Product();
        private Product Product6 = new Product();
        private Product Product7 = new Product();

        private Exception? err2;
        private Exception? err3;
        private Exception? err4;
        private Exception? err5;
        private Exception? err6;
        private Exception? err7;

        [Given(@"que se ingresa un código numérico de (.*)")]
        public void GivenQueSeIngresaUnCodigoNumericoDe(int p0)
        {
            Product1.Code = p0;
        }

        [Given(@"se ingresa un nombre de producto ""([^""]*)""")]
        public void GivenSeIngresaUnNombreDeProducto(string p0)
        {
            Product1.Name = p0;
        }

        [Given(@"se ingresa una descripción ""([^""]*)""")]
        public void GivenSeIngresaUnaDescripcion(string p0)
        {
            Product1.Description = p0;
        }

        [Given(@"se coloca un precio de (.*)")]
        public void GivenSeColocaUnPrecioDe(int p0)
        {
            Product1.Price = p0;
        }

        [When(@"presiono el botón de creación")]
        public void WhenPresionoElBotonDeCreacion()
        {
            Product1.Id = 1;
            Product1.Pharmacy = pharmacy;

            _productRepository.Setup(r => r.Exists(It.IsAny<Expression<Func<Product, bool>>>())).Returns(false);
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Pharmacy, bool>>>())).Returns(pharmacy);
            _sessionRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Session, bool>>>())).Returns(session);
            _userRepository.Setup(r => r.GetOneDetailByExpression(It.IsAny<Expression<Func<User, bool>>>())).Returns(user);

            _productRepository.Setup(x => x.InsertOne(It.IsAny<Product>()));
            _productRepository.Setup(x => x.Save());

            _productManager.Create(Product1, token);
        }

        [Then(@"se da de alta el producto correctamente")]
        public void ThenSeDaDeAltaElProductoCorrectamente()
        {
            _productRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Product, bool>>>())).Returns(Product1);

            Product p1 = _productManager.GetById(Product1.Id);
            p1.Should().NotBeNull();
        }

        [Given(@"que en el escenario_II se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_IISeIngresaUnCodigoNumericoDe(int p0)
        {
            Product2.Code = p0;
        }

        [Given(@"en el escenario_II ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_IIIngresaUnNombreDeProducto(string p0)
        {
            Product2.Name = p0;
        }

        [Given(@"en el escenario_II ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_IIIngresaUnaDescripcion(string p0)
        {
            Product2.Description = p0;
        }

        [Given(@"en el escenario_II coloca un precio de (.*)")]
        public void GivenEnElEscenario_IIColocaUnPrecioDe(int p0)
        {
            Product2.Price = p0;
        }

        [When(@"en el escenario_II presiono el botón de creación")]
        public void WhenEnElEscenario_IIPresionoElBotonDeCreacion()
        {
            Product2.Id = 2;
            Product2.Pharmacy = pharmacy;

            _productRepository.Setup(r => r.Exists(It.IsAny<Expression<Func<Product, bool>>>())).Returns(false);
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Pharmacy, bool>>>())).Returns(pharmacy);
            _sessionRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Session, bool>>>())).Returns(session);
            _userRepository.Setup(r => r.GetOneDetailByExpression(It.IsAny<Expression<Func<User, bool>>>())).Returns(user);

            _productRepository.Setup(x => x.InsertOne(It.IsAny<Product>()));
            _productRepository.Setup(x => x.Save());

            try
            {
                _productManager.Create(Product2, token);
            }
            catch (Exception err)
            {
                err2 = err;
            }
        }

        [Then(@"en el escenario_II no se da de alta el producto")]
        public void ThenEnElEscenario_IINoSeDaDeAltaElProducto()
        {
            err2.Should().NotBeNull(); 
            Assert.IsType<InvalidResourceException>(err2);
        }

        [Given(@"que en el escenario_III se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_IIISeIngresaUnCodigoNumericoDe(int p0)
        {
            Product3.Code = p0;
        }

        [Given(@"en el escenario_III ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_IIIIngresaUnNombreDeProducto(string p0)
        {
            Product3.Name =p0;
        }

        [Given(@"en el escenario_III ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_IIIIngresaUnaDescripcion(string p0)
        {
            Product3.Description = p0;
        }

        [Given(@"en el escenario_III coloca un precio de (.*)")]
        public void GivenEnElEscenario_IIIColocaUnPrecioDe(int p0)
        {
            Product3.Price = p0;
        }

        [When(@"en el escenario_III presiono el botón de creación")]
        public void WhenEnElEscenario_IIIPresionoElBotonDeCreacion()
        {
            Product3.Id = 3;
            Product3.Pharmacy = pharmacy;

            _productRepository.Setup(r => r.Exists(It.IsAny<Expression<Func<Product, bool>>>())).Returns(false);
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Pharmacy, bool>>>())).Returns(pharmacy);
            _sessionRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Session, bool>>>())).Returns(session);
            _userRepository.Setup(r => r.GetOneDetailByExpression(It.IsAny<Expression<Func<User, bool>>>())).Returns(user);

            _productRepository.Setup(x => x.InsertOne(It.IsAny<Product>()));
            _productRepository.Setup(x => x.Save());

            try
            {
                _productManager.Create(Product3, token);
            }
            catch (Exception err)
            {
                err3 = err;
            }
        }

        [Then(@"en el escenario_III no se da de alta el producto")]
        public void ThenEnElEscenario_IIINoSeDaDeAltaElProducto()
        {
            err3.Should().NotBeNull();
            Assert.IsType<InvalidResourceException>(err3);
        }

        [Given(@"que en el escenario_IV se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_IVSeIngresaUnCodigoNumericoDe(int p0)
        {
            Product4.Code = p0;
        }

        [Given(@"en el escenario_IV ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_IVIngresaUnNombreDeProducto(string p0)
        {
            Product4.Name = p0;
        }

        [Given(@"en el escenario_IV ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_IVIngresaUnaDescripcion(string p0)
        {
            Product4.Description = p0;
        }

        [Given(@"en el escenario_IV coloca un precio de (.*)")]
        public void GivenEnElEscenario_IVColocaUnPrecioDe(int p0)
        {
            Product4.Price = p0;
        }

        [When(@"en el escenario_IV presiono el botón de creación")]
        public void WhenEnElEscenario_IVPresionoElBotonDeCreacion()
        {
            Product4.Id = 4;
            Product4.Pharmacy = pharmacy;

            _productRepository.Setup(r => r.Exists(It.IsAny<Expression<Func<Product, bool>>>())).Returns(true);

            try
            {
                _productManager.Create(Product4, token);
            }
            catch (Exception err)
            {
                err4 = err;
            }
        }

        [Then(@"en el escenario_IV no se da de alta el producto")]
        public void ThenEnElEscenario_IVNoSeDaDeAltaElProducto()
        {
            err4.Should().NotBeNull();
            Assert.IsType<InvalidResourceException>(err4);
        }

        [Given(@"que en el escenario_V se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_VSeIngresaUnCodigoNumericoDe(int p0)
        {
            Product5.Code = p0;
        }

        [Given(@"en el escenario_V ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_VIngresaUnNombreDeProducto(string p0)
        {
            Product5.Name = p0;
        }

        [Given(@"en el escenario_V ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_VIngresaUnaDescripcion(string p0)
        {
            Product5.Description = p0;
        }

        [Given(@"en el escenario_V coloca un precio de (.*)")]
        public void GivenEnElEscenario_VColocaUnPrecioDe(int p0)
        {
            Product5.Price = p0;
        }

        [When(@"en el escenario_V presiono el botón de creación")]
        public void WhenEnElEscenario_VPresionoElBotonDeCreacion()
        {
            Product5.Id = 2;
            Product5.Pharmacy = pharmacy;

            _productRepository.Setup(r => r.Exists(It.IsAny<Expression<Func<Product, bool>>>())).Returns(false);
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Pharmacy, bool>>>())).Returns(pharmacy);
            _sessionRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Session, bool>>>())).Returns(session);
            _userRepository.Setup(r => r.GetOneDetailByExpression(It.IsAny<Expression<Func<User, bool>>>())).Returns(user);

            _productRepository.Setup(x => x.InsertOne(It.IsAny<Product>()));
            _productRepository.Setup(x => x.Save());

            try
            {
                _productManager.Create(Product5, token);
            }
            catch (Exception err)
            {
                err5 = err;
            }
        }

        [Then(@"en el escenario_V no se da de alta el producto")]
        public void ThenEnElEscenario_VNoSeDaDeAltaElProducto()
        {
            err5.Should().NotBeNull();
            Assert.IsType<InvalidResourceException>(err5);

        }

        [Given(@"que en el escenario_VI se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_VISeIngresaUnCodigoNumericoDe(int p0)
        {
            Product6.Code = p0;
        }

        [Given(@"en el escenario_VI ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_VIIngresaUnNombreDeProducto(string p0)
        {
            Product6.Name = p0;
        }

        [Given(@"en el escenario_VI ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_VIIngresaUnaDescripcion(string p0)
        {
            Product6.Description = p0;
        }

        [Given(@"en el escenario_VI coloca un precio de (.*)")]
        public void GivenEnElEscenario_VIColocaUnPrecioDe(int p0)
        {
            Product6.Price = p0;
        }

        [When(@"en el escenario_VI presiono el botón de creación")]
        public void WhenEnElEscenario_VIPresionoElBotonDeCreacion()
        {
            Product6.Id = 2;
            Product6.Pharmacy = pharmacy;

            _productRepository.Setup(r => r.Exists(It.IsAny<Expression<Func<Product, bool>>>())).Returns(false);
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Pharmacy, bool>>>())).Returns(pharmacy);
            _sessionRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Session, bool>>>())).Returns(session);
            _userRepository.Setup(r => r.GetOneDetailByExpression(It.IsAny<Expression<Func<User, bool>>>())).Returns(user);

            _productRepository.Setup(x => x.InsertOne(It.IsAny<Product>()));
            _productRepository.Setup(x => x.Save());

            try
            {
                _productManager.Create(Product6, token);
            }
            catch (Exception err)
            {
                err6 = err;
            }
        }

        [Then(@"en el escenario_VI no se da de alta el producto")]
        public void ThenEnElEscenario_VINoSeDaDeAltaElProducto()
        {
            err6.Should().NotBeNull();
            Assert.IsType<InvalidResourceException>(err6);
        }

        [Given(@"que en el escenario_VII se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_VIISeIngresaUnCodigoNumericoDe(int p0)
        {
            Product7.Code = p0;
        }

        [Given(@"en el escenario_VII ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_VIIIngresaUnNombreDeProducto(string p0)
        {
            Product7.Name = p0;
        }

        [Given(@"en el escenario_VII ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_VIIIngresaUnaDescripcion(string p0)
        {
            Product7.Description = p0;
        }

        [Given(@"en el escenario_VII coloca un precio de (.*)")]
        public void GivenEnElEscenario_VIIColocaUnPrecioDe(int p0)
        {
            Product7.Price = p0;
        }

        [When(@"en el escenario_VII presiono el botón de creación")]
        public void WhenEnElEscenario_VIIPresionoElBotonDeCreacion()
        {
            Product7.Id = 2;
            Product7.Pharmacy = pharmacy;

            _productRepository.Setup(r => r.Exists(It.IsAny<Expression<Func<Product, bool>>>())).Returns(false);
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Pharmacy, bool>>>())).Returns(pharmacy);
            _sessionRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Session, bool>>>())).Returns(session);
            _userRepository.Setup(r => r.GetOneDetailByExpression(It.IsAny<Expression<Func<User, bool>>>())).Returns(user);

            _productRepository.Setup(x => x.InsertOne(It.IsAny<Product>()));
            _productRepository.Setup(x => x.Save());

            try
            {
                _productManager.Create(Product7, token);
            }
            catch (Exception err)
            {
                err7 = err;
            }
        }

        [Then(@"en el escenario_VII no se da de alta el producto")]
        public void ThenEnElEscenario_VIINoSeDaDeAltaElProducto()
        {
            err7.Should().NotBeNull();
            Assert.IsType<InvalidResourceException>(err7);
        }
    }
}
