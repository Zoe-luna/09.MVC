<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>

<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

function fncGetProductList(currentPage){
   	$("#currentPage").val(currentPage)
	$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${ param.menu }").submit();
}

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">
 
 <form name="detailForm">
 
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
							
							<c:if test="${ param.menu == 'manage' }">
								상품 관리
							</c:if>
							<c:if test="${ param.menu == 'search' }">
								상품 목록조회
							</c:if>
					
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>	

		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
				<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
				<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
				<option value="3"  ${ ! empty search.searchCondition && search.searchCondition==3 ? "selected" : "" }>상품분류</option>
			</select>
			<input type="text" name="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : "" }"
					 class="ct_input_g" style="width:200px; height:19px" />
		</td>
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetProductList(1);">검색</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td/>
		<td/>
		<td/>
		<td colspan="11" >
			<a href="/product/listProduct?searchCondition=3&searchKeyword=1&menu=search">식음료품</a>
			
			<a href="/product/listProduct?searchCondition=3&searchKeyword=2&menu=search">가전제품</a>
			
			<a href="/product/listProduct?searchCondition=3&searchKeyword=3&menu=search">취미생활</a>
			
			<a href="/product/listProduct?searchCondition=3&searchKeyword=4&menu=search">운동기구</a>
		</td>
	</tr>
	
	<tr>
		<td colspan="11" >
			전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">분류</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			<td align="left">	
				<c:if test="${ param.menu == 'manage' }">
					<a href="/product/updateProduct?prodNo=${ product.prodNo }&menu=manage">${ product.prodName }</a>
				</c:if>
				<c:if test="${ param.menu == 'search' }">
					<a href="/product/getProduct?prodNo=${ product.prodNo }&menu=search">${ product.prodName }</a>
				</c:if>
			
			</td>
			<td></td>
			<td align="left">${product.price }</td>
			<td></td>
			<td align="left">
				<c:if test="${product.category == '1'}">
					식음료품
				</c:if>
				<c:if test="${product.category == '2'}">
					가전제품
				</c:if>
				<c:if test="${product.category == '3'}">
					취미생활
				</c:if>
				<c:if test="${product.category == '4'}">
					운동기구
				</c:if>
			</td>
			<td></td>
			<td align="left">${product.regDate }
			</td>
			<td></td>
			<td align="left">
				<c:if test="${product.proTranCode == null}">
					판매중
				</c:if>
				<c:if test="${product.proTranCode == '1'}">
					구매완료
				</c:if>
				<c:if test="${product.proTranCode == '2'}">
					배송중
				</c:if>
				<c:if test="${product.proTranCode == '3'}">
					배송완료
				</c:if>
			
			</td>
			
		</tr>
		<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>


</table>

<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		   
			<jsp:include page="../common/pageNavigator.jsp"/>	
		
    	</td>
	</tr>
</table>
<!-- PageNavigation End... -->

</form>

</div>
</body>
</html>
