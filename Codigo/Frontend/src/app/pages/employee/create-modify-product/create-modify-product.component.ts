import { Component, OnInit } from '@angular/core';
import { cilBarcode, cilPencil, cilPaint, cilAlignCenter, cilDollar, cilLibrary, cilLoop1, cilTask, cilShortText } from '@coreui/icons';
import { AbstractControl, FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { ProductRequest } from 'src/app/interfaces/product';
import { ProductService } from 'src/app/services/product.service';
import { CommonService } from 'src/app/services/CommonService';


@Component({
  selector: 'app-create-modify-product',
  templateUrl: './create-modify-product.component.html',
  styleUrls: ['./create-modify-product.component.css']
})
export class CreateModifyProductComponent implements OnInit {

  form: FormGroup | any;
  icons = { cilBarcode, cilPencil, cilAlignCenter, cilLibrary,
    cilDollar, cilLoop1, cilTask, cilShortText, cilPaint };

  constructor(
    private commonService: CommonService,
    private productService: ProductService,
    private fb: FormBuilder
  ) {
    this.form = this.fb.group({
      name: new FormControl(),
      code: new FormControl(),
      description: new FormControl(),
      price: new FormControl()
    });
   }

  ngOnInit(): void {
  }

  get name(): AbstractControl {
    return this.form.controls.name;
  }

  get code(): AbstractControl {
    return this.form.controls.code;
  }

  get description(): AbstractControl {
    return this.form.controls.description;
  }

  get price(): AbstractControl {
    return this.form.controls.price;
  }

  createProduct() {
    let name = this.name.value ? this.name.value : "";
    let code = this.code.value ? this.code.value : "";
    let description = this.description.value ? this.description.value : "";
    let price = this.price.value ? this.price.value : 0;

    let productRequest = new ProductRequest(code, name, description, price, "");
      this.productService.createProduct(productRequest).subscribe((product) => {
      this.form.reset();
      if (product){
        this.commonService.updateToastData(
          `Success creating "${product.code} - ${product.name}"`,
          'success',
          'Product created.'
        );
      }
    });
  }

  modifyProduct() {
    let name = this.name.value ? this.name.value : "";
    let code = this.code.value ? this.code.value : "";
    let description = this.description.value ? this.description.value : "";
    let price = this.price.value ? this.price.value : 0;

    let productRequest = new ProductRequest(code, name, description, price, "");
      this.productService.modifyProduct(productRequest).subscribe((product) => {
      this.form.reset();
      if (product){
        this.commonService.updateToastData(
          `Success modifying "${product.code} - ${product.name}"`,
          'success',
          'Product modified.'
        );
      }
    });
  }
}
