Feature: BuyProduct

@mytag
Scenario: Correcta compra de un producto único
	Given que en el escenario_I, selecciono un producto con una unidad
	When en el escenario_I, presiono el botón de añadir al carrito y finalizo la compra
	Then en el escenario_I, se compra el producto correctamente

@mytag
Scenario: Correcta compra de un producto con varias unidades
	Given que en el escenario_II, selecciono un producto con dos unidades
	When en el escenario_II, presiono el botón de añadir al carrito y finalizo la compra
	Then en el escenario_II, se compra las dos unidades del producto correctamente

@mytag
Scenario: Correcta compra de dos productos distintos de la misma farmacia
	Given que en el escenario_III, selecciono un producto con dos unidades, y otro producto de la misma farmacia con una unidad
	When en el escenario_III, presiono el botón de añadir al carrito y finalizo la compra
	Then en el escenario_III, se compra las tres unidades de los productos correctamente

@mytag
Scenario: Correcta compra de dos productos distintos de distinta farmacia
	Given que en el escenario_IV, selecciono un producto con dos unidades, y otro producto de distinta farmacia con una unidad
	When en el escenario_IV, presiono el botón de añadir al carrito y finalizo la compra
	Then en el escenario_IV, se compra las tres unidades de los productos correctamente

@mytag
Scenario: Correcta compra de productos combinado con medicamento
	Given que en el escenario_V, selecciono un producto y un medicamento
	When en el escenario_V, presiono el botón de añadir al carrito y finalizo la compra
	Then en el escenario_V, se compra del producto y medicamentos se realiza correctamente.

@mytag
Scenario: Intento de compra de producto fallido por monto negativo
	Given que en el escenario_VI, selecciono un producto con cantidad negativa
	When en el escenario_VI, presiono el botón de añadir al carrito e intento finalizar la compra
	Then en el escenario_VI, no se compra del producto por monto negativo.

