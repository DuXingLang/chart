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
	ResultSet rs = baseConnection.executeQuery(sql);//ִ��SQL��䲢ȡ�ý����
%>

<%
StandardChartTheme standardChartTheme = new StandardChartTheme("CN");		//����������ʽ
standardChartTheme.setExtraLargeFont(new Font("����", Font.BOLD, 20)); 		//���ñ�������
standardChartTheme.setRegularFont(new Font("΢���ź�", Font.PLAIN, 15)); 		//����ͼ��������
standardChartTheme.setLargeFont(new Font("΢���ź�", Font.PLAIN, 15)); 		//�������������
ChartFactory.setChartTheme(standardChartTheme);							//����������ʽ

DefaultPieDataset dataset1=new DefaultPieDataset();
while(rs.next()){
	dataset1.setValue(rs.getString("columns"), MyTools.strToint(rs.getString("count")));
}
/*
dataset1.setValue("ASPר��",200);
dataset1.setValue("PHPר��",150);
dataset1.setValue("Javaר��",450);
dataset1.setValue("DoNetר��",400);
*/
//����JFreeChart�����ͼ�����
JFreeChart chart=ChartFactory.createPieChart(
									"��̳�������ָ������ͼ",	//ͼ�����
									dataset1,				//���ݼ�
									true,					//�Ƿ����ͼ��
									false,					//�Ƿ����ͼ��˵��
									false					//�Ƿ��������
									);
//����ͼ����ļ���
// �̶��÷�
ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
String fileName=ServletUtilities.saveChartAsPNG(chart,400,270,info,session);
String url=request.getContextPath()+"/servlet/DisplayChart?filename="+fileName;
%>

<html>
  <head>
    <title>���Ʊ���ͼ</title>
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
