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
    public class UpdateProductStepDefinitions
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

        private Product Product1 = new Product();
        private Product Product1_new = new Product();
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

        [Given(@"que existe un producto con código numérico (.*)")]
        public void GivenQueExisteUnProductoConCodigoNumerico(int p0)
        {
            Product1.Id = 1;
            Product1.Code = p0;
            Product1.Pharmacy = pharmacy;
            Product1.Price = 10;
            Product1.Description = "OLD DESC";
            Product1.Name = "OLD NAME";

            _productRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Product, bool>>>())).Returns(Product1);
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Pharmacy, bool>>>())).Returns(pharmacy);
            _sessionRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Session, bool>>>())).Returns(session);
            _userRepository.Setup(r => r.GetOneDetailByExpression(It.IsAny<Expression<Func<User, bool>>>())).Returns(user);

            _productRepository.Setup(x => x.InsertOne(It.IsAny<Product>()));
            _productRepository.Setup(x => x.Save());

            _productManager.Create(Product1, token);
        }

        [Given(@"se ingresa en el escenario_UI un código numérico de (.*)")]
        public void GivenSeIngresaEnElEscenario_UIUnCodigoNumericoDe(int p0)
        {
            Product1_new.Code = p0;
        }

        [Given(@"se ingresa en el escenario_UI un nombre de producto ""([^""]*)""")]
        public void GivenSeIngresaEnElEscenario_UIUnNombreDeProducto(string name)
        {
            Product1_new.Name = name;
        }

        [Given(@"se ingresa en el escenario_UI una descripción ""([^""]*)""")]
        public void GivenSeIngresaEnElEscenario_UIUnaDescripcion(string p0)
        {
            Product1_new.Description = p0;
        }

        [Given(@"se coloca en el escenario_UI un precio de (.*)")]
        public void GivenSeColocaEnElEscenario_UIUnPrecioDe(int p0)
        {
            Product1_new.Price = p0;
        }

        [When(@"presiono el botón de modificación")]
        public void WhenPresionoElBotonDeModificacion()
        {
            _productRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Product, bool>>>())).Returns(Product1);
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Pharmacy, bool>>>())).Returns(pharmacy);

            _productRepository.Setup(x => x.UpdateOne(It.IsAny<Product>()));
            _productRepository.Setup(x => x.Save());

            _productManager.Update(Product1.Id, Product1);
        }

        [Then(@"se modifica la información del producto correctamente")]
        public void ThenSeModificaLaInformacionDelProductoCorrectamente()
        {
            Expression<Func<Product, bool>> testExpression = binding => binding.Id == Product1.Id;
            _productRepository.Setup(r => r.GetOneByExpression(It.Is<Expression<Func<Product, bool>>>(criteria => Neleus.LambdaCompare.Lambda.Eq(criteria, testExpression)))).Returns(Product1);

            Product p1 = _productManager.GetById(Product1.Id);
            p1.Should().NotBeNull();
        }

        [Given(@"que en el escenario_UII se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_UIISeIngresaUnCodigoNumericoDe(int p0)
        {
            Product2.Code = p0;
        }

        [Given(@"en el escenario_UII ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_UIIIngresaUnNombreDeProducto(string p0)
        {
            Product2.Name = p0;
        }

        [Given(@"en el escenario_UII ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_UIIIngresaUnaDescripcion(string p0)
        {
            Product2.Description = p0;
        }

        [Given(@"en el escenario_UII coloca un precio de (.*)")]
        public void GivenEnElEscenario_UIIColocaUnPrecioDe(int p0)
        {
            Product2.Price = p0;
        }

        [When(@"en el escenario_UII presiono el botón de modificación")]
        public void WhenEnElEscenario_UIIPresionoElBotonDeModificacion()
        {
            Product2.Id = 2;
            Product2.Pharmacy = pharmacy;

            _productRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Product, bool>>>())).Returns(Product2);
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Pharmacy, bool>>>())).Returns(pharmacy);

            _productRepository.Setup(x => x.InsertOne(It.IsAny<Product>()));
            _productRepository.Setup(x => x.Save());

            try
            {
                _productManager.Update(Product2.Id, Product2);
            }
            catch (Exception err)
            {
                err2 = err;
            }
        }

        [Then(@"en el escenario_UII no se modifica la información del producto")]
        public void ThenEnElEscenario_UIINoSeModificaLaInformacionDelProducto()
        {
            err2.Should().NotBeNull();
            Assert.IsType<InvalidResourceException>(err2);
        }

        [Given(@"que en el escenario_UIII se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_UIIISeIngresaUnCodigoNumericoDe(int p0)
        {
            Product3.Code = p0;
        }

        [Given(@"en el escenario_UIII ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_UIIIIngresaUnNombreDeProducto(string p0)
        {
            Product3.Name = p0;
        }

        [Given(@"en el escenario_UIII ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_UIIIIngresaUnaDescripcion(string p0)
        {
            Product3.Description = p0;
        }

        [Given(@"en el escenario_UIII coloca un precio de (.*)")]
        public void GivenEnElEscenario_UIIIColocaUnPrecioDe(int p0)
        {
            Product3.Price = p0;
        }

        [When(@"en el escenario_UIII presiono el botón de modificación")]
        public void WhenEnElEscenario_UIIIPresionoElBotonDeModificacion()
        {
            Product3.Id = 3;
            Product3.Pharmacy = pharmacy;

            _productRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Product, bool>>>())).Returns(Product3);
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Pharmacy, bool>>>())).Returns(pharmacy);

            _productRepository.Setup(x => x.InsertOne(It.IsAny<Product>()));
            _productRepository.Setup(x => x.Save());

            try
            {
                _productManager.Update(Product3.Id, Product3);
            }
            catch (Exception err)
            {
                err3 = err;
            }
        }

        [Then(@"en el escenario_UIII no se modifica la información del producto")]
        public void ThenEnElEscenario_UIIINoSeModificaLaInformacionDelProducto()
        {
            err3.Should().NotBeNull();
            Assert.IsType<InvalidResourceException>(err3);
        }

        [Given(@"que en el escenario_UIV no existe un producto con código numérico de (.*)")]
        public void GivenQueEnElEscenario_UIVNoExisteUnProductoConCodigoNumericoDe(int p0)
        {
            //DUMMY
        }

        [Given(@"que en el escenario_UIV se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_UIVSeIngresaUnCodigoNumericoDe(int p0)
        {
            Product4.Code = p0;
        }

        [Given(@"en el escenario_UIV ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_UIVIngresaUnNombreDeProducto(string p0)
        {
            Product4.Name = p0;
        }

        [Given(@"en el escenario_UIV ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_UIVIngresaUnaDescripcion(string p0)
        {
            Product4.Description = p0;
        }

        [Given(@"en el escenario_UIV coloca un precio de (.*)")]
        public void GivenEnElEscenario_UIVColocaUnPrecioDe(int p0)
        {
            Product4.Price = p0;
        }

        [When(@"en el escenario_UIV presiono el botón de modificación")]
        public void WhenEnElEscenario_UIVPresionoElBotonDeModificacion()
        {
            Product4.Id = 4;
            Product4.Pharmacy = pharmacy;

            _productRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Product, bool>>>())).Returns((Product)null);

            try
            {
                _productManager.Update(Product4.Id, Product4);
            }
            catch (Exception err)
            {
                err4 = err;
            }
        }

        [Then(@"en el escenario_UIV no se modifican los datos del producto porque no existe")]
        public void ThenEnElEscenario_UIVNoSeModificanLosDatosDelProductoPorqueNoExiste()
        {
            err4.Should().NotBeNull();
            Assert.IsType<ResourceNotFoundException>(err4);
        }

        [Given(@"que en el escenario_UV se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_UVSeIngresaUnCodigoNumericoDe(int p0)
        {
            Product5.Code = p0;
        }

        [Given(@"en el escenario_UV ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_UVIngresaUnNombreDeProducto(string p0)
        {
            Product5.Name = p0;
        }

        [Given(@"en el escenario_UV ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_UVIngresaUnaDescripcion(string p0)
        {
            Product5.Description = p0;
        }

        [Given(@"en el escenario_UV coloca un precio de (.*)")]
        public void GivenEnElEscenario_UVColocaUnPrecioDe(int p0)
        {
            Product5.Price = p0;
        }

        [When(@"en el escenario_UV presiono el botón de modificación")]
        public void WhenEnElEscenario_UVPresionoElBotonDeModificacion()
        {
            Product5.Id = 2;
            Product5.Pharmacy = pharmacy;

            _productRepository.Setup(r => r.Exists(It.IsAny<Expression<Func<Product, bool>>>())).Returns(false);
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Pharmacy, bool>>>())).Returns(pharmacy);

            _productRepository.Setup(x => x.InsertOne(It.IsAny<Product>()));
            _productRepository.Setup(x => x.Save());

            try
            {
                _productManager.Update(Product5.Id, Product5);
            }
            catch (Exception err)
            {
                err5 = err;
            }
        }

        [Then(@"en el escenario_UV no se modifica la información del producto")]
        public void ThenEnElEscenario_UVNoSeModificaLaInformacionDelProducto()
        {
            err5.Should().NotBeNull();
            Assert.IsType<InvalidResourceException>(err5);
        }

        [Given(@"que en el escenario_UVI se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_UVISeIngresaUnCodigoNumericoDe(int p0)
        {
            Product6.Code = p0;
        }

        [Given(@"en el escenario_UVI ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_UVIIngresaUnNombreDeProducto(string p0)
        {
            Product6.Name = p0;
        }

        [Given(@"en el escenario_UVI ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_UVIIngresaUnaDescripcion(string p0)
        {
            Product6.Description = p0;
        }

        [Given(@"en el escenario_UVI coloca un precio de (.*)")]
        public void GivenEnElEscenario_UVIColocaUnPrecioDe(int p0)
        {
            Product6.Price = p0;
        }

        [When(@"en el escenario_UVI presiono el botón de modificación")]
        public void WhenEnElEscenario_UVIPresionoElBotonDeModificacion()
        {
            Product6.Id = 2;
            Product6.Pharmacy = pharmacy;

            _productRepository.Setup(r => r.Exists(It.IsAny<Expression<Func<Product, bool>>>())).Returns(false);
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Pharmacy, bool>>>())).Returns(pharmacy);

            _productRepository.Setup(x => x.InsertOne(It.IsAny<Product>()));
            _productRepository.Setup(x => x.Save());

            try
            {
                _productManager.Update(Product6.Id, Product6);
            }
            catch (Exception err)
            {
                err6 = err;
            }
        }

        [Then(@"en el escenario_UVI no se modifica la información del producto")]
        public void ThenEnElEscenario_UVINoSeModificaLaInformacionDelProducto()
        {
            err6.Should().NotBeNull();
            Assert.IsType<InvalidResourceException>(err6);
        }

        [Given(@"que en el escenario_UVII se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_UVIISeIngresaUnCodigoNumericoDe(int p0)
        {
            Product7.Code = p0;
        }

        [Given(@"en el escenario_UVII ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_UVIIIngresaUnNombreDeProducto(string p0)
        {
            Product7.Name = p0;
        }

        [Given(@"en el escenario_UVII ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_UVIIIngresaUnaDescripcion(string p0)
        {
            Product7.Description = p0;
        }

        [Given(@"en el escenario_UVII coloca un precio de (.*)")]
        public void GivenEnElEscenario_UVIIColocaUnPrecioDe(int p0)
        {
            Product7.Price = p0;
        }

        [When(@"en el escenario_UVII presiono el botón de modificación")]
        public void WhenEnElEscenario_UVIIPresionoElBotonDeModificacion()
        {
            Product7.Id = 2;
            Product7.Pharmacy = pharmacy;

            _productRepository.Setup(r => r.Exists(It.IsAny<Expression<Func<Product, bool>>>())).Returns(false);
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.IsAny<Expression<Func<Pharmacy, bool>>>())).Returns(pharmacy);

            _productRepository.Setup(x => x.InsertOne(It.IsAny<Product>()));
            _productRepository.Setup(x => x.Save());

            try
            {
                _productManager.Update(Product7.Id, Product7);
            }
            catch (Exception err)
            {
                err7 = err;
            }
        }

        [Then(@"en el escenario_UVII no se modifica la información del producto")]
        public void ThenEnElEscenario_UVIINoSeModificaLaInformacionDelProducto()
        {
            err7.Should().NotBeNull();
            Assert.IsType<InvalidResourceException>(err7);
        }
    }
}
