<#-- 查询对象 模版文件 -->
package ${base_query_package};

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


/**
 * 
 * @author ${author}
 *
 */
public class BaseQuery {

	private static final int DEFAULT_PAGESIZE = 10;
	/************ 自定义查询字段列表 ******************/
	/**自定义查询字段列表,形如: 字段1,字段2...*/
	private String fields;

	public String getFields() {
		return fields;
	}

	public void setFields(String fields) {
		this.fields = fields;
	}

	/*********** Limit ***********************/
	/** 页号，默认为1 */
	private Integer pageNo = 1;
	/** 起始行 */
	private Long startRow;
	/** 每页数量，默认为10 */
	private Integer pageSize = DEFAULT_PAGESIZE;

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
	
	    if(pageNo != null){
			this.pageNo = pageNo <= 0 ? 1 : pageNo;
			this.startRow = (long) ((this.pageNo - 1) * pageSize);
		}
	}

	public Long getStartRow() {
		return startRow;
	}

	public void setStartRow(Long startRow) {
		this.startRow = startRow;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
	
		if(pageSize == null){
			this.pageSize = DEFAULT_PAGESIZE;
		}
		this.pageSize = pageSize <= 0 ? DEFAULT_PAGESIZE : pageSize;
		this.startRow = (long) ((this.pageNo - 1) * this.pageSize);
	}
	
	/*********** Group By ***********************/
	protected List<GroupField> groupByFields = new ArrayList<>(); 
	
	public List<GroupField> getGroupByFields() {
		return groupByFields;
	}

	public void setGroupByFields(List<GroupField> groupByFields) {
		this.groupByFields = groupByFields;
	}

	/**
	 * 分组字段类
	 * @author fei
	 *
	 */
	protected static class GroupField{
		/** 分组字段名 */
		private String field;
		
		public GroupField(String field) {
			this.field = field;
		}
		public String getField() {
			return field;
		}
		public void setField(String field) {
			this.field = field;
		}
	}
	
	/*********** Order By ***********************/
	protected List<OrderField> orderByFields = new ArrayList<OrderField>(); 
	
	public List<OrderField> getOrderByFields() {
		return orderByFields;
	}

	public void setOrderFields(List<OrderField> orderByFields) {
		this.orderByFields = orderByFields;
	}

	/**
	 * 排序字段类
	 * @author fei
	 *
	 */
	protected static class OrderField{
		/** 排序字段名 */
		private String field;
		/** 排序规则(升序/降序) */
		private String order;
		
		public static final String ORDER_ASC = "asc";
		public static final String ORDER_DESC = "desc";
		
		public OrderField(String field, String order) {
			this.field = field;
			this.order = order;
		}
		public String getField() {
			return field;
		}
		public void setField(String field) {
			this.field = field;
		}
		public String getOrder() {
			return order;
		}
		public void setOrder(String order) {
			this.order = order;
		}

	}
	
	private Date beginDate;
	private Date endDate;

	public Date getBeginDate() {
		return beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	private List<?> keys;
	
	public List<?> getKeys() {
		if(this.keys != null && keys.size() <= 0){
			return null;
		}
		return keys;
	}

	public void setKeys(List<?> keys) {
		if(keys != null && !keys.isEmpty()){
			Set<?> keySet = new HashSet<>(keys);
			keys = new ArrayList<>(keySet);
			if(keys.get(0).getClass().getName().equals(String.class.getName())){
				List<String> list = new ArrayList<>();
				String key = null;
				for (int i = 0; i < keys.size(); i++) {
					key = "'" + keys.get(i) + "'";// 'string'
					list.add(key);
				}
				this.keys = list;
			}else{
				this.keys = keys;
			}
		}
	}
}