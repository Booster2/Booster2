package ox.softeng.gwi;
 
import java.io.IOException;
 
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
/* @WebFilter("/LoginFilter") */
public class LoginFilter implements Filter {
 
    private ServletContext context;
     
    public void init(FilterConfig fConfig) throws ServletException {
        this.context = fConfig.getServletContext();
        this.context.log("LoginFilter initialized");
    }
     
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
 
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
         
        String uri = req.getRequestURI();
        this.context.log("Requested Resource::"+uri);
         
        HttpSession session = req.getSession(false);
         
        if(session == null || session.getAttribute("Username") == null){
            this.context.log("Unauthorized access request");
            res.setStatus(HttpServletResponse.SC_FORBIDDEN);
        }else{
            // pass the request along the filter chain
            chain.doFilter(request, response);
        }
         
         
    }
 
     
 
    public void destroy() {
        //close any resources here
    }
 
}