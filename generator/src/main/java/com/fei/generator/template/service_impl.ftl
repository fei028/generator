<#-- service层 实现文件-->
package ${service_impl_package};

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ${dao_package}.${className}Dao;
import ${service_package}.${className}Service;
/**
 * 
 * @author fei
 *
 */
@Service
@Transactional(readOnly = true)
public class ${className}ServiceImpl implements ${className}Service{

	@Autowired
	private ${className}Dao ${className?uncap_first}Dao;
	
}
