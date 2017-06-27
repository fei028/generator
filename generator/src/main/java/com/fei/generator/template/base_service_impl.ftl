package ${base_service_package};

import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.springframework.transaction.annotation.Transactional;
<#if dependProjectCommonPackage == "">
import ${common_package}.dao.BaseDao;
import ${common_package}.common.page.SimplePage;
import ${common_package}.query.BaseQuery;
import ${common_package}.utils.CollectionUtils;
import ${common_package}.utils.SearchUtils;
import ${common_package}.utils.Underline2CamelUtils;
import ${common_package}.web.exception.CustomException;
<#else>
import ${dependProjectCommonPackage}.common.dao.BaseDao;
import ${dependProjectCommonPackage}.common.page.SimplePage;
import ${dependProjectCommonPackage}.common.query.BaseQuery;
import ${dependProjectCommonPackage}.common.utils.CollectionUtils;
import ${dependProjectCommonPackage}.common.utils.SearchUtils;
import ${dependProjectCommonPackage}.common.utils.Underline2CamelUtils;
import ${dependProjectCommonPackage}.common.web.exception.CustomException;
</#if>

/**
 * 
 * @author ${author}
 *
 */
public abstract class BaseServiceImpl<T, PK extends Serializable, Q extends BaseQuery> implements BaseService<T, PK, Q>{

	private static final int DEA_MAX_NUM_PAGE = 5;
	
	protected static Logger logger;
	protected BaseDao<T, PK, Q> baseDao;
	private Class<?> clazz;
	private String keyPropertyName;

	public BaseServiceImpl() {
		super();
		setLogger();
		ParameterizedType parameterizedType = (ParameterizedType) this.getClass().getGenericSuperclass();//获取当前new对象的泛型的父类类型  
	    clazz = (Class<?>) parameterizedType.getActualTypeArguments()[2];
	    logger.debug("clazz:" + clazz);
	    keyPropertyName = getKeyPropertyName();
	    logger.debug("设置主键属性名称keyPropertyName:" + keyPropertyName);
	}

	@Override
	public T getObjectByKey(PK pk) {
		if(pk != null){
			return baseDao.selectByKey(pk);
		}
		return null;
	}

	@Override
	@Transactional(readOnly = false)
	public void update(T t) {
		if(t != null){
			baseDao.update(t);
		}
	}

	@Override
	@Transactional(readOnly = false)
	public PK add(T t) {
		if(t != null){
			baseDao.insertSelective(t);
			return getKeyValue(t);
		}
		return null;
	}

	@Override
	@Transactional(readOnly = false)
	public void batchInsert(List<T> ts) {
		if(CollectionUtils.isNotNullOrEmpty(ts)){
			baseDao.batchInsert(ts);
		}
	}

	@Override
	@Transactional(readOnly = false)
	public void deleteByKeys(List<PK> pks) {
		if(CollectionUtils.isNotNullOrEmpty(pks)){
			baseDao.deleteByKeys(pks);
		}
	}

	@Override
	public SimplePage search(Q q) throws CustomException {
		return search(q, DEA_MAX_NUM_PAGE);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public SimplePage search(Q q, int maxNumOfPage) throws CustomException {
		// if q 为null,则查询全部
		if(q == null){
			try {
				q = (Q) clazz.newInstance();
			} catch (InstantiationException | IllegalAccessException e) {
				throw new CustomException("实例化query对象失败");
			}
		}
		
		// 获取记录总数 
		long totalCount = baseDao.getCountWithCondition(q);
		// 当前页记录集合[当没有符合的记录时,放弃列表的查询]
		List<T> list = null;
		if(totalCount > 0){
			SearchUtils.handleQueryObject(q, totalCount);
			list = baseDao.selectObjectsWithCondition(q);
		} 
		SimplePage page = new SimplePage(q.getPageNo(), q.getPageSize(), q.getStartRow(), totalCount);
		page.setList(list);
		page.setMaxNumOfPage(maxNumOfPage);
		return page;
	}
	@SuppressWarnings("unchecked")
	@Override
	public boolean checkUniqueness(String property, String value, PK id) throws CustomException {
		if(StringUtils.isNotBlank(property) && StringUtils.isNotBlank(value)){
			Q q = null;
			try {
				q = (Q) clazz.newInstance();
			} catch (InstantiationException | IllegalAccessException e1) {
				throw new CustomException("实例化Query对象失败");
			}
			q.setPageNo(1);
			q.setPageSize(2);
			
			q.setFields(Underline2CamelUtils.camel2Underline(keyPropertyName) + "," + Underline2CamelUtils.camel2Underline(property));
			
			logger.warn("您设置的keyPropertyName:{},如果您没有自己设置,请重写该方法getKeyPropertyName()", keyPropertyName);
			
			Field field = null;
			try {
				field = q.getClass().getDeclaredField(property);
				if(field != null){
					field.setAccessible(true);
					field.set(q, value);
					logger.debug("属性名称:{},值:{}", property, value);
				} else {
					logger.error("属性名称(property):{}, q.getClass().getDeclaredField(property)获取Field为null", property);
					throw new CustomException("检查属性名称是否设置错误");
				}
			} catch (NoSuchFieldException | SecurityException | IllegalArgumentException | IllegalAccessException e) {
				logger.error("反射获取Field异常:", e);
				throw new CustomException("检查属性名称是否设置错误");
			}
			
			List<T> ts = baseDao.selectObjectsWithCondition(q);
			if(CollectionUtils.isNullOrEmpty(ts)){
				return true;
			} else {
				if(ts.size() == 1 ){
					T t = ts.get(0);
					return getKeyValue(t).equals(id);
				}
			}
		}
		return false;
	}
	
	/**
	 * 获取当前对象主键值
	 * @param t 当前对象
	 * @return
	 */
	protected abstract PK getKeyValue(T t);

	public abstract void setLogger();
	
	
	public void setBaseDao(BaseDao<T, PK, Q> baseDao){
		if(baseDao == null){
			throw new RuntimeException("baseDao不能设置空值");
		}
		this.baseDao = baseDao;
	}

	protected String getKeyPropertyName() {
		return "id";
	}
	
}
