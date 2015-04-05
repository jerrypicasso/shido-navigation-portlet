<%@page import="com.njshido.component.ShidoNavigationConfigurationAction" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://liferay.com/tld/security" prefix="liferay-security" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>

<portlet:defineObjects />

<liferay-theme:defineObjects />

<%
	String height = String.valueOf(request.getAttribute(ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_HEIGHT));
	String bgColor = String.valueOf(request.getAttribute(ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_BG_COLOR));
	String fontColor = String.valueOf(request.getAttribute(ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_FONT_COLOR));
	String fontSize = String.valueOf(request.getAttribute(ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_FONT_SIZE));
	
	String[] titles = (String[]) request.getAttribute(ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_TITLE);
	pageContext.setAttribute("titles", titles);
	String[] links = (String[]) request.getAttribute(ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_LINK);
	pageContext.setAttribute("links", links);
%>
<liferay-ui:success key="success" message="your-configuration-was-saved-sucessfully"/>
<form action="<liferay-portlet:actionURL portletConfiguration='true' />" name="<portlet:namespace/>shido_image_slider_config_form" method="post">
	<input type="button" value="添加条目" onclick="addItem();"/>
	<div style="background:#ddd;padding:20px 0px;opacity:0.8">
		<ul>
			<li>
				<span>高度：</span>
				<input name="<portlet:namespace/><%=ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_HEIGHT%>" type="number" style="width:30%;" value="<%=height%>"/>px
			</li>
			<li>
				<span>背景颜色：</span>
				<input name="<portlet:namespace/><%=ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_BG_COLOR%>" type="text" style="width:30%;" value="<%=bgColor%>"/>
			</li>
			<li>
				<span>字体颜色：</span>
				<input name="<portlet:namespace/><%=ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_FONT_COLOR%>" type="text" style="width:30%;"  value="<%=fontColor%>"/>
			</li>
			<li>
				<span>字体大小：</span>
				<input name="<portlet:namespace/><%=ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_FONT_SIZE%>" type="number" style="width:30%;"  value="<%=fontSize%>"/>px
			</li>
		</ul>
	</div>
	
	<div id="<portlet:namespace />itemsConfigurationPanel" style="padding:20px 0px;">
		<c:forEach items="${links}" var="link" varStatus="status">
			<ul id="<portlet:namespace/>link_${status.index}">
			   	<li>
			   		<span>链接地址：</span>
			   		<input required type="text" style="width:50%;" value="${link}" name="<portlet:namespace/><%=ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_LINK%>"/>
			   	</li>
			   	<li>
			   		<span>导航标题：</span>
			   		<textarea required style="width:50%;" name="<portlet:namespace/><%=ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_TITLE%>">${titles[status.index]}</textarea>
			   	</li>
			   	<li>
			   		<input type="button" value="删除" onclick="removeItem('<portlet:namespace/>link_${status.index}')"/>
			   	</li>
		   	</ul>
		</c:forEach>
	</div>
	<input type="submit" value="save"/>
</form>

<script type="text/javascript">
	function addItem() {
		var itemsConfigurationPanel = $('#<portlet:namespace />itemsConfigurationPanel');
		var id = new Date().getTime();
		var section = ['<ul id="'+ id +'">',
					   '<li><span>链接地址：</span><input required type="text" style="width:50%;" name="<portlet:namespace/><%=ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_LINK%>"/></li>',
					   '<li><span>导航标题：</span><textarea required style="width:50%;" name="<portlet:namespace/><%=ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_TITLE%>"></textarea></li>',
					   '<li><input type="button" value="删除" onclick="removeItem('+ id +')"/></li>',
					   '</ul>'];
		itemsConfigurationPanel.append(section.join(''));
	}
	
	function removeItem(id) {
		$('#' + id).remove();
	}
</script>