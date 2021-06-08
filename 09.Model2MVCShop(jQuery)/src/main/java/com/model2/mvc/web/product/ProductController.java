package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	//@RequestMapping("/addProductView.do")
	@RequestMapping(value = "addProduct", method=RequestMethod.GET)
	public String addProductView() throws Exception {

		System.out.println("/product/addProduct : GET");
		
		return "forward:/product/addProductView.jsp";
	}
	
	//@RequestMapping("/addProduct.do")
		@RequestMapping(value="addProduct", method=RequestMethod.POST)
		public String addProduct(@ModelAttribute("product") Product product,
														Model model) throws Exception {
			
			System.out.println("/product/addProduct : POST");

			productService.addProduct(product);
			System.out.println(product);
			
			model.addAttribute("product", product);
			
			return "forward:/product/addProduct.jsp";
		}
		
		@RequestMapping(value="getProduct",  method=RequestMethod.GET)
		public String getProduct(@RequestParam("menu") String menu
								,@RequestParam("prodNo") int prodNo, Model model, HttpServletResponse response) throws Exception {
			
			System.out.println("/product/getProduct : GET");
			
			Product product = productService.getProduct(prodNo);
			
			model.addAttribute("product", product);
			model.addAttribute("menu",menu);
			
			Cookie cookie = new Cookie("history",Integer.toString(prodNo));
			response.addCookie(cookie);
			
			if(menu.equals("manage")) {
				return "forward:/product/updateProductView.jsp";
			}else {
				return "forward:/product/getProduct.jsp";
			}
		}
		
		@RequestMapping(value ="listProduct")
		public String listProduct(@ModelAttribute("search") Search search,
								@RequestParam("menu") String menu, Model model ) throws Exception {
			
			System.out.println("/product/listProduct");
			
			if(search.getCurrentPage() == 0) {
				search.setCurrentPage(1);
			}
			search.setPageSize(pageSize);
			
			Map<String , Object> map = productService.getProductList(search);
			
			Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue()
									,pageUnit,search.getPageSize());
			
			System.out.println(map.get("list"));
			
			model.addAttribute("list",map.get("list"));
			model.addAttribute("resultPage",resultPage);
			model.addAttribute("menu",menu);
			model.addAttribute("search", search);
			
			return "forward:/product/listProduct.jsp";
		}
		
		@RequestMapping( value = "updateProduct" , method=RequestMethod.GET )
		public String updateProductView( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{

			System.out.println("/product/updateProduct : GET ");
			//Business Logic
			Product product = productService.getProduct(prodNo);
			// Model 과 View 연결
			model.addAttribute("product", product);
			
			return "forward:/product/updateProductView.jsp";
		}

		@RequestMapping(value="updateProduct", method=RequestMethod.POST)
		public String updateProduct(@ModelAttribute("product") Product product, Model model, HttpSession session) throws Exception {
			
			System.out.println("/product/updateProduct : POST");
			
			productService.updateProduct(product);
		
			// return "redirect:/product/getProduct?prodNo="+product.getProdNo()+"&menu=manage";
			
			return "forward:/product/getProduct.jsp";
		}
	
	
}