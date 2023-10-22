Feature: updateProduct

@mytag
Scenario: Correcta modificación de un producto
	Given que existe un producto con código numérico 12345
	And se ingresa en el escenario_UI un código numérico de 12345
	And se ingresa en el escenario_UI un nombre de producto "Shampoo"
	And se ingresa en el escenario_UI una descripción "Dale vida a tu pelo!"
	And se coloca en el escenario_UI un precio de 100
	When presiono el botón de modificación
	Then se modifica la información del producto correctamente

@mytag
Scenario: Incorrecta modificación de un producto por codigo largo
	Given que en el escenario_UII se ingresa un código numérico de 1234567
	And en el escenario_UII ingresa un nombre de producto "Shampoo"
	And en el escenario_UII ingresa una descripción "Dale vida a tu pelo!"
	And en el escenario_UII coloca un precio de 100
	When en el escenario_UII presiono el botón de modificación
	Then en el escenario_UII no se modifica la información del producto

@mytag
Scenario: Incorrecta modificación de un producto por codigo corto
	Given que en el escenario_UIII se ingresa un código numérico de 123
	And en el escenario_UIII ingresa un nombre de producto "Shampoo"
	And en el escenario_UIII ingresa una descripción "Dale vida a tu pelo!"
	And en el escenario_UIII coloca un precio de 100
	When en el escenario_UIII presiono el botón de modificación
	Then en el escenario_UIII no se modifica la información del producto

@mytag
Scenario: Incorrecta modificación de un producto que no existe
	Given que en el escenario_UIV no existe un producto con código numérico de 12345
	And que en el escenario_UIV se ingresa un código numérico de 12345
	And en el escenario_UIV ingresa un nombre de producto "Shampoo"
	And en el escenario_UIV ingresa una descripción "Dale vida a tu pelo!"
	And en el escenario_UIV coloca un precio de 100
	When en el escenario_UIV presiono el botón de modificación
	Then en el escenario_UIV no se modifican los datos del producto porque no existe

@mytag
Scenario: Incorrecta modificación de un producto nombre largo mayor a 30 caracteres
	Given que en el escenario_UV se ingresa un código numérico de 1234567
	And en el escenario_UV ingresa un nombre de producto "Shampooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo"
	And en el escenario_UV ingresa una descripción "Dale vida a tu pelo!"
	And en el escenario_UV coloca un precio de 100
	When en el escenario_UV presiono el botón de modificación
	Then en el escenario_UV no se modifica la información del producto

@mytag
Scenario: Incorrecta modificación de un producto descripcion largo mayor a 70 caracteres
	Given que en el escenario_UVI se ingresa un código numérico de 1234567
	And en el escenario_UVI ingresa un nombre de producto "Shampoo"
	And en el escenario_UVI ingresa una descripción "Dale vida a tu pelooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo!"
	And en el escenario_UVI coloca un precio de 100
	When en el escenario_UVI presiono el botón de modificación
	Then en el escenario_UVI no se modifica la información del producto

@mytag
Scenario: Incorrecta modificación de un producto precio menor a 0
	Given que en el escenario_UVII se ingresa un código numérico de 1234567
	And en el escenario_UVII ingresa un nombre de producto "Shampoo"
	And en el escenario_UVII ingresa una descripción "Dale vida a tu pelo!"
	And en el escenario_UVII coloca un precio de -100
	When en el escenario_UVII presiono el botón de modificación
	Then en el escenario_UVII no se modifica la información del producto
