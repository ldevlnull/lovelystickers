<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags"
           prefix="security" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Магазин</title>
    <script src="http://s.codepen.io/assets/libs/modernizr.js" type="text/javascript"></script>
    <meta charset=utf-8/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <style>
        /* NOTE: The styles were added inline because Prefixfree needs access to your styles and they must be inlined if they are on local disk! */
        @import url(http://fonts.googleapis.com/css?family=Lato:400,700);
        /* Iconfonts
         * ============================ */
        @import "http://weloveiconfonts.com/api/?family=fontawesome";
        @import "http://weloveiconfonts.com/api/?family=brandico";

        [class*="fontawesome-"]:before {
            font-family: "FontAwesome", sans-serif;
        }

        [class*="brandico-"]:before {
            font-family: "brandico", sans-serif;
        }

        /* Variables
         * ============================ */
        /* Body
         * ============================ */
        body {
            position: relative;
            font-family: "Lato", sans-serif;
            font-weight: 300;
            font-size: 1em;
            color: #cccccc;
        }

        /* Header
         * ============================ */
        header {
            width: 100%;
            border-bottom: 1px solid #7cbae6;
            background: #1e1e1e;
            /* Profile link*/
            /* Logo */
            /* Cart link */
            /* Quantity Notification */
            /* Quantity Notification hidden when no items */
            /* Back button hidden by default */
            /* State changes when cart is active */
        }

        header a.profile-icon {
            width: 64px;
            height: 64px;
            float: right;
        }

        header a.logo {
            margin-left: 1em;
            text-transform: uppercase;
            text-decoration: none;
            color: #7cbae6;
            line-height: 4em;
        }

        header a.logo span {
            margin: 0 3px 0 3px;
            color: #9cdaf0;
        }

        header a.cart-link {
            float: right;
            padding-left: 1em;
            margin-right: 1em;
            border-left: 1px dotted #515151;
            line-height: 4em;
            text-decoration: none;
            color: #fff;
            transition: color 150ms ease-out;
        }

        header a.cart-link:hover {
            color: #7cbae6;
        }

        header a.cart-link:active, header a.cart-link .active {
            color: #9cdaf0;
        }

        header span.cart-text:before {
            margin: 5px;
        }

        header span.cart-text:before > span {
            display: block;
        }

        header span.cart-quantity {
            position: relative;
            top: -2px;
            left: 5px;
            display: inline-block;
            width: 22px;
            height: 22px;
            border-radius: 50%;
            background: #f63;
            font-size: 0.6em;
            line-height: 20px;
            text-align: center;
            color: #fff;
        }

        header .cart-quantity.empty {
            display: none;
        }

        header .returnToShop {
            display: none;
        }

        header a.cart-link.active {
            border: 0;
            /* Cart link gets hidden */
            /* Back button is displayed */
        }

        header a.cart-link.active span.cart-text {
            display: none;
        }

        header a.cart-link.active span.cart-quantity {
            display: none;
        }

        header a.cart-link.active span.returnToShop {
            position: absolute;
            right: -75px;
            display: block;
            padding: 0 10px;
            background: #1e1e1e;
            border-right: 1px dotted #444444;
        }

        /* Sliding Cart
         * ============================ */
        .wrap {
            position: relative;
            right: 0;
            box-shadow: 10px -10px 20px -10px rgba(0, 0, 0, 0.8);
            transition: all 200ms ease-out;
        }

        .wrap.active {
            right: 18em;
        }

        #cart {
            clear: both;
            overflow: hidden;
        }

        .js #cart {
            position: absolute;
            top: 0;
            right: 0;
            width: 18em;
            height: 100%;
        }

        /* Footer
         * ============================ */
        footer {
            background: #111;
            font-size: 0.85em;
            color: #fff;
        }

        footer p {
            margin: 0 1em;
            line-height: 3em;
            color: #515151;
        }

        /* Shop & Product Items
         * ============================ */
        .product {
            position: relative;
            z-index: 1;
            float: left;
            width: 50%;
            height: 300px;
            overflow: hidden;
            background-position: center center;
            background-size: cover;
            /* Hide product descriptions */
            /* On hover, adds overlay on top of product image */
            /* On hover, fade in product descriptions */
            /* Styles for each shop item */
            /* "Add to Cart" Buttom with 3D transforms and keyframe animation (Works best in Chrome) */
        }

        .product > * {
            margin: 20px 25px;
            opacity: 0;
            transition: opacity 200ms ease-out;
        }

        .product:hover:before {
            position: absolute;
            z-index: -1;
            top: 0;
            display: inline-block;
            width: 100%;
            height: 300px;
            background: rgba(0, 0, 0, 0.8);
            content: "";
        }

        .product > * {
            margin: 20px 25px;
            opacity: 0;
            transition: opacity 200ms ease-out;
        }

        .product:hover > *, .product .active {
            opacity: 1;
        }

        .product h1 {
            padding: 15px 0;
            border-bottom: 1px dotted gray;
            font-weight: normal;
            font-size: 1.6em;
            color: #7cbae6;
        }

        .product p {
            margin-bottom: 30px;
            line-height: 1.5em;
        }

        .product .button {
            position: relative;
            display: block;
            width: 150px;
            height: 50px;
            text-align: center;
            perspective: 1000px;
            /* Button magic */
        }

        .product .button .price {
            position: absolute;
            z-index: 1;
            top: 2px;
            display: block;
            width: 50px;
            height: 46px;
            border-right: 1px solid #9cdaf0;
            border-radius: 2px 0 0 2px;
            background: #fff;
            line-height: 45px;
            color: #515151;
            transform: rotateY(0deg) translateZ(25px);
        }

        .product .button .addtocart {
            position: absolute;
            left: 48px;
            width: 100%;
            height: 100%;
            transform-style: preserve-3d;
            transform: translateZ(-100px);
            transition: transform 300ms;
            cursor: pointer;
        }

        .product .button .addtocart > div {
            position: absolute;
            display: block;
            width: 150px;
            height: 50px;
            border-radius: 0 2px 2px 0;
            line-height: 50px;
        }

        .product .button .addtocart > .add {
            background: #fff;
            color: #7cbae6;
            transform: rotateY(0deg) translateZ(25px);
            transition: background 150ms ease-out;
        }

        .product .button .addtocart > .add:hover {
            background: #7cbae6;
            color: #fff;
        }

        .product .button .addtocart > .added {
            background: #f63;
            color: #fff;
            transform: rotateX(90deg) translateZ(25px);
        }

        .product .button .addtocart.active {
            animation-name: rotate;
            animation-duration: 1s;
        }

        /* Cart & Cart Items
         * ============================ */
        #cart {
            background: #222;
        }

        #cart > h2 {
            height: 64px;
            padding-right: 1em;
            border-left: 1px dotted #515151;
            border-bottom: 1px solid #7cbae6;
            margin: 0;
            background: #2d2d2d;
            font-weight: normal;
            font-size: 1.2em;
            text-align: right;
            line-height: 64px;
        }

        /* Styles for each cart item */
        .cart-items {
            padding: 0;
        }

        .cart-items > li {
            margin: 30px 20px 30px;
            border: 1px solid #333;
            background: #202020;
            list-style: none;
        }

        .cart-product {
            position: relative;
            display: inline-block;
            height: 75px;
            width: 75px;
            background-image: url("http://cdn.shopify.com/s/files/1/0051/4802/products/MG_1785_1024x1024.jpg");
            background-size: cover;
            vertical-align: top;
        }

        .cart-product input.quantity {
            width: 75px;
            height: 75px;
            padding: 0;
            border: 0;
            border-right: 1px solid #333;
            background: rgba(0, 0, 0, 0.5);
            font-size: 2.5em;
            line-height: 75px;
            text-align: center;
            color: #fff;
        }

        .cart-description {
            display: inline-block;
            height: 75px;
            width: 160px;
            margin-left: 10px;
            text-align: right;
            vertical-align: top;
        }

        .cart-description h3 {
            margin: 8px;
            font-size: 1em;
            color: #7cbae6;
        }

        .cart-description .subtotal {
            position: relative;
            display: inline-block;
            margin: 8px;
            font-size: 0.8em;
        }

        /* Styling for Total Costs */
        .total {
            margin-top: 50px;
        }

        .total > * {
            display: block;
            padding-bottom: 10px;
            margin: 0 20px 10px 20px;
            font-size: 0.8em;
            text-align: left;
        }

        .total span {
            float: right;
            text-align: right;
        }

        .subtotalTotal {
            border-bottom: 1px dotted #515151;
        }

        .shipping {
            border-bottom: 1px dotted #515151;
        }

        .finalTotal {
            font-size: 1em;
            color: #7cbae6;
        }

        a.checkout {
            height: 35px;
            padding: 0;
            margin-top: 30px;
            border-radius: 3px;
            background: #247ebe;
            font-size: 1em;
            text-align: center;
            text-transform: uppercase;
            line-height: 35px;
            transition: background 150ms ease-out;
            cursor: pointer;
        }

        a.checkout:hover {
            background: #3c98da;
        }

        a.checkout.active {
            animation-name: shake;
            animation-duration: 800ms;
        }

        .error {
            display: none;
            text-align: center;
        }

        .error:after {
            display: block;
            font-size: 0.9em;
            text-transform: none;
            content: "Sorry, the Octocat is busy!";
        }

        /* Media Queries
         * ============================ */
        @media (max-width: 720px) {
            .product {
                width: 100%;
            }
        }

        @media (max-width: 420px) {
            /* Hide text in the cart link to save room */
            .cart-text > span {
                display: none;
            }
        }

        /* Keyframe Animations
         * ============================ */
        @keyframes rotate {
            35% {
                transform: translateZ(-100px) rotateX(-90deg);
            }
            72% {
                transform: translateZ(-100px) rotateX(-90deg);
            }
            100% {
                transform: translateZ(-100px);
            }
        }

        @keyframes shake {
            0%, 100% {
                transform: translateX(0);
            }
            10%, 30%, 50%, 70%, 90% {
                transform: translateX(-5px);
            }
            20%, 40%, 60%, 80% {
                transform: translateX(5px);
            }
        }

    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js"></script>
    <script src="/js/jquery-3.1.1.min.js"></script>
