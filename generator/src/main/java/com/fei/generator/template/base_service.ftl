package ${base_service_package};

import java.io.Serializable;
import java.util.List;
<#if dependProjectCommonPackage == "">
import ${common_package}.common.page.SimplePage;
import ${common_package}.query.BaseQuery;
import ${common_package}.web.exception.CustomException;
<#else>
import ${dependProjectCommonPackage}.common.page.SimplePage;
import ${dependProjectCommonPackage}.common.query.BaseQuery;
import ${dependProjectCommonPackage}.common.web.exception.CustomException;
</#if>

/**
 * 
 * @author ${author}
 *
 */
public interface BaseService<T, PK extends Serializable, Q extends BaseQuery> {
	
	public T getObjectByKey(PK pk);

	public void update(T t);
	
	public PK add(T t);

	public void batchInsert(List<T> ts);
	
	public void deleteByKeys(List<PK> pks);
	
	SimplePage search(Q q) throws CustomException;
	/**
	 * 
	 * @param q 查询对象
	 * @param maxNumOfPage 最大页面显示的页号数量
	 * @return
	 * @throws CustomException
	 */
	SimplePage search(Q q, int maxNumOfPage) throws CustomException;
	
	/**
	 * 检查某个属性值在数据库中的唯一性(排除自身),查找不到则说明该值插入之后唯一
	 * @param property 属性名称
	 * @param value 属性值
	 * @param id 主键(不为null时，排除主键值等于该id的记录)
	 * @return true[数据库中除其本身以外没有该值]
	 */
	boolean checkUniqueness(String property, String value, PK id) throws CustomException;
}
