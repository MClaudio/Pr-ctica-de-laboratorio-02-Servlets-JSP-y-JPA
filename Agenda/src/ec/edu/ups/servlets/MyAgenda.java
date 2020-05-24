/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.edu.ups.servlets;

import ec.edu.ups.dao.DAOFactory;
import ec.edu.ups.dao.PhoneDAO;
import ec.edu.ups.dao.UserDAO;
import ec.edu.ups.modelo.Phone;
import ec.edu.ups.modelo.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author claum
 */
@WebServlet(name = "MyAgenda", urlPatterns = { "/my-agenda" })
public class MyAgenda extends HttpServlet {

	// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
	// + sign on the left to edit the code.">
	/**
	 * Handles the HTTP <code>GET</code> method.
	 *
	 * @param request  servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String sesion = request.getParameter("logout");
		String telefono = request.getParameter("mi-telefono");

		if (sesion != null) {
			if (sesion.equals("true")) {
				request.getSession().invalidate();
				response.sendRedirect("/Agenda");

			}
		} else {
			ServletContext aplicacion = request.getServletContext();
			UserDAO userDao = DAOFactory.getDAOFactory().getUserDAO();
			User user = (User) userDao.findById(String.valueOf(request.getSession().getAttribute("userID")));
			System.out.println("cantidad de telefonos: "+user.getTelefonos().size());

			if (telefono != null) {
				aplicacion.setAttribute("search", "true");
				
				List<Phone> result = user.getTelefonos().stream()
					    .filter(p -> Objects.equals(p.getNumero(), telefono))
					    .collect(Collectors.toList());
					
				user.setTelefonos(result);
		
			} else {
				aplicacion.setAttribute("search", "false");
			}
			request.setAttribute("user", user);
			getServletContext().getRequestDispatcher("/views/jsp/my-agenda.jsp").forward(request, response);
		}
	}

	/**
	 * Handles the HTTP <code>POST</code> method.
	 *
	 * @param request  servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// processRequest(request, response);
	}

	/**
	 * Returns a short description of the servlet.
	 *
	 * @return a String containing servlet description
	 */
	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>

}
