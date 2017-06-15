package ${base_dao_package};

import java.io.Serializable;
import java.util.List;

import ${base_query_package}.BaseQuery;


/**
 * 
 * @author ${author}
 *
 */
public interface Base${daoSuffix}<T, PK extends Serializable, Q extends BaseQuery> {
	
	/**
	 * 新增,pojo中属性为NULL值不插入对应数据库中字段
	 * 
	 * @param t 保存的对象
	 */
	public void insertSelective(T t);

	/**
	 * 批量插入
	 * 
	 * @param ts 批量插入的对象集合
	 */
	public void batchInsert(List<T> ts);

	/**
	 * 通过主键删除
	 * 
	 * @param pk 主键
	 *            
	 */
	public void deleteByKey(PK pk);

	/**
	 * 批量删除
	 * 
	 * @param pks 主键集合
	 *            
	 */
	public void deleteByKeys(List<PK> pks);

	/**
	 * 更新,pojo中属性为NULL值不更新对应数据库中字段
	 * 
	 * @param t 更新的对象
	 */
	public void update(T t);

	/**
	 * 通过主键查询获取对象
	 * 
	 * @param pk 主键id
	 *            
	 * @return T 对象
	 */
	public T selectByKey(PK pk);

	/**
	 * 条件查询
	 * 
	 * @param q 查询对象
	 * @return 符合条件的结果集
	 */
	public List<T> selectObjectsWithCondition(Q q);

	/**
	 * 条件查询,对应结果集记录总数
	 * 
	 * @param q 查询对象
	 * @return 记录总数
	 */
	public Long getCountWithCondition(Q q);

	/**
	 * 获取符合查询条件的对象的主键集合
	 * 
	 * @param q 查询对象
	 * @return 主键集合
	 */
	public List<PK> getKeys(Q q);
}
