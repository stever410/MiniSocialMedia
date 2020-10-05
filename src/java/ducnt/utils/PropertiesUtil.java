/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ducnt.utils;

import java.io.IOException;
import java.io.Serializable;
import java.util.Properties;
import javax.servlet.ServletContext;

/**
 *
 * @author ngota
 */
public class PropertiesUtil implements Serializable {

    private static final String DISPATCHER_PROPERTIES = "/WEB-INF/dispatcher.properties";
    private static final String PERMISSION_PROPERTIES = "/WEB-INF/permission.properties";
    private ServletContext ctx;
    
    public PropertiesUtil(ServletContext ctx) {
        this.ctx = ctx;
    }

    public String getDispatcherValue(String key) throws IOException {
        Properties prop = new Properties();
        prop.load(ctx.getResourceAsStream(DISPATCHER_PROPERTIES));
        return prop.getProperty(key);
    }
    
    public String getPermissionValue(String key) throws IOException {
        Properties prop = new Properties();
        prop.load(ctx.getResourceAsStream(PERMISSION_PROPERTIES));
        return prop.getProperty(key);
    }
}
