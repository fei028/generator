package ${controller_package};


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import ${service_package}.${className}Service;

/**
 * 
 * @author ${author}
 *
 */
@Controller
public class ${className}Controller {
	
	@Autowired
	private ${className}Service ${className?uncap_first}Service;
}
