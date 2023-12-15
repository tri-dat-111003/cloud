package com.bookstore.customer.controller.buy;

import com.bookstore.dao.*;
import com.bookstore.entity.Order;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UpdateOrderServlet", value = "/updateOrder")
public class UpdateOrderController extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int oid = Integer.parseInt(request.getParameter("oid"));
        int uid = Integer.parseInt(request.getParameter("uid"));
        OrderDAO orderDAO = new OrderDAO();
        orderDAO.updateOrderByStatus(oid);
        List<Order> orders = orderDAO.getOrderByIdCustomer(uid);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/store/views/myOrder.jsp").forward(request, response);
    }
}