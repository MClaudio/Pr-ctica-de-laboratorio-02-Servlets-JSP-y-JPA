# Pr-ctica-de-laboratorio-02-Servlets-JSP-y-JPA
Práctica de laboratorio 02: Servlets, JSP y JPA

Desarrollar una aplicación con tecnología JEE para gestionar una agenda telefónica en la web.
Para el desarrollo de la aplicación se toma en cuenta el diagrama de clases propuesto en la práctica:

Diagrama de Clases

![imagen](https://user-images.githubusercontent.com/15615518/82845115-d268cf80-9ea8-11ea-9fc8-97e7700a58f9.png)

Diagrama Entidad Relación

![imagen](https://user-images.githubusercontent.com/15615518/82845132-e280af00-9ea8-11ea-96e1-9f3d836a1702.png)

Para la conexión y persistencia a la base de datos se usa JPA de java iniciando un archivo de persistencia el cual se encargará de persistir los datos en la base de datos.
```xml

<?xml version="1.0" encoding="UTF-8"?>
<persistence version="2.2" xmlns="http://xmlns.jcp.org/xml/ns/persistence" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/persistence http://xmlns.jcp.org/xml/ns/persistence/persistence_2_2.xsd">
	<persistence-unit name="Agenda" transaction-type="RESOURCE_LOCAL">
	<provider>org.eclipse.persistence.jpa.PersistenceProvider</provider>
	<class>ec.edu.ups.modelo.User</class>
	<class>ec.edu.ups.modelo.Phone</class>
		<properties>
			<property name="eclipselink.ddl-generation" value="create-tables" />		
			<property name="javax.persistence.jdbc.driver" value="com.mysql.cj.jdbc.Driver"/>
			<property name="javax.persistence.jdbc.url" value="jdbc:mysql://localhost:3306/db_jpaejemplo?serverTimezone=UTC"/>
			<property name="javax.persistence.jdbc.user" value="root"/>
			<property name="javax.persistence.jdbc.password" value="admin"/>
		</properties>
	</persistence-unit>
</persistence>
```
Se crea la estructura DAO para manipular la persistencia de los datos y para que el proyecto sea flexible a largo plazo.

![imagen](https://user-images.githubusercontent.com/15615518/82845176-1d82e280-9ea9-11ea-861b-dd76243dce96.png)

Para este paso es importante contar con la librería de conexión para MySQL de esta forma podremos acceder a la base de datos para crear el CRUD de usuarios y teléfonos también incluiremos las librerías de JSTL para la manipulación de archivos JSP y por último agregaremos las librerias de Eclipse Link y la librería de persistencia para JPA todas estas librerías se colocan en la carpeta WEB-INF para que java los pueda reconocer.
 

![imagen](https://user-images.githubusercontent.com/15615518/82845311-9f730b80-9ea9-11ea-8c77-c91755021859.png)

Para el registro de usuarios se proporciona un formulario de registro con los datos necesarios.

![imagen](https://user-images.githubusercontent.com/15615518/82845330-b31e7200-9ea9-11ea-957a-b55bb19f563d.png)

En el siguiente formulario el usuario tendrá que ingresar sus datos como nombre, apellido, cedula, correo y una contraseña para acceder al panel de usuarios el servlet que gestiona el registro de usuario se encargara de almacenar en la base de datos.
El servlet tomará los datos por POST y procederá a realizar la conexión a la base de datos mediante la arquitectura DAO para realizar la inserción de los datos.
```java
protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String cedula = request.getParameter("cedula");
        String mail = request.getParameter("mail");
        String pass = request.getParameter("pass");

        UserDAO userDao = DAOFactory.getDAOFactory().getUserDAO();
        User user = new User(cedula, nombre, apellido, mail, pass);
        if (userDao.create(user)) {
            response.sendRedirect("login");
        }else{
            response.sendRedirect("registro");
        }      
    }
```
Una vez registrado el usuario podrá iniciar sesión con su correo y su contraseña el servlet de java administrara el registro y la validación de usuario si es que existe en la base de datos a continuación presento el servlet que gestiona el inicio de sesión.
```java
protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String mail = request.getParameter("mail");
        String pass = request.getParameter("pass");
        
        UserDAO userDao = DAOFactory.getDAOFactory().getUserDAO();
        User user = userDao.findUser(mail, pass);
        if (user != null) {
            System.out.println("usuario encontrado");
            HttpSession session = request.getSession(true);
            System.out.println("Sesion iniciada con id " + request.getSession().getId());
            session.setAttribute("sesionID", String.valueOf(session.getId()));
            session.setAttribute("userID", user.getCedula());
            
            response.sendRedirect("my-agenda");
            
        }else{
            response.sendRedirect("login");
        }     
    }
```
El método findUser se crea en el UserDao este método recibirá un correo y una contraseña para verificar en la base de datos si es que encuentra un usuario se creara las variables de sesión y redirige a su perfil.
En la siguiente imagen se presenta la página del usuario.

![imagen](https://user-images.githubusercontent.com/15615518/82845448-45267a80-9eaa-11ea-9ea3-c1a11db3003d.png)

En este apartado el usuario podrá ver sus contactos, agregar, eliminar y editar cada número registrado por él. Lo métodos de el CRUD del teléfono se presenta a continuación.
Registro de teléfono.

![imagen](https://user-images.githubusercontent.com/15615518/82845539-946cab00-9eaa-11ea-8451-0023d3cc02e4.png)

```java
 protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String numero = request.getParameter("numero");
        String tipo = request.getParameter("tipo");
        String operadora = request.getParameter("operadora");

        UserDAO userDao = DAOFactory.getDAOFactory().getUserDAO();
        User user = userDao.findById(String.valueOf(request.getSession().getAttribute("userID")));
        Phone phone = new Phone(numero, tipo, operadora, user);
        user.addPhone(phone);
        userDao.update(user);
        response.sendRedirect("my-agenda");
    }
```
Editar teléfono.

![imagen](https://user-images.githubusercontent.com/15615518/82845578-c120c280-9eaa-11ea-9fc6-927c0ef9db1f.png)
```java
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
```
 
Eliminar teléfono.
Para eliminar el teléfono se hace uso del método GET del servlet que gestiona el editar teléfono.

![imagen](https://user-images.githubusercontent.com/15615518/82845634-ec0b1680-9eaa-11ea-9c23-d332f9f56cb7.png)

```java
protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String sesion = request.getParameter("delete");
        String id = request.getParameter("idTelefono");
        if (sesion != null && id != null) {
            if (sesion.equals("true")) {  
            	UserDAO userDao = DAOFactory.getDAOFactory().getUserDAO();
                User user = userDao.findById(String.valueOf(request.getSession().getAttribute("userID")));

                PhoneDAO phoneDao = DAOFactory.getDAOFactory().getPhoneDAO();
                Phone phone = phoneDao.findById(Integer.parseInt(id));
                user.deletePhone(phone);

                userDao.update(user);
                response.sendRedirect("my-agenda");
            }
        }
    }
```

En la sección publica los usuarios podrán buscar a usuarios registrados en la plataforma para visualizar sus números.

![imagen](https://user-images.githubusercontent.com/15615518/82845702-312f4880-9eab-11ea-9a9f-105d9c884297.png)

El servlet que gestiona la búsqueda recibirá por GET el correo del usuario o la cedula para posteriormente hacer la consulta a la base de datos.
```java
protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String contexto = request.getParameter("usuario");
        
        UserDAO userDao = DAOFactory.getDAOFactory().getUserDAO();
        List<User> users = userDao.findByIdOrMail(contexto);
        //System.out.println("Usuarios "+users.toString());
        
        request.setAttribute("users", users);
        getServletContext().getRequestDispatcher("/views/jsp/busqueda.jsp").forward(request, response);
        //System.out.println("users: "+users.toString());
    }
```

A continuación, presentaremos los métodos de conexión a la base de datos los métodos referentes al teléfono ya que de los usuarios es prácticamente igual.
El JPA crea las tablas automáticamente en la base de datos según nuestras clases por lo que mostraremos los métodos de persistencia.
Metodo para crear los datos.
```java
public boolean create(T entity) {
		em.getTransaction().begin();
		try {
			em.persist(entity);
			em.getTransaction().commit();
			return true;
		} catch (Exception e) {
			System.out.println(">>>>> Error: JPAgenericDao.create "+e);
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			return false;
		}
	}
```
Buscar un dato por id.
```java
public T findById(ID id) {
		em.getTransaction().begin();
		return em.find(persistenClass, id);
	}
```
Actualizar un objeto.
```java
public boolean update(T entity) {
		em.getTransaction().begin();
		try {
			em.merge(entity);
			em.getTransaction().commit();
			return true;
		} catch (Exception e) {
			System.out.println(">>>>> Error: JPAgenericDao.update "+e);
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			return false;
		}
	}
```
Eliminar un objeto.
```java
public boolean delete(T entity) {
		em.getTransaction().begin();
		try {
			em.remove(entity);
			em.getTransaction().commit();
			return true;
		} catch (Exception e) {
			System.out.println(">>>>> Error: JPAgenericDao.delete "+e);
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			return false;
		}
	}
```
Buscar los teléfonos de un usuario.
```java
public List<Phone> findByUserId(String cedula) {
        String jpql = "FROM Phone p WHERE p.user_cedula = '" + cedula + "'";
        List<Phone> phones = (List<Phone>) em.createQuery(jpql).getResultList();
        return phones;  
	}
``` 
Listar los teléfonos buscados por un número, esta acción se realiza mediante el filtrado en la lista de teléfonos de un usuario debido a que cargamos la lista al realizar la petición JPA cargara automáticamente la lista de los telefonos.
```java
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
```
Lo que cabe recalcar es para que JPA funcione las clases se tiene que modificar con el @Entity
User Class
```java
@Entity
public class User implements Serializable{
    private static final long serialVersionUID = 1L;
    
    @Id
    private String cedula;
    
    private String nombre;
    
    private String apellido;
    
    @Column(unique = true, nullable = false)
    private String correo;
    
    @Column(nullable = false)
    private String password;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Phone> telefonos;
```
Phone Class
```java
@Entity
public class Phone implements Serializable{
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String numero;
    
    private String tipo;

    private String operadora;
    
    @ManyToOne()
    private User user;
```
Todos estos métodos permiten listar, agregar, editar y eliminar un teléfono dependiendo del usuario propietario de dicho número.
Para finalizar visualizaremos la pagina índex donde se muestra información de la plataforma.
 
![imagen](https://user-images.githubusercontent.com/15615518/82846042-96376e00-9eac-11ea-9abc-8ccb7b17c69b.png)

![imagen](https://user-images.githubusercontent.com/15615518/82846077-ba934a80-9eac-11ea-9302-e74a68685446.png)

### RESULTADO(S) OBTENIDO(S):
Implementar JPA nos ahora mucho tiempo ya que no creamos sentencias SQL JPA persiste los datos de manera automática.
### CONCLUSIONES:
BookContact es el primer sitio creado con el modelo JPA para la persistencia de datos de la base de datos MySQL este modelo hace que sea sencillo el CRUD en la base de datos y mantener un orden en la programación teniendo por separado todos los módulos que conforman la lógica de negocio.
### RECOMENDACIONES:
JPA requiere que las clases estén bien programadas y con las relaciones correctas también es importante recalcar que a la hora de persistir los datos tengamos bien realizadas las relaciones de uno a muchos.

