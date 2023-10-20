using System;
using TechTalk.SpecFlow;

namespace SpecFlowProject.StepDefinitions
{
    [Binding]
    public class NewProductStepDefinitions
    {
        private object ProductService = new object();

        private object Product1 = new object();
        private object Product2 = new object();
        private object Product3 = new object();
        private object Product4 = new object();
        private object Product5 = new object();
        private object Product6 = new object();
        private object Product7 = new object();


        [Given(@"que se ingresa un código numérico de (.*)")]
        public void GivenQueSeIngresaUnCodigoNumericoDe(int p0)
        {
            //Product1.setCodigo(p0);
        }

        [Given(@"se ingresa un nombre de producto ""([^""]*)""")]
        public void GivenSeIngresaUnNombreDeProducto(string p0)
        {
            //Product1.setNombre(p0);

        }

        [Given(@"se ingresa una descripción ""([^""]*)""")]
        public void GivenSeIngresaUnaDescripcion(string p0)
        {
            //Product1.setDescripcion(p0);

        }

        [Given(@"se coloca un precio de (.*)")]
        public void GivenSeColocaUnPrecioDe(int p0)
        {
            //Product1.setPrecio(p0);

        }

        [When(@"presiono el botón de creación")]
        public void WhenPresionoElBotonDeCreacion()
        {
            //ProductService.add(Product1);
        }

        [Then(@"se da de alta el producto correctamente")]
        public void ThenSeDaDeAltaElProductoCorrectamente()
        {
            //Object p1 = ProductService.get(Product1.codigo);
            //p.Should().NotBeNull();
            //p.Should().BeEquivalentTo(Product1);
        }

