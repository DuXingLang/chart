<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="org.jfree.chart.ChartFactory" %>
<%@ page import="org.jfree.chart.JFreeChart" %>
<%@ page import="org.jfree.data.category.DefaultCategoryDataset" %>
<%@ page import="org.jfree.chart.plot.PlotOrientation" %>
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
	String sql = "select * from fruits";
	Connectdb baseConnection = new Connectdb();
	ResultSet rs = baseConnection.executeQuery(sql);//ִ��SQL��䲢ȡ�ý����
%>

<%
StandardChartTheme standardChartTheme = new StandardChartTheme("CN");		//����������ʽ
standardChartTheme.setExtraLargeFont(new Font("����", Font.BOLD, 20)); 		//���ñ�������
standardChartTheme.setRegularFont(new Font("΢���ź�", Font.PLAIN, 15)); 		//����ͼ��������
standardChartTheme.setLargeFont(new Font("΢���ź�", Font.PLAIN, 15)); 		//�������������
ChartFactory.setChartTheme(standardChartTheme);							//����������ʽ
DefaultCategoryDataset dataset1=new DefaultCategoryDataset();
while(rs.next()){
	dataset1.addValue(MyTools.strToint(rs.getString("count")), rs.getString("province"), rs.getString("name"));
}
/*
dataset1.addValue(200,"����","ƻ��");
dataset1.addValue(150,"����","�㽶");
dataset1.addValue(450,"����","����");

dataset1.addValue(400,"����","ƻ��");
dataset1.addValue(200,"����","�㽶");
dataset1.addValue(150,"����","����");

dataset1.addValue(150,"����","ƻ��");
dataset1.addValue(350,"����","�㽶");
dataset1.addValue(200,"����","����");
*/
//����JFreeChart�����ͼ�����
JFreeChart chart=ChartFactory.createBarChart3D(
									"ˮ������ͼ",		//ͼ�����
									"ˮ��",		//x�����ʾ����
									"����",			//y�����ʾ����
									dataset1,	//���ݼ�
									PlotOrientation.VERTICAL,//ͼ����(��ֱ)
									true,		//�Ƿ����ͼ��
									false,		//�Ƿ������ʾ
									false		//�Ƿ����URL
									);
//����ͼ����ļ���
// �̶��÷�
ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
String fileName=ServletUtilities.saveChartAsPNG(chart,400,270,info,session);
String url=request.getContextPath()+"/servlet/DisplayChart?filename="+fileName;
%>
<html>

  <head>
    <title>��������ͼ</title>
  </head>
  
  <body topmargin="0">
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;<img src="<%=url %>"></td>
  </tr>
</table>
  </body>
  
</html>
