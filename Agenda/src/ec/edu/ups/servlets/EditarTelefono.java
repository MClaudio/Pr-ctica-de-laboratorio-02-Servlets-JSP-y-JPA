/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.edu.ups.servlets;

import ec.edu.ups.dao.DAOFactory;
import ec.edu.ups.dao.PhoneDAO;
import ec.edu.ups.modelo.Phone;
import ec.edu.ups.modelo.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author claum
 */
@WebServlet(name = "EditarTelefono", urlPatterns = {"/editar-telefono"})
public class EditarTelefono extends HttpServlet {



    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String sesion = request.getParameter("delete");
        String id = request.getParameter("idTelefono");
        if (sesion != null && id != null) {
            if (sesion.equals("true")) {  
                PhoneDAO phoneDao = DAOFactory.getDAOFactory().getPhoneDAO();
                Phone phone = phoneDao.findById(Integer.parseInt(id));
                //phone.getUser().deletePhone(phone);
                phoneDao.delete(phone);
                //System.out.println("telefono a eliminar.. " + id );
                response.sendRedirect("my-agenda");
            }
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String numero = request.getParameter("numero");
        String tipo = request.getParameter("tipo");
        String operadora = request.getParameter("operadora");
        String idTelefono = request.getParameter("idtel");

        PhoneDAO phoneDao = DAOFactory.getDAOFactory().getPhoneDAO();
        Phone phone = phoneDao.findById(Integer.parseInt(idTelefono));
        User user = DAOFactory.getDAOFactory().getUserDAO().findById(String.valueOf(request.getSession().getAttribute("userID")));
        phone.setUser(user);
        phone.setNumero(numero);
        phone.setTipo(tipo);
        phone.setOperadora(operadora);
        
        phoneDao.update(phone);

        response.sendRedirect("my-agenda");
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