        [Given(@"que en el escenario_II se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_IISeIngresaUnCodigoNumericoDe(int p0)
        {
            //Product2.setCodigo(p0);
        }

        [Given(@"en el escenario_II ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_IIIngresaUnNombreDeProducto(string p0)
        {
            //Product2.setNombre(p0);
        }

        [Given(@"en el escenario_II ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_IIIngresaUnaDescripcion(string p0)
        {
            //Product2.setDescripcion(p0);
        }

        [Given(@"en el escenario_II coloca un precio de (.*)")]
        public void GivenEnElEscenario_IIColocaUnPrecioDe(int p0)
        {
            //Product2.setPrecio(p0);
        }

        [When(@"en el escenario_II presiono el botón de creación")]
        public void WhenEnElEscenario_IIPresionoElBotonDeCreacion()
        {
            //ProductService.add(Product2);
        }

        [Then(@"en el escenario_II no se da de alta el producto")]
        public void ThenEnElEscenario_IINoSeDaDeAltaElProducto()
        {
            //Object p2 = ProductService.get(Product2.codigo);
            //p2.Should().NotBeNull();
        }

        [Given(@"que en el escenario_III se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_IIISeIngresaUnCodigoNumericoDe(int p0)
        {
            //Product3.setCodigo(p0);
        }

        [Given(@"en el escenario_III ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_IIIIngresaUnNombreDeProducto(string p0)
        {
            //Product3.setNombre(p0);
        }

        [Given(@"en el escenario_III ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_IIIIngresaUnaDescripcion(string p0)
        {
            //Product3.setDescripcion(p0);
        }

        [Given(@"en el escenario_III coloca un precio de (.*)")]
        public void GivenEnElEscenario_IIIColocaUnPrecioDe(int p0)
        {
            //Product3.setPrecio(p0);
        }

        [When(@"en el escenario_III presiono el botón de creación")]
        public void WhenEnElEscenario_IIIPresionoElBotonDeCreacion()
        {
            //ProductService.add(Product3);
        }

        [Then(@"en el escenario_III no se da de alta el producto")]
        public void ThenEnElEscenario_IIINoSeDaDeAltaElProducto()
        {
            //Object p3 = ProductService.get(Product3.codigo);
            //p3.Should().NotBeNull();
        }

        [Given(@"quen en el escenario_IV se ingreso un objeto de codigo numerico (.*)")]
        public void GivenQuenEnElEscenario_IVSeIngresoUnObjetoDeCodigoNumerico(int p0)
        {
            //private object ProductRepeted = new object();
            //ProductRepeted.codigo = p0;
            //ProductService.add(ProductRepeted);
        }


        [Given(@"que en el escenario_IV se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_IVSeIngresaUnCodigoNumericoDe(int p0)
        {
            //Product4.setCodigo(p0);
        }

        [Given(@"en el escenario_IV ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_IVIngresaUnNombreDeProducto(string p0)
        {
            //Product4.setNombre(p0);
        }

        [Given(@"en el escenario_IV ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_IVIngresaUnaDescripcion(string p0)
        {
            //Product4.setDescripcion(p0);
        }

        [Given(@"en el escenario_IV coloca un precio de (.*)")]
        public void GivenEnElEscenario_IVColocaUnPrecioDe(int p0)
        {
            //Product4.setPrecio(p0);
        }

        [When(@"en el escenario_IV presiono el botón de creación")]
        public void WhenEnElEscenario_IVPresionoElBotonDeCreacion()
        {
            //ProductService.add(Product4);
        }

        [Then(@"en el escenario_IV no se da de alta el producto")]
        public void ThenEnElEscenario_IVNoSeDaDeAltaElProducto()
        {
            //Object p4 = ProductService.get(Product4.codigo);
            //p4.Should().NotBeNull();
        }

        [Given(@"que en el escenario_V se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_VSeIngresaUnCodigoNumericoDe(int p0)
        {
            //Product5.setCodigo(p0);
        }

        [Given(@"en el escenario_V ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_VIngresaUnNombreDeProducto(string p0)
        {
            //Product5.setNombre(p0);
        }

        [Given(@"en el escenario_V ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_VIngresaUnaDescripcion(string p0)
        {
            //Product5.setDescripcion(p0);
        }

        [Given(@"en el escenario_V coloca un precio de (.*)")]
        public void GivenEnElEscenario_VColocaUnPrecioDe(int p0)
        {
            //Product5.setPrecio(p0);
        }

        [When(@"en el escenario_V presiono el botón de creación")]
        public void WhenEnElEscenario_VPresionoElBotonDeCreacion()
        {
            //ProductService.add(Product5);
        }

        [Then(@"en el escenario_V no se da de alta el producto")]
        public void ThenEnElEscenario_VNoSeDaDeAltaElProducto()
        {
            //Object p5 = ProductService.get(Product5.codigo);
            //p5.Should().NotBeNull();
        }

        [Given(@"que en el escenario_VI se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_VISeIngresaUnCodigoNumericoDe(int p0)
        {
            //Product6.setCodigo(p0);
        }

        [Given(@"en el escenario_VI ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_VIIngresaUnNombreDeProducto(string p0)
        {
            //Product6.setNombre(p0);
        }

        [Given(@"en el escenario_VI ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_VIIngresaUnaDescripcion(string p0)
        {
            //Product6.setDescripcion(p0);
        }

        [Given(@"en el escenario_VI coloca un precio de (.*)")]
        public void GivenEnElEscenario_VIColocaUnPrecioDe(int p0)
        {
            //Product6.setPrecio(p0);
        }

        [When(@"en el escenario_VI presiono el botón de creación")]
        public void WhenEnElEscenario_VIPresionoElBotonDeCreacion()
        {
            //ProductService.add(Product6);
        }

        [Then(@"en el escenario_VI no se da de alta el producto")]
        public void ThenEnElEscenario_VINoSeDaDeAltaElProducto()
        {
            //Object p6 = ProductService.get(Product6.codigo);
            //p6.Should().NotBeNull();
        }

        [Given(@"que en el escenario_VII se ingresa un código numérico de (.*)")]
        public void GivenQueEnElEscenario_VIISeIngresaUnCodigoNumericoDe(int p0)
        {
            //Product7.setCodigo(p0);
        }

        [Given(@"en el escenario_VII ingresa un nombre de producto ""([^""]*)""")]
        public void GivenEnElEscenario_VIIIngresaUnNombreDeProducto(string p0)
        {
            //Product7.setNombre(p0);
        }

        [Given(@"en el escenario_VII ingresa una descripción ""([^""]*)""")]
        public void GivenEnElEscenario_VIIIngresaUnaDescripcion(string p0)
        {
            //Product7.setDescripcion(p0);
        }

        [Given(@"en el escenario_VII coloca un precio de (.*)")]
        public void GivenEnElEscenario_VIIColocaUnPrecioDe(int p0)
        {
            //Product7.setPrecio(p0);
        }

        [When(@"en el escenario_VII presiono el botón de creación")]
        public void WhenEnElEscenario_VIIPresionoElBotonDeCreacion()
        {
            //ProductService.add(Product7);
        }

        [Then(@"en el escenario_VII no se da de alta el producto")]
        public void ThenEnElEscenario_VIINoSeDaDeAltaElProducto()
        {
            //Object p7 = ProductService.get(Product7.codigo);
            //p7.Should().NotBeNull();
        }



    }
}