</head>
<body onload="getProfile">
<security:authorize access="hasRole('ROLE_USER')">
    <div id='cart'>
        <h2>Ваша корзина</h2>
        <ul class='cart-items'></ul>
        <div class='total'>
            <div class='subtotalTotal'>
                Вартість
                <span>$0.00</span>
            </div>
            <div class='taxes'>
                ПДВ
                <span>$0.00</span>
            </div>
            <div class='shipping'>
                Доставка
                <span>$0.00</span>
            </div>
            <div class='finalTotal'>
                Всього
                <span>$0.00</span>
            </div>
            <a class='checkout'>
                Замовити
            </a>
            <p class='error'></p>
        </div>
    </div>
</security:authorize>
<div class='wrap' id='wrap'>
    <header>
        <a class='logo' href="/">
            Lovelystickersua
        </a>
        <security:authorize access="hasRole('ROLE_USER')">
            <a class='profile-icon' href="profile">
                <img src="${user.pathImage}" width="64px" height="64px"/>
            </a>
        </security:authorize>
        <security:authorize access="!isAuthenticated()">
            <a class='loginproces'>
                <form:form action="login" method="post">
                    <input name="username" id="usernameLog" type="text" placeholder="username" required>
                    <input name="password" id="password" type="password" placeholder="password" required>
                    <button>Увійти</button>
                    <a href="/register">Have no account?</a>
                </form:form>
            </a>
        </security:authorize>
        <input readonly type="hidden" name="csrf_name" value="${_csrf.parameterName}"/>
        <input readonly type="hidden" name="csrf_value" value="${_csrf.token}"/>
        <security:authorize access="hasRole('ROLE_USER')">
            <a class='cart-link' href='#menu'>
      <span class='cart-text fontawesome-shopping-cart'>
        <span>Cart</span>
      </span>
                <span class='returnToShop'>&larr; Сховати</span>
                <span class='cart-quantity empty'>0</span>
            </a>
        </security:authorize>
    </header>
    <section class='shop'></section>
    <footer>
        <p>Lovelystickersua(c) "its footrer"</p>
    </footer>
</div>
<!-- / Product Templates for Shop & Cart -->
<script id='productTemplate' type='text/template'>
    <div class="product">
        <h1></h1>
        <p></p>
        <div class="button">
            <div class="price"></div>
            <%--<security:authorize access="hasRole('ROLE_USER')">--%>
                <a class="addtocart">
                    <div class="add">Зберегти</div>
                    <div class="added">Збережено!</div>
                </a>
            <%--</security:authorize>--%>
        </div>
    </div>
</script>
<script id='cartItem' type='text/template'>
    <li>
        <div class="cart-product">
            <input class="quantity" value="1">
        </div>
        <div class="cart-description">
            <h3></h3>
            <span class="subtotal"></span>
        </div>
    </li>
</script>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src="/js/store.js"></script>
</body>
</html>
