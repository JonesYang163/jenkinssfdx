/**
 * @Descripttion: 相似项目前提条件判断A类型
 * @version: 1.0.0
 * @@Company: DCIT-SH
 * @Author: Sunny Chen
 * @Date: 2019-09-02 16:50:20
 * @LastEditors: Sunny Chen
 * @LastEditTime: 2019-09-26 18:13:48
 */
public class PrerequisiteRuleCondition implements Schedulable {

/*
 * @name: Sunny Chen
 * @test: test font
 * @msg: 这是由Sunny Chen创建.
 * @param {ctx}
 * @return: void
 */
public void execute(SchedulableContext ctx) {

	// 通过SOQL获取项目名称长度超过6的对象记录
	List<Opportunity> oppList = [SELECT Id,Name FROM Opportunity WHERE ProjectNameConflictCondition__c = true];

	// 用于拼接记录相似项目组名称
	String similarProjectName = '';

	// 用于统计出现几个字符
	Integer conunt = 0;

	// 用于创建相似项目组
	for (Opportunity opp : oppList) {
		// 取集合其中一个与集合其他项目做对比
		for (Opportunity oopTwo : oppList) {
			// 判断是否项目名称重复比较
			if(opp.Name != oopTwo.Name) {
				// 根据集合其中一个的长度赋值相似项目组名称
				for (Integer i = 0; i < opp.Name.length(); i++) {
					// 字符个数是否
					if (conunt < 4) {
						// 如果下标等于0,则获取第一个字符
						if (i == 0) {
							if (oopTwo.Name.contains(opp.Name.substring(0,1))) {
								similarProjectName += opp.Name.charAt(i);
								conunt++;
							}
						} else {// 如果下标不等于0,则获取指定的字符
							if (oopTwo.Name.contains(opp.Name.substring(i,i+1))) {
								similarProjectName += opp.Name.charAt(i);
								conunt++;
							}
						}
					}
				}

				// 创建相似项目组对象
				SimilarProjectGroup__c spgc = new SimilarProjectGroup__c();
				// 创建相似项目组名称
				spgc.Name = similarProjectName;
				// 相似项目组名称回复初始值
				similarProjectName = '';
				// 用于统计出现几个字符回复初始值
				conunt = 0;
				// 执行DML添加相似项目组
				insert spgc;
			} else {
				System.debug('项目名称重复');
			}
		}
	}

}

}