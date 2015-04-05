<%@ page pageEncoding="utf-8"%>
<%@page import="com.liferay.portal.kernel.util.StringPool"%>
<%@page import="javax.portlet.PortletPreferences"%>
<%@page import="com.njshido.component.ShidoNavigationConfigurationAction" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://liferay.com/tld/security" prefix="liferay-security"%>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme"%>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui"%>

<portlet:defineObjects />

<%
	PortletPreferences preferences = renderRequest.getPreferences();
	String height = preferences.getValue(ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_HEIGHT, ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_HEIGHT_DEFAULT_VAL);
	String bgColor = preferences.getValue(ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_BG_COLOR, ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_BG_COLOR_DEFAULT_VAL);
	String fontColor = preferences.getValue(ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_FONT_COLOR, ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_FONT_COLOR_DEFAULT_VAL);
	String fontSize = preferences.getValue(ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_FONT_SIZE, ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_FONT_SIZE_DEFAULT_VAL);
	
	String[] titles = preferences.getValues(ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_TITLE, StringPool.EMPTY_ARRAY);
	String[] links = preferences.getValues(ShidoNavigationConfigurationAction.SHIDO_NAVIGATION_LINK, StringPool.EMPTY_ARRAY);
%>
<div id="<portlet:namespace/>shido-navigation" class="shido-navigation">
	<table style="height:<%= height%>px;background-color:<%= bgColor%>;">
		<tr>
<% 
	for(int i = 0; i < titles.length; i++) {
%>		
			<td align="center">
				<a href="<%= links[i]%>">
					<span style="color:<%= fontColor%>;font-size:<%= fontSize%>"><%= titles[i].replaceAll("\\n", "<br/>")%></span>
				</a>
			</td>
<%
	}
%>
		</tr>
	</table>
</div>
