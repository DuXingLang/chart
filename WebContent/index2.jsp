<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="org.jfree.chart.ChartFactory" %>
<%@ page import="org.jfree.chart.JFreeChart" %>
<%@ page import="org.jfree.data.general.DefaultPieDataset" %>
<%@ page import="org.jfree.chart.entity.StandardEntityCollection" %>
<%@ page import="org.jfree.chart.ChartRenderingInfo" %>
<%@ page import="org.jfree.chart.servlet.ServletUtilities" %>
<%@ page import="org.jfree.data.category.DefaultCategoryDataset"%>
<%@ page import="org.jfree.chart.StandardChartTheme"%>
<%@ page import="java.awt.Font"%>
<%@ page import="toolbean.Connectdb"%>
<%@ page import="java.sql.*"%>
<%@ page import="toolbean.MyTools"%>

<%
	String sql = "select * from forum";
	Connectdb baseConnection = new Connectdb();
	ResultSet rs = baseConnection.executeQuery(sql);//执行SQL语句并取得结果集
%>

<%
StandardChartTheme standardChartTheme = new StandardChartTheme("CN");		//创建主题样式
standardChartTheme.setExtraLargeFont(new Font("隶书", Font.BOLD, 20)); 		//设置标题字体
standardChartTheme.setRegularFont(new Font("微软雅黑", Font.PLAIN, 15)); 		//设置图例的字体
standardChartTheme.setLargeFont(new Font("微软雅黑", Font.PLAIN, 15)); 		//设置轴向的字体
ChartFactory.setChartTheme(standardChartTheme);							//设置主题样式

DefaultPieDataset dataset1=new DefaultPieDataset();
while(rs.next()){
	dataset1.setValue(rs.getString("columns"), MyTools.strToint(rs.getString("count")));
}
/*
dataset1.setValue("ASP专区",200);
dataset1.setValue("PHP专区",150);
dataset1.setValue("Java专区",450);
dataset1.setValue("DoNet专区",400);
*/
//创建JFreeChart组件的图表对象
JFreeChart chart=ChartFactory.createPieChart(
									"论坛版块人气指数比例图",	//图表标题
									dataset1,				//数据集
									true,					//是否包含图例
									false,					//是否包含图例说明
									false					//是否包含连接
									);
//设置图表的文件名
// 固定用法
ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
String fileName=ServletUtilities.saveChartAsPNG(chart,400,270,info,session);
String url=request.getContextPath()+"/servlet/DisplayChart?filename="+fileName;
%>

<html>
  <head>
    <title>绘制饼形图</title>
  </head>
  
  <body topmargin="0">
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;<img src="<%=url%>">
	</td>
  </tr>
</table>
  </body>
  
</html>
